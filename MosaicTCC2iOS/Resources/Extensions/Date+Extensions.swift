//
//  Date+Extensions.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 13/03/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import Foundation

extension Date {
    func convertToStringFromFormat(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
