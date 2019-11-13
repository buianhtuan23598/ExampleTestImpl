
import UIKit

class BaseView: UIView {
    
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.width
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.height
    
    //MARK: view used for init from nib
    var view: UIView!
    
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: - Init -
    //-------------------------------------------------------------------------------------------------------
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: self.SCREEN_WIDTH, height: self.SCREEN_HEIGHT))
        xibSetup()
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: - Show on super view -
    //-------------------------------------------------------------------------------------------------------
    func addToWindow() {
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    //-------------------------------------------------------------------------------------------------------
    //MARK: - Setup Xib -
    //-------------------------------------------------------------------------------------------------------
    
    private func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        // Make the view stretch with containing view
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
        
    }
    
    private func loadViewFromNib() -> UIView {
        let name = String(describing: type(of: self))
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: name, bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func showAlert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let vc = owningViewController()
        vc?.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
