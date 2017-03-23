//
//  CountryInfoTableViewCell.swift
//  PSTakeCareAssignment
//
//  Created by craftsvilla on 22/03/17.
//  Copyright © 2017 PSTakeCare. All rights reserved.
//

import UIKit

class CountryInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var countryArea: UILabel!
    @IBOutlet weak var countryName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.countryName.text = "Country Name"
        self.countryArea.text = "Country Area"
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
