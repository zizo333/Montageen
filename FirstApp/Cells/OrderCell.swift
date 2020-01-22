//
//  OrderCell.swift
//  FirstApp
//
//  Created by Zizo Adel on 1/18/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit
import Kingfisher

class OrderCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var orderImageView: UIImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var osraName: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
    func generateCell(data: MyOrderData) {
        orderName.text = data.itemname ?? ""
        osraName.text = data.familyName ?? ""
        orderDate.text = data.date ?? ""
        orderPrice.text = "\(data.price ?? 0)"
        let url = URL(string: KIMAGEURL + (data.itemimgs?[0].image ?? "") )
        orderImageView.kf.setImage(with: url)
    }

}
