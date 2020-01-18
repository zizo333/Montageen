//
//  NewAccountVC.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/19/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit
import JGProgressHUD

class NewAccountVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var viewsUnderTF: [UIView]!
    // tag: 0(name), 1(email), 2(phone), 3(phone code), 4(password), 5(confirmPass)
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var chooseCityView: UIView!
    @IBOutlet weak var clickableBtn: UIButton!
    @IBOutlet weak var showCityListView: UIView!
    @IBOutlet weak var showCaseListView: UIView!
    @IBOutlet weak var chooseCaseView: UIView!
    @IBOutlet weak var clickableBtn1: UIButton!
    @IBOutlet weak var caseLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    // MARK: - Variables
    var leftButtonPass: UIButton!
    var leftButtonConfirmPass: UIButton!
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // add gesture to view
        addGesture()
        
        leftButtonPass = UIButton(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
        leftButtonConfirmPass = UIButton(frame: CGRect(x: 0, y: 10, width: 25, height: 25))
        addShowHideButton(TF: textFields[4], btn: leftButtonPass)
        addShowHideButton(TF: textFields[5], btn: leftButtonConfirmPass)
        leftButtonPass.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        leftButtonConfirmPass.addTarget(self, action: #selector(showHideConfirmPassword), for: .touchUpInside)
        styleChooseViews(_view: chooseCityView)
        styleChooseViews(_view: chooseCaseView)
                
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObserves()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // acitivity indicator frame and style
        createIndicator(vc: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    // MARK: - Actions
    private func addGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture: )))
        view.addGestureRecognizer(tapGesture)
        
        let viewCityGesture = UITapGestureRecognizer(target: self, action: #selector(clickBtn))
        chooseCityView.addGestureRecognizer(viewCityGesture)
        let viewCaseGesture = UITapGestureRecognizer(target: self, action: #selector(clickBtn1))
        chooseCaseView.addGestureRecognizer(viewCaseGesture)
    }
    
    @objc func clickBtn() {
        UIView.animate(withDuration: 0.4) {
            self.clickableBtn.alpha = 0.5
            self.clickableBtn.alpha = 1
            self.showCityListView.alpha = 1
            self.showCaseListView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    @objc func clickBtn1() {
        UIView.animate(withDuration: 0.4) {
            self.clickableBtn1.alpha = 0.5
            self.clickableBtn1.alpha = 1
            self.showCaseListView.alpha = 1
            self.showCityListView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func styleChooseViews(_view: UIView) {
        _view.layer.shadowRadius = 4
        _view.layer.shadowColor = UIColor.darkGray.cgColor
        _view.layer.shadowOpacity = 0.5
        _view.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /**** login ****/
    @IBAction func goToLoginBtn() {
        
        let pvc = self.presentingViewController
        self.dismiss(animated: true) {
            let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginId") as! LoginVC
            pvc?.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func goToBack() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chooseAction(_ sender: UIButton) {
        if sender.tag < 4 {
            cityLabel.text = sender.titleLabel?.text!
            showCityListView.alpha = 0
        } else {
            caseLabel.text = sender.titleLabel?.text!
            showCaseListView.alpha = 0
        }
        
    }
    @IBAction func newRegisterAction() {
        guard let name = textFields[0].text , !name.isEmpty else {
            showAlert(vc: self, message: "ادخل اسم المستخدم")
            return
        }
        guard let email = textFields[1].text, !email.isEmpty else {
            showAlert(vc: self, message: "ادخل البريد الالكتروني")
            return
        }
        guard let phoneNumber = textFields[2].text, !phoneNumber.isEmpty else {
            showAlert(vc: self, message: "ادخل رقم الهاتف")
            return
        }
        guard let codeArea = textFields[3].text, !codeArea.isEmpty else {
            showAlert(vc: self, message: "ادخل كود البلد")
            return
        }
        guard let password = textFields[4].text, !password.isEmpty else {
            showAlert(vc: self, message: "ادخل كلمة السر")
            return
        }
        guard let confirmPassword = textFields[5].text, !confirmPassword.isEmpty else {
            showAlert(vc: self, message: "ادخل اعادة كلمة السر")
            return
        }
        guard password == confirmPassword else {
            showAlert(vc: self, message: "كلمة السر غير متطابقة")
            return
        }
        
        var role: String = ""
        var cityNumber: String = ""
        // get city number
        switch cityLabel.text! {
        case "الرياض":      cityNumber = "1"
        case "مكة":         cityNumber = "2"
        default:            cityNumber = "3"
        }
        // get role number
        switch caseLabel.text! {
        case "عميل":      role = "1"
        case "مندوب":         role = "2"
        default:            role = "3"
        }
        
        let phoneNumberWithCountryCode = codeArea + phoneNumber
        let newUser: NewUser = NewUser()
        newUser.name = name
        newUser.email = email
        newUser.city = cityNumber
        newUser.phoneNumber = phoneNumberWithCountryCode
        newUser.password = password
        newUser.userType = role
        // MARK: - get request result
        // check the connection to the internet
        if Connection.HasConnection() {
            /* Start indicator */
            showIndicator()
            Request.userRegister(newUser: newUser) { (userData) in
                /* hide indicator */
                hideIndicator()
                if userData != nil {
                    if let userId = userData?.id {
                        saveUserId(userId: userId)
                    }
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "homeId") as! UITabBarController
                    self.present(vc, animated: true, completion: nil)
                } else {
                    showAlert(vc: self, message: "المستخدم موجود بالفعل")
                }
            }
        } else {
            showAlert(vc: self, message: "لا يوجد اتصال بالانترنت")
        }
        
    }
    
    // add button to show or hide password
    private func addShowHideButton(TF: UITextField, btn: UIButton) {
        btn.setBackgroundImage(UIImage(named: "spy"), for: .normal)
        btn.tintColor = UIColor.gray
        TF.leftView = btn
        TF.leftViewMode = UITextField.ViewMode.always
    }
    
    // add action for letButton
    @objc func showHidePassword() {
        if textFields[4].isSecureTextEntry {
            textFields[4].isSecureTextEntry = false
            leftButtonPass.tintColor = UIColor.green
        } else {
            textFields[4].isSecureTextEntry = true
            leftButtonPass.tintColor = UIColor.gray
        }
    }
    @objc func showHideConfirmPassword() {
        if textFields[5].isSecureTextEntry {
            textFields[5].isSecureTextEntry = false
            leftButtonConfirmPass.tintColor = UIColor.green
        } else {
            textFields[5].isSecureTextEntry = true
            leftButtonConfirmPass.tintColor = UIColor.gray
        }
    }
    
}

// MARK: - Editing TextFields
extension NewAccountVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        viewsUnderTF[textField.tag].backgroundColor = UIColor(red: 101/255, green: 205/255, blue: 42/255, alpha: 1)
            showCityListView.alpha = 0
            showCaseListView.alpha = 0
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

// MARK: - Scroll view whith textField
extension NewAccountVC {
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
        self.showCityListView.alpha = 0
        self.showCaseListView.alpha = 0
    }
    
    // MARK: - Add observers to notify the keyboard state
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
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height - 20, right: 0)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.scrollView.contentInset = UIEdgeInsets.zero
    }
    
    
}
