
//
//  PopoverControllerProtocol.swift
//  NCCameraV2
//
//  Created by Crep on 1/12/18.
//  Copyright © 2018 NhatCuong. All rights reserved.
//

import Foundation
import UIKit

import Foundation

enum PopoverType: Int {
    case unknown
    case defaultRecharge = 1
    case changeStar = 2
}


protocol PopoverControllerProtocol: AnyObject {
    var dataSource: [ObjectForPopoverSource]! { get set }
    var type: PopoverType { get set }
    var delegate: UIPopoverPresentationControllerDelegate? { get set }
    var contentSize: CGSize! { get set }
    var sourceView: UIView! { get set }
    var sourceRect: CGRect! { get set }
    var direction: UIPopoverArrowDirection! { get set }
    
    var selectedIndex: Int { get set }
    
    var actionDelegate: ReceiveActionFromPopoverProtocol? { get set }
    
}

extension PopoverControllerProtocol where Self: UIViewController {

    func setDataSource(_ dataSource: [ObjectForPopoverSource]) {
        if self.dataSource == nil {
            self.dataSource = []
        }
        self.dataSource.removeAll()
        self.dataSource.append(contentsOf: dataSource)
    }
    
    func setupPopoverController() {
        self.modalPresentationStyle = .popover
        self.preferredContentSize = self.contentSize
        
        let popoverPresentationViewController = self.popoverPresentationController
        if self.direction != nil {
            popoverPresentationViewController?.permittedArrowDirections = self.direction
        }
        popoverPresentationViewController?.backgroundColor = UIColor.white
        popoverPresentationViewController?.delegate = self.delegate
        popoverPresentationViewController?.sourceView = self.sourceView
        popoverPresentationViewController?.sourceRect = self.sourceRect
    }
}


protocol ObjectForPopoverSource {
    var displayName: String { get }
    
}

protocol ReceiveActionFromPopoverProtocol {
    func didReceiveActionAt(index: Int, type: PopoverType)
}
