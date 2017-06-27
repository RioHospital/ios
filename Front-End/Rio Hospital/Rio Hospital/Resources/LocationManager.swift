//
//  LocationManager.swift
//  Rio Hospital
//
//  Created by Gabriel Gomes on 30/05/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol LocationManagerDelegate {
    
    /**
     
     This method open the Map's Screen if the user has authorized the usage
     of his location.
     
     - Precondition(s):
     - The user has authorized the use of location.
     
     - Postcondition(s):
     - The app presents the Map's screen.
     
     */
	func locationManagerDidChangeAuthorizationStatus()
   
    /**
     
     This method set user's location in class, centralize de map in user's 
     location and send a request to stop requesting user's location.
     
     - Precondition(s):
     - The user has authorized the use of location. And the app has found it.
     
     - Postcondition(s):
     - The map is centralized, location is saved and the app stop requesting
     for user's location.
     
     - Prameter(s):
     - location: The user's location already gotten before.
     
     */
	func locationManager(didUpdateLocation location: CLLocation)
}

class LocationManager: NSObject {
	
	open var shouldAskForAuthorization: Bool {
		get {
			if CLLocationManager.locationServicesEnabled() {
				switch CLLocationManager.authorizationStatus() {
					case .notDetermined:
						return true
					case .authorizedAlways, .authorizedWhenInUse, .restricted, .denied:
						return false
				}
			}
			
			return false
		}
	}
	
	open var isLocationPermissionGranted: Bool {
		get {
			if CLLocationManager.locationServicesEnabled(), CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
				return true
			}
			return false
		}
	}
	
	var delegate: LocationManagerDelegate?
	
	private var manager = CLLocationManager()
	
	static var shared = LocationManager()
	
	//MARK: - Initializers
	
	private override init() {
		super.init()
		
		self.manager.desiredAccuracy = kCLLocationAccuracyBest
		self.manager.delegate = self
	}
	
	/**
		Requests permission to use location services while the app is in the foreground.
		When the current authorization status is notDetermined, this method runs asynchronously and prompts the user to grant permission to the app to use location services. The user prompt contains the text from the NSLocationWhenInUseUsageDescription key in your app’s Info.plist file, and the presence of that key is required when calling this method. After the status is determined, the location manager delivers the results to the delegate’s locationManager(_:didChangeAuthorization:) method. If the current authorization status is anything other than notDetermined, this method does nothing and does not call the locationManager(_:didChangeAuthorization:) method.
	
		- Precondition: The `person` property must be non-nil.
		- Postcondition: `updatedAddress` must be a valid address.
	*/

	public func requestAuthorization() {
		self.manager.requestWhenInUseAuthorization()
	}
	
	/**
	Starts the generation of updates that report the user’s current location.
	This method returns immediately. Calling this method causes the location manager to obtain an initial location fix (which may take several seconds) and notify your delegate by calling its locationManager(_:didUpdateLocations:) method. After that, the receiver generates update events primarily when the value in the distanceFilter property is exceeded. Updates may be delivered in other situations though. For example, the receiver may send another notification if the hardware gathers a more accurate location reading.
	
	- Precondition: The `person` property must be non-nil.
	- Postcondition: `updatedAddress` must be a valid address.
	*/
	
	public func startUpdatingLocation() {
		self.manager.startUpdatingLocation()
	}
	
    /**
    Stop the generation of updates that report the user’s current location.
    This method returns immediately. Calling this method, the location manager will stop obtaining user's location.
    
    - Precondition: Location manager is updating location.
    - Postcondition: Location manager stop updating location.
    */
	
	public func stopUpdatingLocation() {
		self.manager.stopUpdatingLocation()
	}
}

//MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
	
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		guard let location = locations.last else {
			return
		}
		
		self.delegate?.locationManager(didUpdateLocation: location)
	}
	
	public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		self.delegate?.locationManagerDidChangeAuthorizationStatus()
	}
}
