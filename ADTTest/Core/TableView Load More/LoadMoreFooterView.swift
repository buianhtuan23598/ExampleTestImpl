//
//  LoadMoreFooterView.swift
//  TokyoLife
//
//  Created by Tran Van Dinh on 8/8/18.
//  Copyright © 2018 EGLIFE. All rights reserved.
//

import UIKit

class LoadMoreFooterView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) { // For using CustomView in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // For using CustomView in IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Load view from nib
        Bundle.main.loadNibNamed("LoadMoreFooterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func startIndicator() -> Void {
        self.indicator.startAnimating()
    }

    func stopIndicator() -> Void {
        if self.indicator.isAnimating
        {
            self.indicator.stopAnimating()
        }
    }
}
