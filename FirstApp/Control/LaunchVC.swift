//
//  LaunchVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 1/12/20.
//  Copyright © 2020 Zizo Adel. All rights reserved.
//

import UIKit

//var flag = 0
//var favoriteItemsIds: [Int] = []

class LaunchVC: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startIndicator()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { (timer) in
            self.stopIndicator()
//            self.initialConfig()
        })
    }
    
//    func initialConfig() {
//        if let id = getUserId() {
//            flag = 1
//            Request.getFavoriteItems(userId: id) { (itemArray) in
//                for item in itemArray {
//                    favoriteItemsIds.append(item.id!)
//                }
//            }
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "homeId")
//            present(vc, animated: true, completion: nil)
//        } else {
//            flag = 0
//            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "mainVC")
//            present(vc, animated: true, completion: nil)
//        }
//    }
    
    func startIndicator() {
        indicator.startAnimating()
    }
    
    func stopIndicator() {
        indicator.stopAnimating()
    }
    

}
