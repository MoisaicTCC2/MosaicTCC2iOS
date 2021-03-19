//
//  DICOMMetadataViewController.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 17/01/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import UIKit
import Eureka

enum PatientSexOption: String, Codable {
    case female = "F"
    case male = "M"
}

struct DICOMDataModel: Codable {
    var patientName: String?
    var patientBirthDate: String?
    var patientSex: String?
    var studyID: String?
    var referringPhysicianName: String?
}

class DICOMMetadataViewController: FormViewController {
    
    private var scImageData: SCImage?
    private var dicomDataModel = DICOMDataModel()
    var images: [UIImage]?
    private let viewModel = InputDataViewModel()
    var patientName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scImageData = createSCImageData()
        
        form
    
        +++ Section("Dados do Paciente")
            
            <<< TextRow(){ row in
                row.title = "Nome"
                row.placeholder = "Enter text here"
                row.tag = "patientName"
                row.cell.textField.keyboardType = .asciiCapable
                row.cell.textField.autocapitalizationType = .words
//                row.value = "Patient Test"
            }.onChange({ row in
                self.dicomDataModel.patientName = row.value?.dicomizeName()
            })

            <<< DateRow(){
                $0.title = "Data de nascimento"
                $0.tag = "patientBirthDate"
//                $0.value = Date()
            }.onChange({ row in
                self.dicomDataModel.patientBirthDate = row.value?.convertToStringFromFormat("yyyyMMdd")
            })

            <<< PickerInputRow<String>("Picker Input Row"){
                $0.title = "Sexo"
                $0.tag = "patientSex"
                $0.options = ["Masculino", "Feminino"]
            }.onChange({ row in
                let patientSex = row.value == "Masculino" ? PatientSexOption.male : PatientSexOption.female
                self.dicomDataModel.patientSex = patientSex.rawValue
            })

        +++ Section("Dados do Caso do Paciente")
            <<< TextRow(){ row in
                row.title = "Usuário ou equipamento"
                row.tag = "studyID"
                row.placeholder = "Insira o nome aqui"
                row.cell.textField.keyboardType = .asciiCapable
                row.cell.textField.autocapitalizationType = .words
            }.onChange({ row in
                self.dicomDataModel.studyID = row.value?.dicomizeName()

            })
            
            <<< TextRow(){ row in
                row.title = "Nome do médico"
                row.placeholder = "Insira o nome aqui"
                row.tag = "referringPhysicianName"
                row.cell.textField.keyboardType = .asciiCapable
                row.cell.textField.autocapitalizationType = .words
            }.onChange({ row in
                self.dicomDataModel.referringPhysicianName = row.value?.dicomizeName()
            })

        +++ Section()
            <<< ButtonRow() { row in
                row.title = "Enviar"
            }.onCellSelection({  [weak self] cell, row in
                self?.test()
            }).cellSetup({ cell, row in
                cell.backgroundColor = .gray
                cell.tintColor = .white
            })
    }
    
    private func createSCImageData() -> SCImage {
        let patient = Patient()
        let generalStudy = GeneralStudy()
        let generalSeries = GeneralSeries()
        let scEquipament = SCEquipament()
        let generalImage = GeneralImage()
        let scImage = SCImage(patient: patient,
                              generalStudy: generalStudy,
                              generalSeries: generalSeries,
                              scEquipament: scEquipament,
                              generalImage: generalImage)
        return scImage
    }
    
    func test() {
        print(dicomDataModel)
        let viewController = UIStoryboard(name: "DICOMMetadata", bundle: nil).instantiateViewController(identifier: "DataProgressViewController") as DataProgressViewController
        viewController.setDataToRequest(images: images, scImage: scImageData)
//        guard let dicomData = self.dicomDataModel else { return }
        viewController.setDataToRequest(images: images, dicomData: self.dicomDataModel)
        self.navigationController?.pushViewController(viewController, animated: true)
//        self.present(viewController, animated: true, completion: nil)
    }

}
