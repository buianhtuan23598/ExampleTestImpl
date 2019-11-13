//
//  LoadingView.swift
//  NCSCamera
//
//  Created by Crep on 8/23/17.
//  Copyright © 2017 tubjng. All rights reserved.
//

import UIKit

class LoadingView: BaseView {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    func show(in view: UIView) {
        self.indicator.startAnimating()
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func close() {
        self.indicator.stopAnimating()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
        }, completion: {
            finished in
            self.removeFromSuperview()
        })
    }
    
    
}
