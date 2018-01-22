//
//  ImageWrapper.swift
//  PinIt
//
//  Created by futaba239 on 2017/12/26.
//  Copyright © 2017年 Adwin Ying. All rights reserved.
//

import Foundation
import UIKit

struct ImageWrapper: Codable {
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case image
    }
    
    enum ImageWrapperError: String, Error {
        case DecodingFailed = "ImageWrapper: Decoding failed"
        case EncodingFailed = "ImageWrapper: Encoding failed"
    }
    
    init(image: UIImage) {
        self.image = image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.image)
        guard let image = UIImage(data: data) else {
            throw ImageWrapperError.DecodingFailed
        }
        
        self.image = image
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        guard let image = image,
            let data = UIImagePNGRepresentation(image) else {
                throw ImageWrapperError.EncodingFailed
        }
        
        try container.encode(data, forKey: CodingKeys.image)
    }
    
}
