//
//  Hospital.swift
//  Rio Hospital
//
//  Created by Renan Almeida on 06/06/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

import Foundation

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
    
    /**
     
     Returns the distance between the hospital and a given point. Calculates
     the distance using Haversine's formula.
     
     - Precondition(s):
        - The hospital has valid coordinates.
        - The parameter's coordinates are valid.
     
     - Postcondition(s):
        - The distance between the hospital and the given coordinates was
            calculated correctly.
     
     - Rationale: The method uses two coordinate points with the Haversine
        formula (a known mathematical formula used to calculate the distance
        between two coordinates in the globe). By using this formula we can
        easely calculate the distance from the hospital and a point.
     
     - Parameters:
        - from: A tuple of two Double typed values, the first one being
            latitude and the second one being longitude.
     
     */
    func distance(from location: (latitude: Double, longitude: Double)) -> Double {
        // Auxiliary function used in the calculations
        func toRadians(_ degrees: Double) -> Double {
            return degrees * 3.1415 / 180
        }
        
        let radius: Double = 6371 // Earth's radius in kilometers
        
        // Haversine's formula
        let deltaP = (toRadians(coordinates.latitude) - toRadians(location.latitude))
        let deltaL = (toRadians(coordinates.longitude) - toRadians(location.longitude))
        let sinDeltaP = sin(deltaP / 2) * sin(deltaP / 2)
        let sinDeltaL = sin(deltaL / 2) * sin(deltaL / 2)
        let cosLat = cos(toRadians(location.latitude)) * cos(toRadians(coordinates.latitude))
        let x = sinDeltaP + cosLat * sinDeltaL
        let distance = radius * 2 * atan2(sqrt(x), sqrt(1 - x)) // Distance in kilometers
        
        // Rounded to two decimal places
        return Double(String(format: "%.2f", arguments: [distance]))!
    }
}
