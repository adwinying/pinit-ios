//
//  ImageService.swift
//  PinIt
//
//  Created by futaba239 on 2017/12/25.
//  Copyright © 2017年 Adwin Ying. All rights reserved.
//

import Foundation
import Alamofire

class ImageService {
    static let shared = ImageService()
    
    func fetchImage(URL: String, completion: @escaping (UIImage?) -> Void) {
        Alamofire.request(URL)
            .validate()
            .responseData { (response) in
                guard response.result.isSuccess else {
                    print("HTTP request error: \(String(describing: response.result.error))")
                    completion(nil)
                    return
                }
                
                guard let data = response.result.value else {
                    print("Invalid data received from server")
                    completion(nil)
                    return
                }
                
                completion(UIImage(data: data))
        }
    }
    
    func insertImageandResize(with image: UIImage, into imageView: UIImageView) {
        //let imageViewHeight = imageView.frame.size.height
        let imageViewWidth  = imageView.frame.size.width
        let imageHeight     = image.size.height
        let imageWidth      = image.size.width
        let imageRatio      = imageHeight / imageWidth
        
        print("Frame width = \(imageViewWidth)")
        print("Image size = \(imageHeight) x \(imageWidth)")
        print("Expected frame height = \(imageViewWidth * imageRatio)")

        imageView.image = image
        
        for constraint in imageView.constraints {
            if constraint.identifier == "imageViewHeightConstraint" {
                constraint.constant = imageViewWidth * imageRatio
            }
        }
        print("Actual frame height = \(imageView.frame.size.height)")
    }
}
