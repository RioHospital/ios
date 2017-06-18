//
//  InsurancePlan.swift
//  Rio Hospital
//
//  Created by Renan Almeida on 06/06/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

/// Holds basic data from the insurance plan entity
class InsurancePlan {
    let id: UInt
    
    let name: String
    
    init(id: UInt, name: String) {
        self.id = id
        self.name = name
    }
}
