//
//  BasketVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/31/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

class BasketVC: UIViewController {

    var data: [CartData] = []
    var userId: Int!
    var buttonTag = 0
    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userId = getUserId()!
        let parameters: [String : Int] = ["owner" : userId]
        Request.getCartItems(parameters: parameters) { (data) in
            if data.count > 0 {
                self.data = data
                self.orderTableView.reloadData()
                self.containerView.isHidden = false
            } else {
                self.orderTableView.isHidden = true
            }
        }
    }
    
//    func getUserRolAndId() {
//        
//        Request.userProfile(userId: userId) { (data) in
//            if let rol = data?.role {
//                self.userRol = rol
//            }
//        }
//    }
    
    // MARK: - Actions
    @IBAction func dismissBasketScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmAllItems() {
    }
    
    @IBAction func getThePlaceOfReceiving() {
    }
    @IBAction func chooseTheDeliver() {
    }
    
}

extension BasketVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "backetCell") as! ProductCell
        cell.generateCell(itemData: data[indexPath.row])
        cell.deleteOrderButton.addTarget(self, action: #selector(deleteItemFromCart(sender:)), for: .touchUpInside)
        cell.editOrderButton.addTarget(self, action: #selector(editOrderAction(sender:)), for: .touchUpInside)
        cell.deleteOrderButton.tag = buttonTag
        cell.editOrderButton.tag = buttonTag
        buttonTag += 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
    
    @objc func deleteItemFromCart(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let selectedCell = orderTableView.cellForRow(at: indexPath) as! ProductCell
        guard let userId = getUserId(), let cartId = selectedCell.cartId else { return }

        let parameters: [String : Int] = ["user_id" : userId, "cart_id" : cartId]
        Request.deleteCartItem(parameters: parameters) { (success) in
            if success {
                showAlert(vc: self, message: "تم الحذف من السلة")
                self.data.remove(at: sender.tag)
                self.buttonTag = 0
                self.orderTableView.reloadData()
                if self.data.count <= 0 {
                    self.orderTableView.isHidden = true
                    self.containerView.isHidden = true
                }
            }
        }
    }
    
    @objc func editOrderAction(sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let selectedCell = orderTableView.cellForRow(at: indexPath) as! ProductCell
    }
    
}
