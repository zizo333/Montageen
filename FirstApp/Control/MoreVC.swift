//
//  MoreVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/22/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

class MoreVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = true
    }
    
    
    func logOutAction() {
        if let currentUser = getUserId() {
            let alert = UIAlertController(title: "تسجيل الخروج", message: "هل ترغب فى تسجيل الخروج", preferredStyle: .alert)
            let action = UIAlertAction(title: "موافق", style: .default) { (action) in
                removeUserId(userId: currentUser)
                if flag == 1 {
                    self.dismiss(animated: true) {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "mainVC") as! MainVC
                        self.present(vc, animated: true, completion: nil)
                    }
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            let cancelAction = UIAlertAction(title: "الغاء", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        } else {
            createNewAccount()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            if let currentUserId = getUserId() {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "profileVC") as! PersonalPageVC
                vc.userId = currentUserId
                present(vc, animated: true, completion: nil)
            } else {
                createNewAccount()
            }
        case 2:
            break
        case 3:
            if let _ = getUserId() {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "favoriteVC") as! FavoriteVC
                present(vc, animated: true, completion: nil)
            } else {
                createNewAccount()
            }
        case 4:
            if let currentUserId = getUserId() {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "updateDataVC") as! UpdataDataInfoVC
                vc.userId = currentUserId
                present(vc, animated: true, completion: nil)
            } else {
                createNewAccount()
            }
        case 5:
            logOutAction()
        default:
            break
        }
    }
    
    func createNewAccount() {
        let pvc = self.presentingViewController
        self.dismiss(animated: true) {
            let newAccountViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newAccountId") as! NewAccountVC
            pvc?.present(newAccountViewController, animated: true, completion: nil)
        }
    }
}

