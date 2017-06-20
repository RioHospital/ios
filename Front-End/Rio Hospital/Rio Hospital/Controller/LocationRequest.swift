//
//  LocationRequest.swift
//  Rio Hospital
//
//  Created by Gabriel Gomes on 30/05/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

import UIKit
import CoreLocation

class LocationRequest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		LocationManager.shared.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /**
     
     Request user's authorization to get his location.
     
     - Precondition(s):
     - Device has gps.
     
     - Postcondition(s):
     - A native alert shows requesting user's authotization to get his
     location.
     - The anwser is saved.
     
     - Parameters:
     - The option selected by the user.
     
     */
	@IBAction func didTapAllowLocationButton(_ sender: Any) {
		LocationManager.shared.requestAuthorization()
	}
}

extension LocationRequest: LocationManagerDelegate {
    func locationManager(didUpdateLocation location: CLLocation) {
        // TODO
    }

	func locationManagerDidChangeAuthorizationStatus() {
		if LocationManager.shared.isLocationPermissionGranted {
			
			let navigationController = UINavigationController(rootViewController: Map())
			self.present(navigationController, animated: true, completion: nil)
		}
	}
}
