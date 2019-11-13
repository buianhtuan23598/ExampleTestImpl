//
//  AlertViewController.swift
//  Format
//
//  Created by Hoc Nguyen on 12/25/18.
//  Copyright © 2018 Nguyễn Trung. All rights reserved.
//

import UIKit

enum TypeAlertViewController: Int {
    case popover = 1
    case textField = 2
    case noShowCustom = 3
}

class AlertViewController: UIViewController {
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var donnateStartLabel: UILabel!
    @IBOutlet weak var popOverView: UIView!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var mainTextField: UITextField!
    @IBOutlet weak var buttonShowPopover: UIButton!
    
    var buttonOkOnClick: ((_ star: Int) -> ())?
    
    var titleText: String? = nil
    var messageText: String? = nil
    
    var typeAlertViewController: TypeAlertViewController = TypeAlertViewController.popover
    
    static func getStartViewController() -> AlertViewController {
        let vc = AlertViewController.init(nibName: "AlertViewController", bundle: nil)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()


        if let titleText = self.titleText {
            self.titleLabel.text = titleText
            self.viewTitle.isHidden = false
        } else {
             self.viewTitle.isHidden = true
        }
        
        if let messageText = self.messageText {
            self.messageLabel.text = messageText
            self.viewMessage.isHidden = false
        } else {
            self.viewMessage.isHidden = true
        }
        
        switch self.typeAlertViewController {
        case .popover:
            self.popOverView.isHidden = false
            self.textFieldView.isHidden = true
            self.buttonShowPopover.isEnabled = true
        case .textField:
            self.popOverView.isHidden = true
            self.textFieldView.isHidden = false
            self.buttonShowPopover.isEnabled = false
        case .noShowCustom:
            self.popOverView.isHidden = true
            self.textFieldView.isHidden = true
            self.buttonShowPopover.isEnabled = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let vc = owningViewController()
        
        if let listTabbarItem = vc?.tabBarController?.tabBar.items {
            for item in listTabbarItem {
                item.isEnabled = false
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let vc = owningViewController()
        
        if let listTabbarItem = vc?.tabBarController?.tabBar.items  {
            for item in listTabbarItem {
                item.isEnabled = true
            }
        }
    }
    
    @IBAction func changeStarDidTap(_ sender: UIButton) {

    }
    
    @IBAction func buttonOkDidTap(_ sender: Any) {

    }
    
    @IBAction func buttonCancelOnClick(_ sender: Any) {
         closeDialog()
    }
    
    func closeDialog() {
        self.dismiss(animated: false, completion: nil)
    }
}

extension AlertViewController: ReceiveActionFromPopoverProtocol, UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    func didReceiveActionAt(index: Int, type: PopoverType) {
    }
}
