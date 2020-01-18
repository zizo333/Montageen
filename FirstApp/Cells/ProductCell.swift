//
//  ProductCell.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/20/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    // MARK: - Outlets for basket
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var deleteOrderButton: UIButton!
    @IBOutlet weak var editOrderButton: UIButton!
    
    // MARK: - Variables
    var cartId: Int?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - Actions
    
    func generateCell(itemData: ItemData) {
        titleLabel.text = itemData.title
        cityLabel.text = itemData.city
        userNameLabel.text = itemData.username
        priceLabel.text = String(itemData.price ?? 0)
        // load first image
        if let url = URL(string: KIMAGEURL + itemData.images![0].image!) {
            firstImage.kf.setImage(with: url)            
        }
        
        timeLabel.text = itemData.createdAt
        if favoriteItemsIds.contains(itemData.id!) {
            favoriteBtn.setImage(UIImage(named: "like1"), for: .normal)
        } else {
            favoriteBtn.setImage(UIImage(named: "like0"), for: .normal)
        }
    }
    
    func generateCell(itemData: CartData) {
        titleLabel.text = itemData.itemTitle
        cityLabel.text = itemData.city
        userNameLabel.text = itemData.tradername
        priceLabel.text = String(itemData.price ?? 0)
        // load first image
        if let url = URL(string: KIMAGEURL + itemData.images![0].image!) {
            firstImage.kf.setImage(with: url)
        }
        cartId = itemData.id!
        timeLabel.text = itemData.createdAt
    }
    
}
