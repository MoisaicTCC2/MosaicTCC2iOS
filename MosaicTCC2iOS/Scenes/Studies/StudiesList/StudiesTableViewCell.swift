//
//  StudiesTableViewCell.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 19/03/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import UIKit

class StudiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var instanceImageView: UIImageView!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
