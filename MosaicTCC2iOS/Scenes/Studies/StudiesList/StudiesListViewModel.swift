//
//  StudiesListViewModel.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 20/03/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import Foundation

enum StudiesListViewState {
    case success([StudiesModel.Patient])
    case error
}

protocol StudiesListViewModelProtocol {
    
}

class StudiesListViewModel: StudiesListViewModelProtocol {
    private var studies: [StudiesModel]?
    private var state: StudiesListViewState?
    var studiesBindable = Bindable<StudiesListViewState>()
    private var service = APIService()
    
    func getStudies() {
        service.fetchStudies { data in
            print(data)
            self.studiesBindable.value = .success(data)
        } onError: { error in
            print(error)
        }

    }
    
    func getStudiesByPatientId(_ patientId: String) {
        
    }
    
}
