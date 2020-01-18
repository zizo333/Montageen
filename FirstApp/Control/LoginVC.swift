//
//  LoginVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/20/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit
import JGProgressHUD

class LoginVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet var viewsUnderTF: [UIView]!

    // MARK: - Variables
    var leftButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addShowHideButton()
        leftButton.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // acitivity indicator frame and style
        createIndicator(vc: self)
    }

    
    // MARK: - Actions
    @IBAction func loginButton() {
        // check fields
        if textFields[0].text!.isEmpty && textFields[1].text!.isEmpty {
            showAlert(vc: self, message: "اكمل ادخال البيانات")
            return
        }
        guard let email = textFields[0].text , !email.isEmpty else {
            showAlert(vc: self, message: "ادخل البريد الالكتروني")
            return
        }
        guard let password = textFields[1].text , !password.isEmpty else {
            showAlert(vc: self, message: "ادخل الرقم السرى")
            return
        }
        
        // login request
        
        // check connectivity to the internet
        if Connection.HasConnection() {
            // show indicator
            showIndicator()
            Request.userLogin(email: email, password: password) { (userData) in
                if userData != nil {
                    if let userId = userData?.id {
                        saveUserId(userId: userId)
                    }
                    
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "homeId") as! UITabBarController
                    self.present(vc, animated: true, completion: nil)
                } else {
                    showAlert(vc: self, message: "تأكد من البيانات المدخلة")
                }
                // hide indicator
                hideIndicator()
            }
        } else {
            showAlert(vc: self, message: "لا يوجد اتصال بالانترنت")
        }
        
    }
    
    
    @IBAction func goToNewAccount() {
        let pvc = self.presentingViewController
        self.dismiss(animated: true) {
            let newAccountViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newAccountId") as! NewAccountVC
            pvc?.present(newAccountViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func goToBack() {
        dismiss(animated: true, completion: nil)
    }
    
    // add button to show or hide password
    private func addShowHideButton() {
        leftButton = UIButton(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
        leftButton.setBackgroundImage(UIImage(named: "spy"), for: .normal)
        leftButton.tintColor = UIColor.gray
        textFields[1].leftView = leftButton
        textFields[1].leftViewMode = UITextField.ViewMode.always
    }
    
    // add action for letButton
    @objc func showHidePassword() {
        if textFields[1].isSecureTextEntry {
            textFields[1].isSecureTextEntry = false
            leftButton.tintColor = UIColor.green
        } else {
            textFields[1].isSecureTextEntry = true
            leftButton.tintColor = UIColor.gray
        }
    }
    
    
}

// MARK: - Editing TextFields
extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewsUnderTF[textField.tag].backgroundColor = UIColor(red: 101/255, green: 205/255, blue: 42/255, alpha: 1)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewsUnderTF[textField.tag].backgroundColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.3)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let TFIndex = textField.tag + 1
        if textFields.count > TFIndex {
            textFields[textField.tag + 1].becomeFirstResponder()
        }
        return true
    }
    
}
