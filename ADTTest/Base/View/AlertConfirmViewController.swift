//
//  AlertConfirmViewController.swift
//  Format
//
//  Created by Hoc Nguyen on 12/25/18.
//  Copyright © 2018 Nguyễn Trung. All rights reserved.
//

import UIKit

class AlertConfirmViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var buttonOK: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var viewMessage: UIView!
    
    var message: String?
    var titleText: String?
    var okTitle: String?
    var cancelTitle: String = ""
   
    
    var buttonOkOnClick: (() -> ())?
    var buttonCancelOnClick: (() -> ())?
    
    
    static func getStartViewController() -> AlertConfirmViewController {
        let vc = AlertConfirmViewController.init(nibName: "AlertConfirmViewController", bundle: nil)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonCancel.setTitle(cancelTitle, for: .normal)
        
        if let okTitle = self.okTitle {
            self.buttonOK.isHidden = false
            self.buttonOK.setTitle(okTitle, for: .normal)
        } else {
            self.buttonOK.isHidden = true
        }
        
        if let message = self.message {
            self.viewMessage.isHidden = false
            self.labelMessage.text = message
        } else {
            self.viewMessage.isHidden = true
        }
        
        if let title = self.titleText {
            self.viewTitle.isHidden = false
            self.titleLabel.text = title
        } else {
            self.viewTitle.isHidden = true
        }
        
    }
    
    @IBAction func buttonOKOnClick(_ sender: Any) {
        closeDialog()
        buttonOkOnClick?()
    }
    
    @IBAction func buttonCancelOnClick(_ sender: Any) {
        closeDialog()
        buttonCancelOnClick?()
    }
    
    func closeDialog() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func tapOutSizeContentView(_ sender: Any) {
        self.closeDialog()
    }
    

}
