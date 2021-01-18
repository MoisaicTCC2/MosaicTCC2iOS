//
//  DICOMMetadataViewController.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 17/01/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import UIKit
import Eureka

class DICOMMetadataViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Dados do Paciente")
            <<< TextRow(){ row in
                row.title = "Nome"
                row.placeholder = "Enter text here"
            }
            
            <<< DateRow(){
                $0.title = "Data de nascimento"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            
            <<< PickerInputRow<String>("Picker Input Row"){
                $0.title = "Sexo"
                $0.options = ["Masculino", "Feminino", "Outro"]
                $0.value = $0.options.first
            }
            
        +++ Section("Dados do Caso do Paciente")
            <<< TextRow(){ row in
                row.title = "Nome do usuário"
                row.placeholder = "Insira o nome aqui"
            }
            
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
    
    func test() {
        print("clicou!")
    }

}
