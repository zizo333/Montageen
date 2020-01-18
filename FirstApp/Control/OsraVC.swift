//
//  OsraVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/31/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

class OsraVC: UIViewController {

    var osraItems: [ItemData] = []
    var familyName: String = ""
    var familyCity: String = ""
    
    // MARK: - Outlets
    @IBOutlet weak var osraNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var osraItemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        osraNameLabel.text = familyName
        cityNameLabel.text = familyCity
        if osraItems.count <= 0 {
            osraItemsTableView.isHidden = true
        }
        osraItemsTableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func dismissOsraPage() {
        dismiss(animated: true, completion: nil)
    }
    

}

extension OsraVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return osraItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell") as! ProductCell
        cell.generateCell(itemData: osraItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "showItemDataId") as! ProductItemVC
        tableView.deselectRow(at: indexPath, animated: true)
        vc.item = osraItems[indexPath.row]
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 187
    }
    
}
