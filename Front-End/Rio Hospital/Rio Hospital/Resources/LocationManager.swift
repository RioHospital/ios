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
	func locationManagerDidChangeAuthorizationStatus()
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
			if CLLocationManager.locationServicesEnabled(), CLLocationManager.authorizationStatus() == .authorizedAlways {
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
	
	public func requestAuthorization() {
		self.manager.requestWhenInUseAuthorization()
	}
	
	public func startUpdatingLocation() {
		self.manager.startUpdatingLocation()
	}
	
	public func stopUpdatingLocation() {
		self.manager.stopUpdatingLocation()
	}
}

//MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
	
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		self.delegate?.locationManagerDidChangeAuthorizationStatus()
	}
	
	public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		
	}
}
