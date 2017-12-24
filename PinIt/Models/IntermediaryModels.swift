//
//  IntermediaryModels.swift
//  PinIt
//
//  Created by Adwin Ying on 2017/12/24.
//  Copyright © 2017 Adwin Ying. All rights reserved.
//

import Foundation

struct PinsResponse: Codable {
    var success: Bool
    var pins: [Pin]?
    var message: String?
}
