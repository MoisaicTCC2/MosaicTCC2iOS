//
//  APIService.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 22/02/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    let urlString = "http://192.168.0.2:5000/studies"
    
    func convertImagesToJPEGData(_ images: [UIImage]) -> [Data?] {
        var imagesData = [Data?]()
        for image in images {
            let imageData = image.jpegData(compressionQuality: 1)
            imagesData.append(imageData)
        }
        return imagesData
    }
    
    // POST images and DICOM data
    func postDICOMData(images: [UIImage], scImage: DICOMDataModel, onSuccess: @escaping (Any)->(), onProgress: @escaping (Double) -> (), onError: @escaping (AFError)->()) {
        AF.upload(multipartFormData: { (multipartFormData) in
            
            var images2 = [UIImage]()
            for image in images {
                let scaledImage = image.scalePreservingAspectRatio(targetSize: CGSize(width: 500, height: 500))
                images2.append(scaledImage)
            }
            
            let imagesData = self.convertImagesToJPEGData(images2)
            for (index, imageData) in imagesData.enumerated() {
                if let imageData  = imageData{
                    multipartFormData.append(imageData, withName: "\(index)[]", fileName: "\(index).jpg", mimeType: "image/jpeg")
                }
            }

            if let parameters = scImage.dictionary {
                let parametersJSON = try! JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
                print(String(data: parametersJSON, encoding: .utf8)!)
                multipartFormData.append(parametersJSON, withName: "scImageInfo", mimeType: "application/json")
            }



        }, to: urlString).responseJSON { (response) in
            switch response.result {
            case .success(let value):
//                print(value)
                onSuccess(value)
            case .failure(let error):
//                print(error.localizedDescription)
                guard let errorOption = (response.error?.underlyingError as? URLError) else { return }
                switch errorOption.code {
                case .notConnectedToInternet:
                    onError(error)
                default:
                    onError(error)
                }
            }
        }.uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
            onProgress(progress.fractionCompleted)
        }

    }
    
}
