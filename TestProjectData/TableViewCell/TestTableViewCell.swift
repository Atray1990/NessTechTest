//
//  TestTableViewCell.swift
//  TestProjectData
//
//  Created by shashank atray on 13/10/20.
//  Copyright © 2020 shashank atray. All rights reserved.
//  LinkeIn - https://www.linkedin.com/in/shashank-k-atray/
//

import UIKit


class TestTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblTestType: UILabel!
    @IBOutlet weak var lblAvailable: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configureCellValue(testPackage: TestPackage) {
        lblName.text = "\(testPackage.name) \(testPackage.alpha2Code) "
        if let area = testPackage.area {
            lblTestType.text = "\(area) sq kms"
        }
        lblPrice.text = testPackage.nativeName
        lblAvailable.text = testPackage.capital
    }
    
}
