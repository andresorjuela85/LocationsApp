//
//  PinUser.swift
//  LocationsApp
//
//  Created by Camilo Orjuela on 24/01/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit
import MapKit

class PinUser: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self.title = "My Location"
        super.init()
    }
}

/*

 */
