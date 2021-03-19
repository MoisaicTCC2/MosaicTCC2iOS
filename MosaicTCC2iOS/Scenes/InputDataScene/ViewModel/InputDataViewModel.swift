//
//  ImageFragmentViewModel.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 25/01/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import Foundation
import UIKit

enum DataSendingState {
    case uploadCompleted
    case success
    case error
}

class InputDataViewModel: NSObject {
    
    let apiService = APIService()
    
    var progressValueBindable = Bindable<Double>()
    var stateBindable = Bindable<DataSendingState>()
    var dataSendingState: DataSendingState?
    
    func sendData(images: [UIImage], informations: DICOMDataModel) {
        
        apiService.postDICOMData(images: images, scImage: informations) { (response) in
            self.stateBindable.value = .success
        } onProgress: { (progressValue) in
            self.progressValueBindable.value = progressValue
            if progressValue == 1.0 { self.stateBindable.value = .uploadCompleted }
        } onError: { (error) in
            self.stateBindable.value = .error
        }

    }
}


