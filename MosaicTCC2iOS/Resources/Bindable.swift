//
//  Bindable.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 12/03/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
