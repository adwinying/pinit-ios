//
//  PinItService.swift
//  PinIt
//
//  Created by Adwin Ying on 2017/12/23.
//  Copyright © 2017 Adwin Ying. All rights reserved.
//

import Foundation
import Alamofire

class PinItService {
    static let shared = PinItService()
    
    let baseURI = "http://pins.nodeapp.iadw.in/api/"
    
    func getAllPins(completion: @escaping (PinsResponse?) -> Void) {
        Alamofire.request(baseURI + "pin/all")
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
                
                do {
                    let pinsResponse = try JSONDecoder().decode(PinsResponse.self, from: data)
                    print("Serialization success")
                    completion(pinsResponse)
                } catch let error {
                    print("Serialization error:")
                    print(error)
                    completion(nil)
                    return
                }
        }
    }
}
