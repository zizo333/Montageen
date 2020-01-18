//
//  CustomButton.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/19/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var CornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable var BorderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var BorderColor: UIColor {
        get { return UIColor(cgColor: self.layer.borderColor!) }
        set { self.layer.borderColor = newValue.cgColor }
    }
}
