//
//  User.swift
//  PinIt
//
//  Created by Adwin Ying on 2017/12/23.
//  Copyright © 2017 Adwin Ying. All rights reserved.
//

import Foundation

struct User: Codable {
    var _id: String
    var displayName: String
    var username: String
    var profileImageURL: String
}
