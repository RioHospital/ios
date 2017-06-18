//
//  RioHospitalTests.swift
//  Rio Hospital
//
//  Created by Renan Almeida on 17/06/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

import Swift
import XCTest

class RioHospitalTests: XCTestCase {
    let repository: Repository = RepositoryImplementation()
    
    func testGetHospitals() {
        repository.getHospitals { hospitals in
            XCTAssert(hospitals != nil)
            for hospital in hospitals! {
                print("{" +
                    " Name: \(hospital.name) -" +
                    " Address: \(hospital.address) -" +
                    " Neighborhood: \(hospital.neighborhood) - " +
                    " PostalCode: \(hospital.postalCode) - " +
                    " Phone: \(hospital.phone) - " +
                    " Coordinates: \(hospital.coordinates)" +
                " }")
                print()
            }
        }
        
        sleep(5)
    }
}
