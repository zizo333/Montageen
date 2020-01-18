//
//  CustomTF.swift
//  FirstApp
//
//  Created by Zizo Adel on 12/20/19.
//  Copyright © 2019 Zizo Adel. All rights reserved.
//

import UIKit

extension UITextField {
            @IBInspectable var PlaceholderColor: UIColor {
                    get { return self.PlaceholderColor }
                    set {
                     self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: newValue])
                    }
            }
}
