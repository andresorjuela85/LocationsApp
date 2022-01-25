//
//  getLocations.swift
//  LocationsApp
//
//  Created by Camilo Orjuela on 21/01/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation
import Alamofire

class GetLocations
{
    func getLocation(completion: @escaping ([Location]?) -> Void ) {
        AF.request("https://61d4cc528df81200178a8e47.mockapi.io/locations2").responseDecodable(of: [Location].self) { response in
            guard let locationsReceived = response.value else {
                completion(nil)
                return
            }
            
            completion(locationsReceived)
            
        }
    }
}
