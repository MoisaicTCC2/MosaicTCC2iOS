//
//  Coordinator.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 25/01/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
