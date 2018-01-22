//
//  Pin.swift
//  PinIt
//
//  Created by Adwin Ying on 2017/12/23.
//  Copyright © 2017 Adwin Ying. All rights reserved.
//

import UIKit
import Foundation

struct Pin:Codable {
    var _id: String
    var title: String
    var owner: User
    var imageURL: String
    var likedBy: [String]
}

struct PinWrapper {
    var pin: Pin
    var pinImage: UIImage?
}
