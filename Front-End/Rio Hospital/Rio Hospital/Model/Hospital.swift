//
//  Hospital.swift
//  Rio Hospital
//
//  Created by Renan Almeida on 06/06/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

/// Holds basic data from the hospital entity
class Hospital {
    let name: String
    
    let address: String
    
    let neighborhood: String
    
    let postalCode: String
    
    let phone: String
    
    let coordinates: (latitude: Double, longitude: Double)
    
    // Constructor
    init(name: String, address: String, neighborhood: String,
         postalCode: String, phone: String, latitude: Double,
         longitude: Double) {

        self.name = name
        self.address = address
        self.neighborhood = neighborhood
        self.postalCode = postalCode
        self.phone = phone
        self.coordinates = (latitude, longitude)
    }
}
