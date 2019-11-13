//
//  FormatLoadingView.swift
//  Format
//
//  Created by Nguyễn Trung on 1/2/19.
//  Copyright © 2019 Nguyễn Trung. All rights reserved.
//

import UIKit

protocol ViewContainsFormatLoadingViewProtocol: AnyObject {
    var formatLoadingView: FormatLoadingView? { get set }
    
    func showFormatLoadingView(_ show: Bool)
}

extension ViewContainsFormatLoadingViewProtocol {
    func showFormatLoadingView(in view: UIView, show: Bool = true) {
        if show {
            if self.formatLoadingView == nil {
                self.formatLoadingView = FormatLoadingView()
            }
            self.formatLoadingView!.show(in: view)
        } else {
            guard self.formatLoadingView != nil else { return }
            self.formatLoadingView!.close()
            self.formatLoadingView = nil
        }
    }
}


class FormatLoadingView: BaseView {

    var imageView: UIImageView?
    
    func show(in view: UIView) {
        
        let heightImage: CGFloat = 50
        
        let jeremyGif = UIImage.gifImageWithName("logo_fm_app_gif_loading-01-")
        self.imageView = UIImageView(image: jeremyGif)
        guard let imageView = self.imageView else { return }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: heightImage * 841 / 236).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: heightImage).isActive = true
        
        
        
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func close() {
       
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.backgroundColor = UIColor(white: 0.0, alpha: 0.0)
        }, completion: {
            finished in
            if let imageView = self.imageView {
               self.willRemoveSubview(imageView)
            }
            
            self.removeFromSuperview()
        })
    }
    
}
