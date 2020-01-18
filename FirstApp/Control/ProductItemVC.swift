//
//  TestingVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/22/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit
import AARatingBar
import Kingfisher

class ProductItemVC: UIViewController {
    
    // MARK: - Variables
    var item: ItemData?
    var images: [String] = []
    var timer: Timer?
    var flag = 0
    // MARK: - Outlets
    @IBOutlet weak var pageControlImages: UIPageControl!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var ratingLevel: AARatingBar!
    @IBOutlet weak var itemCount: UITextField!
    @IBOutlet weak var addRatingBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getImages()
        
        pageControlImages.transform = CGAffineTransform(scaleX: 2, y: 2)
        fillItemProperties()
        notifyKeyboard()
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    func getImages() {
        if let _item = item {
            for image in _item.images! {
                images.append(image.image ?? "placeholder")
            }
        }
    }
    
    // MARK: - Actions
    func fillItemProperties() {
        if let item_data = item {
            titleName.text = item_data.title ?? ""
            itemPrice.text = String(item_data.price ?? 0)
            if favoriteItemsIds.contains(item_data.id!) {
                favoriteButton.setImage(UIImage(named: "like1"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(named: "like0"), for: .normal)
            }

            userNameLabel.text = item_data.username ?? ""
            createdTimeLabel.text = item_data.createdAt ?? ""
            cityLabel.text = item_data.city ?? ""
            ratingLevel.value = CGFloat(item_data.rate ?? 0.0)
            // set images
            for i in 0..<images.count {
                let imageView = UIImageView()
                imageView.contentMode = .scaleToFill
                let url = URL(string: KIMAGEURL + images[i])
                imageView.kf.setImage(with: url)
                let xPos = CGFloat(i) * self.view.bounds.size.width
                imageView.frame = CGRect(x: xPos, y: 0, width: self.view.frame.size.width, height: scrollView.frame.size.height)
                scrollView.contentSize.width = self.view.frame.size.width * CGFloat(i+1)
                scrollView.addSubview(imageView)
            }
        }
    }
    
    func notifyKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let viewHeight = self.view.frame.height
            let ratingButtonHeight = self.addRatingBtn.frame.origin.y + 50
            let reminderSpace = viewHeight - ratingButtonHeight
            if keyboardRect.height > reminderSpace {
                self.view.frame.origin.y = -(keyboardRect.height - reminderSpace)
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    @IBAction func addToBasket() {
        guard let qtyItems = itemCount.text, !qtyItems.isEmpty, qtyItems != "0" else {
            showAlert(vc: self, message: "أدخل الكمية")
            return
        }
        if let itemId = item?.id, let osraId = item?.userID, let userId = getUserId() {
            let qty = Int(qtyItems)!
            let price = qty * (item?.price!)!
            let parameters: [String : Any] = [
                "item_id" : itemId,
                "owner" : userId,
                "trader" : osraId,
                "deliverman" : 3,
                "qty" : qty,
                "price" : price
            ]
            
            Request.addToCart(parameters: parameters) { (success) in
                if success {
                    weak var pvc = self.presentingViewController
                    
                    self.dismiss(animated: true) {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "basketVC")
                        pvc?.present(vc, animated: true, completion: nil)
                    }
                } else {
                    showAlert(vc: self, message: "هذا المنتج موجود بالفعل")
                }
                self.itemCount.text = ""
            }
        }
    
    }
    
    @IBAction func addYourRatingAction() {
    }
    
    @IBAction func backAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func makeFavoriteAction(_ sender: UIButton) {
        if let itemId = item?.id {
            if favoriteItemsIds.contains(itemId) {
                Request.makeFavorite(state: .delete ,itemId: itemId) { (message) in
                    if message {
                        self.favoriteButton.setImage(UIImage(named: "like0"), for: .normal)
                        if let index = favoriteItemsIds.firstIndex(of: itemId) {
                            favoriteItemsIds.remove(at: index)
                        }
                    }
                }
            } else {
                Request.makeFavorite(state: .add ,itemId: itemId) { (message) in
                    if message {
                        self.favoriteButton.setImage(UIImage(named: "like1"), for: .normal)
                        favoriteItemsIds.append(itemId)
                    }
                }
            }
        }
    }
    
    
}

extension ProductItemVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControlImages.currentPage = Int(index)
    }
    
    @objc func autoScroll() {
        let scrollWidth = scrollView.bounds.width
        let currentXOffset = scrollView.contentOffset.x
        let lastXPos = currentXOffset + scrollWidth
        if lastXPos != scrollView.contentSize.width {
            scrollView.setContentOffset(CGPoint(x: lastXPos, y: 0), animated: true)
        }
        else {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
    
    
}
