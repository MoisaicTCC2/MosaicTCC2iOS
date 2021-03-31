//
//  ViewController.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 17/01/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageFragmentsCollectionView: UICollectionView!
    @IBOutlet weak var descriptionScreenLabel: UILabel! {
        didSet {
            descriptionScreenLabel.attributedText = NSMutableAttributedString().normal("Importar Fragmentos\n", font: .boldSystemFont(ofSize: 26), color: .gray).normal("Importe os fragmentos de imagem para gerar a composição do campo visual.", font: .boldSystemFont(ofSize: 16), color: .gray)
        }
    }
    @IBOutlet weak var nextButton: UIButton!
    
    private var imagePicker: ImagePicker?
    private var imageFragments = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]
    private let viewModel = InputDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFragmentsCollectionView.dataSource = self
        setupFlowLayout()
        imageFragmentsCollectionView.delegate = self
        imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    private func setupFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
        imageFragmentsCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    @IBAction func goToSCImageInformationsController(_ sender: Any) {
        let viewController = DICOMMetadataViewController()
        viewController.images = imageFragments
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageFragment", for: indexPath) as! ImageFragmentCollectionViewCell
        cell.backgroundColor = .gray
        if imageFragments.count > indexPath.item {
            cell.fragmentImageView.image = imageFragments[indexPath.item]
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imagePicker?.present(from: nextButton, forIndexPath: indexPath)
    }
}

extension ViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?, forIndexPath: IndexPath) {
        if let image = image {
            imageFragments[forIndexPath.item] = image
            imageFragmentsCollectionView.reloadData()
        }
    }
    
}

extension NSMutableAttributedString {
    
    @discardableResult func normal(_ text: String, font: UIFont? = UIFont.systemFont(ofSize: 12.0), color: UIColor? = nil, linkUrl: String? = nil) -> NSMutableAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [.font: font!]
        if let url = linkUrl { attrs[.link] = url }
        if let colorText = color { attrs[.foregroundColor] = colorText }
        let normal = NSMutableAttributedString(string:text, attributes: attrs)
        
        append(normal)
        
        return self
    }
}

