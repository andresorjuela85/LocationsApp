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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure (location: Location) {
        
       // let dimension = CGSize(width: 60, height: 60)
        let categorie = location.properties.categories!.last
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
        addresOne.text = location.properties.address_line1
        addresTwo.text = location.properties.address_line2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

/*
 
 “”
 
 
 
 
 
 
 
 
 */
