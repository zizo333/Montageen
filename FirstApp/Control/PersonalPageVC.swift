//
//  PersonalPageVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/30/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

class PersonalPageVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - Variables
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo()
    }
    
    @IBAction func dismissProfilePage() {
        dismiss(animated: true, completion: nil)
    }
    func getUserInfo() {
        if let userId = self.userId {
            Request.userProfile(userId: userId) { (profileInfo) in
                if let info = profileInfo {
                    self.addInfoToIB(info: info)
                }
            }
        }
    }

    func addInfoToIB(info: ProfileInfo) {
        nameLabel.text = info.name ?? "name"
        phoneLabel.text = info.phone ?? "phone"
        emailLabel.text = info.email ?? "email"
    }
}
