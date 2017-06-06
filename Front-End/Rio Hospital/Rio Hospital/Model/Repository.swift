//
//  Repository.swift
//  Rio Hospital
//
//  Created by Renan Almeida on 06/06/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

protocol Repository {
    // TODO: Docs
    func getHospitals(callback: ([Hospital]) -> Void)
    
    // TODO: Docs
    func getInsurancePlans(callback: ([InsurancePlan]) -> Void)
}

class RepositoryImplemetation: Repository {
    let baseURL = "https://riohospital.herokuapp.com/"
    
    func getHospitals(callback: ([Hospital]) -> Void) {
        // TODO
    }
    
    func getInsurancePlans(callback: ([InsurancePlan]) -> Void) {
        // TODO
    }
}
