//
//  FamilyCell.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/21/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

class FamilyCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var familyImage: UIImageView!
    @IBOutlet weak var userNameOfFamily: UILabel!
    @IBOutlet weak var itemIdLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    func generateCell(familyData: FamilyData) {
        userNameOfFamily.text = familyData.username!
        itemIdLabel.text = String(familyData.id ?? 0)
        cityLabel.text = familyData.city!
        // load images
        if let url = URL(string: KIMAGEURL + familyData.image!) {
            familyImage.kf.setImage(with: url)
        }
    }
}
