//
//  Helpers.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/20/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit
import JGProgressHUD
import NVActivityIndicatorView

/***** show alert  *****/
let hud = JGProgressHUD(style: .dark)
// MARK: - Show alert
public func showAlert(vc: UIViewController, message: String) {
    hud.textLabel.text = message
    hud.indicatorView = JGProgressHUDErrorIndicatorView()
    hud.show(in: vc.view)
    hud.dismiss(afterDelay: 2.0)
}

/***** show indicator *****/
// MARK: - Variables
var activityIndicator: NVActivityIndicatorView?
var VC: UIViewController!
public func createIndicator(vc: UIViewController) {
    // acitivity indicator frame and style
    VC = vc
    activityIndicator = NVActivityIndicatorView(frame: CGRect(x: vc.view.frame.width / 2 - 30, y: vc.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballBeat, color: #colorLiteral(red: 0.9998469949, green: 0.4941213727, blue: 0.4734867811, alpha: 1), padding: nil)
}

// MARK: - Show activity indicator
public func showIndicator() {
    if activityIndicator != nil {
        VC.view.addSubview(activityIndicator!)
        activityIndicator!.startAnimating()
    }
}
// MARK: - Hide activity indicator
public func hideIndicator() {
    if activityIndicator != nil {
        activityIndicator!.removeFromSuperview()
        activityIndicator!.stopAnimating()
    }
}

// MARK: - show image when there is no connection with internet
var connectionFailure: UIImageView!

public func showConnectionFailedImage(vc: UIViewController) {
    let imageWidth = vc.view.frame.width / 2
    let imageHeight = vc.view.frame.height / 2
    let image_co_x = imageWidth - (imageWidth / 2)
    let image_co_y = imageHeight - (imageHeight / 2)
    connectionFailure = UIImageView(frame: CGRect(x: image_co_x, y: image_co_y, width: imageWidth, height: imageHeight))
    connectionFailure.image = UIImage(named: "dropbox")
    connectionFailure.tintColor = UIColor.gray
    vc.view.addSubview(connectionFailure)
}

public func hideConnectionFailedImage(vc: UIViewController) {
    if connectionFailure == nil {
        return
    } else {
        connectionFailure.removeFromSuperview()
    }
}

// MARK: - save user hash to memory
public func saveUserId(userId: Int) {
    let def = UserDefaults.standard
    def.set(userId, forKey: KUSERID)
    def.synchronize()
}

public func removeUserId(userId: Int) {
    let def = UserDefaults.standard
    if getUserId() != nil {
        def.removeObject(forKey: KUSERID)
    }
    
}

public func getUserId() -> Int? {
    let def = UserDefaults.standard
    return def.object(forKey: KUSERID) as? Int
}

// MARK: - access appScendDelegate
public func restartApp() {
//    let mySceneDelegate = UIApplication.shared.windows[0]
//    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "homeId")
//    mySceneDelegate.rootViewController = vc
}
