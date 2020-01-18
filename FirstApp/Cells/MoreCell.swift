//
//  MoreCell.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/22/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

// MARK: - Global variables
let titles = ["الصفحة الشخصية", "الاشعارات", "المفضلة", "تعديل البيانات", "تسجيل الخروج"]
let titleImages = ["family1", "family1", "family1", "family1", "family1"]

class MoreCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    
    
    func generateCell(index: Int) {
        titleLbl.text = titles[index]
        titleImageView.image = UIImage(named: titleImages[index])
    }
    
    

}
