//
//  StudiesDetailViewController.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 21/03/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import UIKit

class StudiesDetailViewController: UIViewController {
    
    @IBOutlet weak var instanceImageView: UIImageView!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientBirthdayLabel: UILabel!
    @IBOutlet weak var patientSexLabel: UILabel!
    @IBOutlet weak var physicianName: UILabel!
    
    var patient: StudiesModel.Patient?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let patient = self.patient else { return }
        instanceImageView.downloaded(from: patient.studies?[0].series?[0].files?[0].imageURL ?? "")
        patientNameLabel.text = patient.patientName ?? ""
        patientNameLabel.text = patient.patientsBirthDate ?? ""
        patientNameLabel.text = patient.patientSex ?? ""
        physicianName.text = patient.studies?[0].referringPhysician ?? ""
    }
    
    @IBAction func shareImage(_ sender: Any) {
        if let image = self.instanceImageView.image {
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareDicomFile(_ sender: Any) {
        if let image = patient?.studies?[0].series?[0].files?[0].dcmURL {
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    

}
