//
//  ViewHasToolBar.swift
//  PickDriver
//
//  Created by eragon on 4/17/19.
//  Copyright © 2019 eragon. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol ViewHasConfirmToolbar {
    func toolBarItemNextDidTap()
}

extension ViewHasConfirmToolbar where Self: UIViewController {
    
    func showConfirmToolbarWhenTap(textField: UITextField) {
        let confirmToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        confirmToolbar.barStyle = .default
        confirmToolbar.backgroundColor = UIColor.init(hexStr: "00003B")
        
        let barButtonNext = UIBarButtonItem(title: "Tiếp tục", style: .plain, target: self, action: #selector(toolBarItemNextDidTap))
        barButtonNext.width = UIScreen.main.bounds.width
        barButtonNext.tintColor = UIColor.white
        confirmToolbar.items = [barButtonNext]
        confirmToolbar.sizeToFit()
        
        textField.inputAccessoryView = confirmToolbar
    }
}
