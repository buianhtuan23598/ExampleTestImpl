//
//  UIImageView+Extension.swift
//  ADTTest
//
//  Copyright © 2019 eragon. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    @IBInspectable var imageTintColor: UIColor? {
        get {
            return self.tintColor
        }
        set {
            if newValue != nil
            {
                self.image = self.image?.tint(with: newValue!)
            }
        }
    }
}
