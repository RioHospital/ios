//
//  HospitalDetail.swift
//  Rio Hospital
//
//  Created by Gabriel Gomes on 18/06/17.
//  Copyright © 2017 Gabriel Gomes. All rights reserved.
//

import UIKit

class HospitalDetail: UIViewController {
	
	@IBOutlet weak var phoneNumberLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	
	var hospital: Hospital

	init(withHospital hospital: Hospital) {
		self.hospital = hospital
		super.init(nibName: "HospitalDetail", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    /**
     
     Called after the view has been loaded. For view controllers 
     created in code, this is after -loadView. For view controllers 
     unarchived from a nib, this is after the view is set.
     
     - Precondition(s):
     - HospitalDetail UIViewController is asked to be shown.
     
     - Postcondition(s):
     - Labels in screen (title, phoneNumberLabel and addressLabel) are
     initialized with values.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = self.hospital.name
		self.phoneNumberLabel.text = self.hospital.phone
		self.addressLabel.text = self.hospital.address + " - " + self.hospital.neighborhood
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
