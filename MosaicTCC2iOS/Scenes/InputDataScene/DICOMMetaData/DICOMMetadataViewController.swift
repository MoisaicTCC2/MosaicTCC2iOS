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
                
        form
    
        +++ Section("Dados do Paciente")
            
            <<< TextRow(){ row in
                row.title = "Nome"
                row.placeholder = "Enter text here"
                row.tag = "patientName"
                row.cell.textField.keyboardType = .asciiCapable
                row.cell.textField.autocapitalizationType = .words
                row.add(rule: RuleRequired())
//                row.value = "Patient Test"
            }.onChange({ row in
                self.dicomDataModel.patientName = row.value?.dicomizeName()
            }).cellUpdate({ (cell, row) in
                if !row.isValid {
                    cell.titleLabel?.textColor = .systemRed
                }
            })

            <<< DateRow(){
                $0.title = "Data de nascimento"
                $0.tag = "patientBirthDate"
                $0.add(rule: RuleRequired())
            }.onChange({ row in
                self.dicomDataModel.patientBirthDate = row.value?.convertToStringFromFormat("yyyyMMdd")
            })

            <<< PickerInputRow<String>("Picker Input Row"){
                $0.title = "Sexo"
                $0.tag = "patientSex"
                $0.options = ["Masculino", "Feminino"]
                $0.add(rule: RuleRequired())
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
                row.add(rule: RuleRequired())
            }.onChange({ row in
                self.dicomDataModel.studyID = row.value?.dicomizeName()

            }).cellUpdate({ cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .systemRed
                }
            })
            
            <<< TextRow(){ row in
                row.title = "Nome do médico"
                row.placeholder = "Insira o nome aqui"
                row.tag = "referringPhysicianName"
                row.cell.textField.keyboardType = .asciiCapable
                row.cell.textField.autocapitalizationType = .words
                row.add(rule: RuleRequired())
            }.onChange({ row in
                self.dicomDataModel.referringPhysicianName = row.value?.dicomizeName()
            }).cellUpdate({ cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .systemRed
                }
            })

        +++ Section()
            <<< ButtonRow() { row in
                row.title = "Enviar"
                row.disabled = Condition.function(form.allRows.compactMap { $0.tag },
                                                  { !$0.validate().isEmpty })
//                row.hidden = Condition.function(form.allRows.compactMap { $0.tag },
//                                                { !$0.validate().isEmpty })
                row.evaluateDisabled()
//                row.evaluateHidden()
            }.onCellSelection({  [weak self] cell, row in
                if !row.isDisabled {
                    self?.test()
                }
                
            }).cellSetup({ cell, row in
                cell.backgroundColor = .gray
                cell.tintColor = .white
            })
    }

    
    func test() {
        print(dicomDataModel)
        let viewController = UIStoryboard(name: "DICOMMetadata", bundle: nil).instantiateViewController(identifier: "DataProgressViewController") as DataProgressViewController
        viewController.setDataToRequest(images: images, scImage: scImageData)
        viewController.setDataToRequest(images: images, dicomData: self.dicomDataModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
