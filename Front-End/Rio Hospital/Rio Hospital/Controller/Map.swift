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
	
    override func viewDidLoad() {
        super.viewDidLoad()
		LocationManager.shared.startUpdatingLocation()
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//extension Map: LocationManagerDelegate {
//	
//	func locationManagerDidChangeAuthorizationStatus() {
//		
//	}
//}
