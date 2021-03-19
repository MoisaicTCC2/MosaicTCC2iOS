//
//  ImageFragmentCollectionViewCell.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 17/01/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import UIKit

class ImageFragmentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fragmentImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fragmentImageView.image = nil
    }
}
