//
//  ProductTableView.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/20/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

class ProductTableView: UITableViewController {

    // MARK: - Outlets
    @IBOutlet var itemsTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var leftViewLayout: NSLayoutConstraint!
    @IBOutlet weak var cartItemsNumberLabel: UILabel!
    
    
    // MARK: - variables
    var itemsData: [ItemData] = []
    let reachability = try! Reachability()
    var firstConnected = 0
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSearchView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createIndicator(vc: self)
        downloadAllItems(searchItem: "")
        updateSearchField()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    
    //MARK: - Download all items from server
    private func downloadAllItems(searchItem: String) {
        if reachability.connection == .wifi || reachability.connection == .cellular {
            DispatchQueue.main.async {
                showIndicator()
                hideConnectionFailedImage(vc: self)
            }
            
            Request.getAllItems(itemKeyword: searchItem) { (allItems) in
                DispatchQueue.main.async {
                    self.itemsData = allItems
                    self.itemsTableView.reloadData()
                    hideIndicator()
                }
            }
            
            self.getNumberOfCartItems()
        }

        reachability.whenUnreachable = { _ in
            DispatchQueue.main.async {
                showConnectionFailedImage(vc: self)
                showAlert(vc: self, message: "لا يوجد اتصال بالانترنت")
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func searchButton() {
        showSearchView()
    }
    
    @IBAction func hideSearchButton() {
        hideSearchView()
    }
    
    func getNumberOfCartItems() {
        if let userId = getUserId() {
            let parameters: [String : Int] = ["owner" : userId]
            Request.getCartItems(parameters: parameters) { (data) in
                if data.count > 0 {
                    self.cartItemsNumberLabel.isHidden = false
                    self.cartItemsNumberLabel.text = "\(data.count)"
                }else{
                    self.cartItemsNumberLabel.isHidden = true
                }
                
            }
        }
        
    }
    
    // MARK: - Hide and show search view
    private func hideSearchView() {
        
        leftViewLayout.constant = -1 * self.view.frame.width
    }
    
    private func showSearchView() {
        leftViewLayout.constant = 0
        searchTextField.becomeFirstResponder()
    }
    
    // MARK: - Add search button to serach text field
    private func updateSearchField() {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: self.searchTextField.frame.height))
        let rightButton = UIButton(frame: CGRect(x: 8, y: (self.searchTextField.frame.height / 2) - 10, width: 20, height: 20))
        rightButton.setBackgroundImage(UIImage(named: "search"), for: .normal)
        rightButton.tintColor = UIColor.gray
        rightView.addSubview(rightButton)
        searchTextField.rightView = rightView
        searchTextField.rightViewMode = UITextField.ViewMode.always
        // add action to right button
        rightButton.addTarget(self, action: #selector(searchProducts), for: .touchUpInside)
    }
    
    // search for products
    @objc func searchProducts() {
        downloadAllItems(searchItem: searchTextField.text ?? "")
        searchTextField.text = ""
        hideSearchView()
        self.view.endEditing(true)
    }
    
    // check the internet
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        switch reachability.connection {
        case .wifi, .cellular:
            DispatchQueue.main.async {
                if self.firstConnected != 0 {
                    showAlert(vc: self, message: "تم الاتصال بالانترنت")
                }
            }
            downloadAllItems(searchItem: "")
        case .unavailable:
            DispatchQueue.main.async {
                self.itemsData = []
                self.itemsTableView.reloadData()
                showAlert(vc: self, message: "لا يوجد اتصال بالانترنت")
            }
            firstConnected = 1
        default:
            break
        }
    }
    
    // MARK: - basket
    @IBAction func oopenBasket() {
    }
    
    
}

extension ProductTableView {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductCell
        
        cell.generateCell(itemData: itemsData[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToSelectedItem", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSelectedItem" {
            let selectedItem = itemsData[sender as! Int]
            let destVC = segue.destination as! ProductItemVC
            
            destVC.item = selectedItem
        }
    }
    
    // MARK: - set height of the cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
}

