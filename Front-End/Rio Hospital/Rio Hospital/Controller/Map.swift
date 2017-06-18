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
	
	var currentLocation: CLLocation? = nil
	
    override func viewDidLoad() {
        super.viewDidLoad()
		LocationManager.shared.delegate = self
		LocationManager.shared.startUpdatingLocation()
		
		self.title = "Rio Hospital"
		
		self.configureMap()
		self.getHospitals()
	}
	
	// MARK: - Map
	
	func configureMap() {
		self.mapView.delegate = self
		self.mapView.mapType = MKMapType.standard
		self.mapView.showsUserLocation = true
		self.mapView.showsCompass = true
	}
	
	func getHospitals() {
		let repository = RepositoryImplementation()
		
		repository.getHospitals { (hospitals) in
			guard let safeHospitals = hospitals else {
				return
			}
			
			self.setPins(withHospitals: safeHospitals)
		}
	}
	
	func setPins(withHospitals hospitals: [Hospital]) {
		
		for hospital in hospitals {
			let annotation = MKPointAnnotation()
			annotation.coordinate = CLLocationCoordinate2D(latitude: hospital.coordinates.latitude, longitude: hospital.coordinates.longitude)
			
			var distance = ""
			
			if let safeCurrentLocation = self.currentLocation {
				distance = "\(hospital.distance(from: (latitude: safeCurrentLocation.coordinate.latitude, longitude: safeCurrentLocation.coordinate.longitude)))"
			}
			
			annotation.title = hospital.name
			annotation.subtitle = "Distância: " + distance + " KM"
			
			self.mapView.addAnnotation(annotation)
		}
	}

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
		
		annotationView.isDraggable = false
		annotationView.canShowCallout = true
		annotationView.pinTintColor = UIColor.blue
		annotationView.animatesDrop = true
		
		let detailButton = UIButton(type: .custom)
		detailButton.frame.size.width = 44
		detailButton.frame.size.height = 44
		detailButton.setImage(#imageLiteral(resourceName: "detailButton"), for: .normal)
		
		annotationView.rightCalloutAccessoryView = detailButton
		
		return annotationView
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		print("x")
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
