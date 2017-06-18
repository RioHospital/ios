//
//  Repository.swift
//  Rio Hospital
//
//  Created by Renan Almeida on 06/06/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

import Alamofire

/**
 
 A basic interface to define methods that will be used when requesting data
 from the API.
 
 - This protocol implements the Repository pattern.
 
 - This protocol uses functions in a functional programming way through the
 definition of callback parameters. Callbacks are an usual and simple way to
 deal with asynchronously retrieved data.
 
 */
protocol Repository {
    /**

     This function performs a request to the API to retrieve a list of
     hospitals. The request is performed asynchronously, therefore the data is
     returned via a callback to be called by the function when the request is
     done. If any errors occur, the function will call the callback function
     with the nil value.
     
     - Precondition(s):
        - The API is online and working correctly.
     
     - Postcondition(s):
        - The callback function was called with either a nil value or a list
            of hospitals.
     
     - Parameters:
         - callback: A callback function that receives a list of hospitals. This
            function will be called when the all the hospitals are retrieved
            from the API. If any errors occur, the function will be called with
            the nil value (since the parameter is an optional type).
     
     */
    func getHospitals(callback: @escaping ([Hospital]?) -> Void)
}


/// Implementation of the Repository protocol
class RepositoryImplementation: Repository {
    /// Base URL to use when making requests to the API
    let baseURL = "https://riohospital.herokuapp.com"
    
    func getHospitals(callback: @escaping ([Hospital]?) -> Void) {
        // Assynchronous HTTP request
        Alamofire.request("\(baseURL)/hospitals").responseJSON { response in
            // Checks if the request was successful
            guard response.result.isSuccess else {
                print("repository.getHospitals - unsuccessful")
                return callback(nil)
            }
            
            // Checks if the retrieved data is in the correct format (array of maps)
            guard let array = response.result.value as? [[String: AnyObject]] else {
                print("repository.getHospitals - unkown data format")
                return callback(nil)
            }
            
            // Creates the list of hospitals
            var hospitals = [Hospital]()
            for map in array {
                hospitals.append(Hospital(
                    name: map["name"] as! String,
                    address: map["address"] as! String,
                    neighborhood: map["neighborhood"] as! String,
                    postalCode: map["postalCode"] as! String,
                    phone: map["phone"] as! String,
                    latitude: map["latitude"] as! Double,
                    longitude: map["longitude"] as! Double
                ))
            }

            callback(hospitals)
        }
    }
}
