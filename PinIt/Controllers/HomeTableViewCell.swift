//
//  HomeTableViewCell.swift
//  PinIt
//
//  Created by Adwin Ying on 2017/12/24.
//  Copyright © 2017 Adwin Ying. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var pinCaptionLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Config table cell color
        cardView.layer.borderColor = StyleManager.borderColor().cgColor
        actionView.layer.borderColor = StyleManager.borderColor().cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
