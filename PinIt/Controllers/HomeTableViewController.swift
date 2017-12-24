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
    
    var pins: [Pin] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure Navigation Bar Title
        configureTitleBar()
        
        // Remove table cell separator
        self.tableView.separatorColor = .clear
        
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
        let pin = pins[indexPath.row]
        cell.pinCaptionLabel.text = pin.title
        cell.likeButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 16)
        cell.likeButton.setTitle(String.fontAwesomeIcon(name: .star) + " " + String(pin.likedBy.count), for: .normal)

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
            if let fetchedPinsResponse = fetchedPinsResponse,
                fetchedPinsResponse.success,
                let pins = fetchedPinsResponse.pins {
                self.pins = pins
                self.tableView.reloadData()
            } else {
                self.displayError(message: fetchedPinsResponse?.message)
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
