//
//  ViewContainsLoading.swift
//  PublicServiceLeader
//
//  Created by Crep on 6/15/18.
//  Copyright © 2018 NhatCuong. All rights reserved.
//

import Foundation
import UIKit

protocol ViewContainsLoadingViewProtocol: AnyObject {
    var loadingView: LoadingView? { get set }
    
    func showLoadingView(_ show: Bool)
}

extension ViewContainsLoadingViewProtocol {
    func showLoadingView(in view: UIView, show: Bool = true) {
        if show {
            if self.loadingView == nil {
                self.loadingView = LoadingView()
            }
            self.loadingView!.show(in: view)
        } else {
            guard self.loadingView != nil else { return }
            self.loadingView!.close()
            self.loadingView = nil
        }
    }
}
