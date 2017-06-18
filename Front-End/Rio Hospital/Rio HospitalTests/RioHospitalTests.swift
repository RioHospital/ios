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
            XCTAssertNotNil(hospitals)
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
    
    func testHospitalDistanceFrom() {
        let hospital = Hospital(name: "", address: "", neighborhood: "", postalCode: "", phone: "",
            latitude: -23.5475, longitude: -46.6361)
        let distance = hospital.distance(from: (-22.9028, -43.2075))
        XCTAssertEqual(distance /* Rio de Janeiro */, distance /* São Paulo */)
    }
}
