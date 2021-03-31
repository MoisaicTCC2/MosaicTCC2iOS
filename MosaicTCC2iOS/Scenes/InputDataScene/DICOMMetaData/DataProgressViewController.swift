//
//  DataProgressViewController.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 10/03/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import UIKit

class DataProgressViewController: UIViewController {
    
    @IBOutlet private weak var dataProgressView: UIProgressView!
    private var images: [UIImage]?
    private var scImage: SCImage?
    private var dicomData: DICOMDataModel?
    private let viewModel = InputDataViewModel()
    
    func setDataToRequest(images: [UIImage]?, scImage: SCImage?) {
        self.images = images
        self.scImage = scImage
    }
    
    func setDataToRequest(images: [UIImage]?, dicomData: DICOMDataModel?) {
        self.images = images
        self.dicomData = dicomData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        guard let images = images, let dicomData = dicomData else { return }
        viewModel.sendData(images: images, informations: dicomData)
        dataProgressView.setProgress(0.0, animated: true)
        bindState()
        bindValue()
    }
    
    private func bindValue() {
        viewModel.progressValueBindable.bind { progressValue in
            guard let progressValue = progressValue else { return }
            self.dataProgressView.setProgress(Float(progressValue), animated: true)
        }
    }
    
    private func bindState() {
        viewModel.stateBindable.bind { state in
            switch state {
            case .uploadCompleted:
                print("uploaded")
            case .success:
                self.getUploadCompleted()
            case .error:
                self.alert(withTitle: "Erro", message: "ocorreu um erro, tente novamente") { _ in
                    self.navigationController?.popToRootViewController(animated: true)
                }
            case .none:
                print("initial state")
            }
        }
    }
    
    private func getUploadCompleted() {
        self.alert(withTitle: "Dados Enviados", message: "Todos os dados foram enviados e em breve poderá ser acessado.") { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func alert(withTitle title: String, message: String, handler: ((UIAlertAction)->())? = nil) {
        let alert = createAlertController(title: title, message: message, handler: handler)
        self.present(alert, animated: true)
    }
    
    private func createAlertController(title: String, message: String, handler: ((UIAlertAction) -> ())? = nil) -> UIAlertController {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        controller.addAction(okAction)
        return controller
    }

}
