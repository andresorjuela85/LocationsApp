//
//  Pin.swift
//  LocationsApp
//
//  Created by Camilo Orjuela on 19/01/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit
import MapKit

class Pin: NSObject, MKAnnotation   {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var thumbImage: UIImage?
  
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, category: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        let categorie = category
        switch categorie {
        case "commercial.supermarket":
            thumbImage = UIImage(named: "supermarket")
        case "commercial.food_and_drink.bakery":
            thumbImage = UIImage(named: "bakery")
        case "commercial.food_and_drink.butcher":
            thumbImage = UIImage(named: "butcher")
        case "commercial.convenience":
            thumbImage = UIImage(named: "convenience")
        case "commercial.clothing.clothes":
            thumbImage = UIImage(named: "clothes")
        case "commercial.hobby.sewing_and_knitting":
            thumbImage = UIImage(named: "sewing")
        case "commercial.shopping_mall":
            thumbImage = UIImage(named: "mall")
        case "service.vehicle.repair.car":
            thumbImage = UIImage(named: "repair")
        case "commercial":
            thumbImage = UIImage(named: "commercial")
        case "commercial.food_and_drink.fruit_and_vegetable":
            thumbImage = UIImage(named: "fruit")
        default:
            thumbImage = .none
        }
        
        super.init()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
