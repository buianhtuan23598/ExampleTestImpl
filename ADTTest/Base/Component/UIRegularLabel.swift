

import UIKit

@IBDesignable class UIRegularLabel: UILabel {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    func commonInit(){
        self.font = UIFont(name:"UTM-Helve", size: 12.0)
    }
    
    @IBInspectable var fontSize: CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            self.font = self.font.withSize(newValue)
        }
    }
    
}
