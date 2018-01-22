//
//  HomeCollectionViewController.swift
//  PinIt
//
//  Created by futaba239 on 2018/01/16.
//  Copyright © 2018年 Adwin Ying. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionViewController: UICollectionViewController {
    
    var pins: [Pin] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        // Configure Navigation Bar Title
        configureTitleBar()
        
        // Enable network activity indicator
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        fetchPins()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pins.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath)
    
        // Configure the cell
        cell.backgroundColor = UIColor.black
    
        return cell
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension HomeCollectionViewController {
    
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
                    self.pins = pins
                    self.collectionView?.reloadData()
                    print(pins)
                } else {
                    self.displayError(message: fetchedPinsResponse?.message)
                }
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
    }
    
    func displayError(message: String?) {
        let message = message ?? "An error has occurred, please try again later"
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
