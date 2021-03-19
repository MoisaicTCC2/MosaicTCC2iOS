//
//  String+Extensions.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 13/03/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import Foundation

extension String {
    
    /// Replace white spaces separator to "^", like DICOM
    /// protocol recommends.
    func dicomizeName() -> String {
        let formattedString = self.replacingOccurrences(of: " ", with: "^")
        let hasLastCircumflex = formattedString.last == "^"
        if hasLastCircumflex { return String(formattedString.dropLast()) }
        return formattedString
    }
}
