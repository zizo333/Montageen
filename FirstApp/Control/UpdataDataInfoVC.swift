//
//  UpdataDataInfoVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/30/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

class UpdataDataInfoVC: UIViewController {

    // MARK: - Variables
    var userId: Int?
    
    var leftOldPassButton: UIButton!
    var leftNewPassButton: UIButton!
    var leftCPassButton: UIButton!
    var leftButtons: [UIButton]!

    // MARK: - Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var oldPasswordTF: UITextField!
    @IBOutlet weak var newPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    var textFields: [UITextField]!
    @IBOutlet var viewsUnderTF: [UIView]!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserName()
        addObserves()
        textFields =  [nameTF, oldPasswordTF, newPasswordTF, confirmPasswordTF]
        setFrame()
        leftButtons = [leftOldPassButton, leftNewPassButton, leftCPassButton]
        for i in 0..<leftButtons.count {
            addShowHideButton(index: i)
        }
        for i in 0..<leftButtons.count {
            addGestureForButtons(index: i)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createIndicator(vc: self)
    }
    
    // MARK: - Actions
    func setUserName() {
        if let userId = self.userId {
            Request.userProfile(userId: userId) { (profileInfo) in
                if let info = profileInfo {
                    self.nameTF.text = info.name ?? ""
                }
            }
        }
    }
    
    @IBAction func dismissUpdateInfoPage() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateDataAction() {
        guard let oldPassword = oldPasswordTF.text, !oldPassword.isEmpty else {
            showAlert(vc: self, message: "ادخل كلمة السر القديمة")
            return
        }
        guard let newPassword = newPasswordTF.text, !newPassword.isEmpty else {
            showAlert(vc: self, message: "ادخل كلمة السر الجديدة")
            return
        }
        guard let confirmPassword = confirmPasswordTF.text, !confirmPassword.isEmpty else {
            showAlert(vc: self, message: "ادخل اعادة كلمة السر الجديدة")
            return
        }
        guard newPassword == confirmPassword else {
            showAlert(vc: self, message: "كلمة السر غير متطابقة")
            return
        }
        if Connection.HasConnection() {
            showIndicator()
            Request.changePassword(userId: userId!, oldPass: oldPassword, newPass: newPassword) { (message) in
                if let msg = message, msg == true {
                    showAlert(vc: self, message: "تم تغيير الرقم السرى")
                    self.emptyFields()
                } else {
                    showAlert(vc: self, message: "تأكد من الرقم القديم")
                }
            }
        } else {
            showAlert(vc: self, message: "لا يوجد اتصال بالانترنت")
        }
        hideIndicator()
    }
    
    func emptyFields() {
        oldPasswordTF.text = ""
        confirmPasswordTF.text = ""
    }
    @IBAction func cancelUpdateDataActionn() {
        dismissUpdateInfoPage()
    }
    
    // set frame of let buttons
    func setFrame() {
        leftOldPassButton = UIButton(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
        leftNewPassButton = UIButton(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
        leftCPassButton = UIButton(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
    }
    
    // add button to show or hide password
    private func addShowHideButton(index: Int) {
        leftButtons[index].setBackgroundImage(UIImage(named: "spy"), for: .normal)
        leftButtons[index].tintColor = UIColor.gray
        textFields[index + 1].leftView = leftButtons[index]
        textFields[index + 1].leftViewMode = UITextField.ViewMode.always
    }
    
    // add gesture for left buttons
    func addGestureForButtons(index: Int) {
        switch index {
        case 0:
            leftOldPassButton.addTarget(self, action: #selector(showHideOldPassword), for: .touchUpInside)
        case 1:
            leftNewPassButton.addTarget(self, action: #selector(showHideNewPassword), for: .touchUpInside)
        default:
            leftCPassButton.addTarget(self, action: #selector(showHideConfirmPassword), for: .touchUpInside)
        }
        
    }
    
    // add action for letButton
    @objc func showHideOldPassword() {
        if oldPasswordTF.isSecureTextEntry {
            oldPasswordTF.isSecureTextEntry = false
            leftOldPassButton.tintColor = UIColor.green
        } else {
            oldPasswordTF.isSecureTextEntry = true
            leftOldPassButton.tintColor = UIColor.gray
        }
    }
    @objc func showHideNewPassword() {
        if newPasswordTF.isSecureTextEntry {
            newPasswordTF.isSecureTextEntry = false
            leftNewPassButton.tintColor = UIColor.green
        } else {
            newPasswordTF.isSecureTextEntry = true
            leftNewPassButton.tintColor = UIColor.gray
        }
    }
    @objc func showHideConfirmPassword() {
        if confirmPasswordTF.isSecureTextEntry {
            confirmPasswordTF.isSecureTextEntry = false
            leftCPassButton.tintColor = UIColor.green
        } else {
            confirmPasswordTF.isSecureTextEntry = true
            leftCPassButton.tintColor = UIColor.gray
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

// MARK: - Editing TextFields
extension UpdataDataInfoVC: UITextFieldDelegate {
    
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
        } else {
            updateDataAction()
        }
        return true
    }
    
}

extension UpdataDataInfoVC {
    func addObserves() {
        // MARK: - Keyboard will show
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // MARK: - Keyboard will hide
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - remove observer
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let height = keyboardSize.height - (self.view.frame.height - self.cancelButton.center.y + 25)
        self.view.frame.origin.y = -height
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}
