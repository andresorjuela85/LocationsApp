//
//  locationCell.swift
//  LocationsApp
//
//  Created by Camilo Orjuela on 21/01/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import UIKit

class locationCell: UITableViewCell {
    
    @IBOutlet weak var imageCategorie: UIImageView!
    @IBOutlet weak var addresOne: UILabel!
    @IBOutlet weak var addresTwo: UILabel!
    @IBOutlet weak var distance: UILabel!

    
    
    func configure (location: Location) {
        
        if let categories = location.properties.categories?.last {
            let categorie = categories
            switch categorie {
            case "commercial.supermarket":
                imageCategorie.image = UIImage(named: "supermarket")
            case "commercial.food_and_drink.bakery":
                imageCategorie.image = UIImage(named: "bakery")
            case "commercial.food_and_drink.butcher":
                imageCategorie.image = UIImage(named: "butcher")
            case "commercial.convenience":
                imageCategorie.image = UIImage(named: "convenience")
            case "commercial.clothing.clothes":
                imageCategorie.image = UIImage(named: "clothes")
            case "commercial.hobby.sewing_and_knitting":
                imageCategorie.image = UIImage(named: "sewing")
            case "commercial.shopping_mall":
                imageCategorie.image = UIImage(named: "mall")
            case "service.vehicle.repair.car":
                imageCategorie.image = UIImage(named: "repair")
            case "commercial":
                imageCategorie.image = UIImage(named: "commercial")
            case "commercial.food_and_drink.fruit_and_vegetable":
                imageCategorie.image = UIImage(named: "fruit")
            default:
                return
            }
        }
        addresOne.text = location.properties.address_line1
        addresTwo.text = location.properties.address_line2
        
    }
    
    func distance (latTwo: Double, longTwo: Double){
        
        let longOne = -74.08750386243297
        let latOne = 4.579956599324831
        let radius: Double = 6371
        let lat = latOne - latTwo
        let long = longOne - longTwo
        let oper = pow(sin(lat/2),2) + (cos(latOne) * cos(latTwo) * pow(sin(long/2),2))
        let operTwo = 2 * asin(sqrt(oper)) * radius
        let res = (round(operTwo * 1000)/1000)
        
        distance.text = String(res) + " Km"
    }
    
    
}

/*
 
 */
