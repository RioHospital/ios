//
//  Map.swift
//  Rio Hospital
//
//  Created by Gabriel Gomes on 06/06/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

import UIKit
import MapKit

class Map: UIViewController {

	@IBOutlet weak var mapView: MKMapView!
	
	let searchBar = UISearchBar()
	var currentLocation: CLLocation? = nil
	var hospitals = [Hospital]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		LocationManager.shared.delegate = self
		LocationManager.shared.startUpdatingLocation()
		
		self.title = "Rio Hospital"
		
		self.configureMap()
		self.configureSearchBar()
		self.getHospitals()
	}
	
	func configureSearchBar() {
		self.searchBar.delegate = self
		self.searchBar.sizeToFit()
		self.searchBar.placeholder =  "Digite o nome do Hospital"
		self.navigationItem.titleView = self.searchBar
	}
	
	// MARK: - Map
	
    /**
	
     This function configure Map interface. It sets mapView delegate to its own class,
     set the type to be standard, the property so show user's location and the compass.
     
     - Precondition(s):
     - The Map's screen is open.
     - There's a mapView.
     
     - Postcondition(s):
     - MapView is configured.
     
     */
	func configureMap() {
		self.mapView.delegate = self
		self.mapView.mapType = MKMapType.standard
		self.mapView.showsUserLocation = true
		self.mapView.showsCompass = true
	}
	
    /**
     
     This function request for hospital's data to be shown as pins.
     
     - Precondition(s):
     - The Map's screen is open.
     - User's has Internet connection.
     
     - Postcondition(s):
     - If the anwser is not null, call method to set pins marking
     hospitals locations.
     - If it's null, then it returns.
     
     */
	func getHospitals() {
		let repository = RepositoryImplementation()
		
		repository.getHospitals { (hospitals) in
			guard let safeHospitals = hospitals else {
				return
			}
			
			self.hospitals = safeHospitals
			self.setPins(withHospitals: safeHospitals)
		}
	}
	
    /**
     
     Set pins on map in hospitals' location.
     
     - Precondition(s):
     - The parameter is not null.
     
     - Postcondition(s):
     - Pins are set in map marking every hospital's location.
     
     - Parameters:
     - hospitals: An array of Hospital model with all its properties.
     
     */
	func setPins(withHospitals hospitals: [Hospital]) {
		
		self.mapView.removeAnnotations(self.mapView.annotations)
		
		for hospital in hospitals {
			let annotation = RHAnnotation()
			annotation.coordinate = CLLocationCoordinate2D(latitude: hospital.coordinates.latitude, longitude: hospital.coordinates.longitude)
			annotation.hospital = hospital
			
			var distance = ""
			
			if let safeCurrentLocation = self.currentLocation {
				distance = "\(hospital.distance(from: (latitude: safeCurrentLocation.coordinate.latitude, longitude: safeCurrentLocation.coordinate.longitude)))"
			}
			
			annotation.title = hospital.name
			annotation.subtitle = "Distância: " + distance + " KM"
			
			self.mapView.addAnnotation(annotation)
		}
	}

    /**
     
     Centralize map on user's location.
     
     - Precondition(s):
     - The location is in app's memory.
     
     - Postcondition(s):
     - Pins are set in map marking every hospital's location.
     
     - Parameters:
     - location: A location is passed to centrilize the map. 
     
     */
	func centerMapOnLocation(location: CLLocation) {
		let regionRadius: CLLocationDistance = 200
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
		self.mapView.setRegion(coordinateRegion, animated: false)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension Map: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		
		let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
				
		if let title = annotation.title, title == "My Location" {
			annotationView.pinTintColor = UIColor.red
		} else {
			annotationView.pinTintColor = UIColor.blue
		}
		
        if let title = annotation.title, title == "My Location" {
            annotationView.pinTintColor = UIColor.red
        } else {
            annotationView.pinTintColor = UIColor.blue
        }
        
		annotationView.isDraggable = false
		annotationView.canShowCallout = true
		annotationView.animatesDrop = true
		
		let detailButton = UIButton(type: .custom)
		detailButton.frame.size.width = 44
		detailButton.frame.size.height = 44
		detailButton.setImage(#imageLiteral(resourceName: "detailButton"), for: .normal)
		
		annotationView.rightCalloutAccessoryView = detailButton
		
		return annotationView
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		
		guard let annotation = view.annotation as? RHAnnotation, let hospital = annotation.hospital else {
			return
		}
		
		let hospitalDetail = HospitalDetail(withHospital: hospital)
		
		self.navigationController?.pushViewController(hospitalDetail, animated: true)
	}

}

extension Map: LocationManagerDelegate {
	
	func locationManagerDidChangeAuthorizationStatus() {
		
	}
	
	func locationManager(didUpdateLocation location: CLLocation) {
		self.currentLocation = location
		self.centerMapOnLocation(location: location)
		LocationManager.shared.stopUpdatingLocation()
	}
}

extension Map: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		
		guard !searchText.isEmpty else {
			self.setPins(withHospitals: self.hospitals)
			return
		}
		
		let filteredHospitals = self.hospitals.filter { (hospital) -> Bool in
			return hospital.name.lowercased().contains(searchText.lowercased())
		}
		
		self.setPins(withHospitals: filteredHospitals)
	}
}

class RHAnnotation: MKPointAnnotation {
	var hospital: Hospital? = nil
}
