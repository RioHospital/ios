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
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = self.hospital.name
		self.phoneNumberLabel.text = self.hospital.phone
		self.addressLabel.text = self.hospital.address + " - " + self.hospital.neighborhood
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
