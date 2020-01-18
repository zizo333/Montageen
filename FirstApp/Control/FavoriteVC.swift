//
//  FavoriteVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/31/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var favoriteTableView: UITableView!
    
    // MARK: - Variables
    var dataArray: [ItemData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        downloadAllFavoriteItems()
    }

    // MARK: - Actions
    func downloadAllFavoriteItems() {
        if let id = getUserId() {
            Request.getFavoriteItems(userId: id) { (items) in
                if items.count > 0 {
                    self.dataArray = items
                    self.favoriteTableView.isHidden = false
                    self.favoriteTableView.reloadData()
                } else {
                    self.favoriteTableView.isHidden = true
                }
            }
        }
        
    }
    
    @IBAction func dismissFavoritePage() {
        dismiss(animated: true, completion: nil)
    }
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductCell
        cell.generateCell(itemData: dataArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "showItemDataId") as! ProductItemVC
        tableView.deselectRow(at: indexPath, animated: true)
        vc.item = dataArray[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
    
}
