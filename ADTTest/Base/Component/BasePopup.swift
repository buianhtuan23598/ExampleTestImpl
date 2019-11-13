
import Foundation
import UIKit

protocol BasePopup: AnyObject {
    
    var keyboardIsHiden: Bool { get set }
    var infomationView: UIView! { get set }
    
}

extension BasePopup where Self: UIView {
    
    func showInto(view: UIView) {
        self.infomationView.alpha = 0
        self.backgroundColor = UIColor.clear
        
        view.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            self.infomationView.alpha = 1
        }
        
    }
    
    /// show view
    func showView() {
        let window = UIApplication.shared.keyWindow!
        self.infomationView.alpha = 0
        self.backgroundColor = UIColor.clear
        window.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
            self.infomationView.alpha = 1
        }
    }
    /// hidenview
    func hideView() {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.backgroundColor = UIColor.clear
            self.infomationView.alpha = 0
            
        }, completion: {
            finished in
            self.removeFromSuperview()
        })
    }
    /// dismiss
    func dismiss(_ sender: UITapGestureRecognizer) {
        
        if keyboardIsHiden {
            let location = sender.location(in: self)
            if !self.infomationView.frame.contains(location) {
                self.hideView()
            }
        } else {
            endEditing(true)
        }
    }
}
