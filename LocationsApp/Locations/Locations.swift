//
//  Locations.swift
//  LocationsApp
//
//  Created by Camilo Orjuela on 19/01/22.
//  Copyright © 2022 Camilo Orjuela. All rights reserved.
//

import Foundation

struct Location: Decodable {
    
    let type: String?
    let properties: Properties
    let geometry: Geometry
}

struct Properties: Decodable {
    
    let name: String?
    let street: String?
    let neighbourhood: String?
    let quarter: String?
    let suburb: String?
    let city: String?
    let postcode: String?
    let country: String?
    let country_code: String?
    let lon: Double?
    let lat: Double?
    let formatted: String?
    let address_line1: String?
    let address_line2: String?
    let categories: [String]?
    let details: [String]?
    let datasource: Datasource
    let place_id: String?
    
}

struct Datasource: Decodable {
    
    let sourcename: String?
    let attribution: String?
    let license: String?
    let url: String?
    
}

struct Geometry: Decodable {
    
    let type: String?
    let coordinates: [Double]?
}

