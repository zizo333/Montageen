//
//  OrderVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 1/18/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

class OrderVC: UIViewController {

    // MARK: - Variables
    var userId: Int?
    var userRol: Int?
    var orders: [MyOrderData] = []
    
    
    // MARK: - Outlets
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var noOrderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTableView.separatorStyle = .none
                
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getAllOrders()
    }
    
    // MARK: - Actions
    
    func getAllOrders() {
        if let userId = getUserId() {
            Request.userProfile(userId: userId) { (profileInfo) in
                if let info = profileInfo {
                    self.userId = info.id!
                    self.userRol = info.role!
                    
                    let params: [String : Int] = ["user_id" : 69, "user_role" : 1]
                    
                    Request.getMyOrder(parameters: params) { (allOrders) in
                        if let orders = allOrders {
                            self.orderTableView.isHidden = false
                            self.noOrderLabel.isHidden = true
                            self.orders = orders
                            self.orderTableView.reloadData()
                        } else {
                            self.orderTableView.isHidden = true
                            self.noOrderLabel.isHidden = false
                        }
                    }
                }
            }
        }
        
    }
    
}

extension OrderVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrderCell
        cell.generateCell(data: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
    
}
