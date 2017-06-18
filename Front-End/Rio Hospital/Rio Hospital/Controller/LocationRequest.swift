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
			self.present(Map(), animated: true, completion: nil)
		}
	}
}
