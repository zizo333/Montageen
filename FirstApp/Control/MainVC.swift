//
//  ViewController.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/19/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController {

    // MARK: Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    // MARK: - actions
    @IBAction func showAllProduct() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "homeId") as! UITabBarController
        self.present(mainVC, animated: true, completion: nil)
    }
    

}

