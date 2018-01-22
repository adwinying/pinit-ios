//
//  HomeTableViewController.swift
//  PinIt
//
//  Created by Adwin Ying on 2017/12/23.
//  Copyright © 2017 Adwin Ying. All rights reserved.
//

import UIKit
import FontAwesome_swift

class HomeTableViewController: UITableViewController {
    
    var pins: [PinWrapper] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure Navigation Bar Title
        configureTitleBar()
        
        // Remove table cell separator
        self.tableView.separatorColor = .clear
        
        // Config resizable table cells
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 340
        
        // Enable network activity indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        fetchPins()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! HomeTableViewCell

        // Configure the cell...
        let pinWrapper = pins[indexPath.row]
        cell.pinCaptionLabel.text = pinWrapper.pin.title
        cell.likeButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 16)
        cell.likeButton.setTitle(String.fontAwesomeIcon(name: .star) + " " + String(pinWrapper.pin.likedBy.count), for: .normal)
        
        if let image = pinWrapper.pinImage {
            ImageService.shared.insertImageandResize(with: image, into: cell.pinImageView)
        }
        
        if let userImage = pinWrapper.userImage {
            cell.userImageView.image = userImage
        }
        
        return cell
    }

}

extension HomeTableViewController {
    
    func configureTitleBar() {
        let attributes = [
            NSAttributedStringKey.font: UIFont.fontAwesome(ofSize: 20),
            NSAttributedStringKey.foregroundColor: StyleManager.fontColor()
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationController?.navigationBar.topItem?.title
            = String.fontAwesomeIcon(name: .thumbTack) + " PinIt"
    }
    
    func fetchPins() {
        PinItService.shared.getAllPins(completion: { (fetchedPinsResponse) in
            DispatchQueue.main.async {
                if let fetchedPinsResponse = fetchedPinsResponse,
                    fetchedPinsResponse.success,
                    let pins = fetchedPinsResponse.pins {
                    
                    self.pins = pins.map({ (pin) -> PinWrapper in
                        return PinWrapper(pin: pin, pinImage: nil, userImage: nil)
                    })
                    
                    // Fetch each pin+user image and assign to pinWrapper
                    for i in 0..<self.pins.count {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = true
                        
                        ImageService.shared.fetchImage(URL: self.pins[i].pin.imageURL, completion: { (image) in
                            DispatchQueue.main.async {
                                if let image = image {
                                    self.pins[i].pinImage = image
                                } else {
                                    self.pins[i].pinImage = UIImage(named: "missing")
                                }
                            
                                self.tableView.reloadData()
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                        })
                        
                        ImageService.shared.fetchImage(URL: self.pins[i].pin.owner.profileImageURL) { (profileImage) in
                            DispatchQueue.main.async {
                                if let image = profileImage {
                                    self.pins[i].userImage = image
                                } else {
                                    // TODO: insert placeholder image
                                }
                                
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                        }
                    }
                    
                } else {
                    self.displayError(message: fetchedPinsResponse?.message)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        })
        
    }
    
    func displayError(message: String?) {
        let message = message ?? "An error has occurred, please try again later"
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
