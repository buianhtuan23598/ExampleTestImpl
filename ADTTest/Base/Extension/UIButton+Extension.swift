
import Foundation
import UIKit

extension UIButton {
    // Set background color by hex value or constanst
    @IBInspectable var tintImageColor: String? {
        get {return nil}
        set(hexColor) {
            setButtonImageColor(hexColor: hexColor)
        }
    }
    
    func setButtonImageColor(hexColor: String?) {
        if let hexColorValue = hexColor {
            if (!hexColorValue.isEmpty) {
                // Load hexColor from const
                if (hexColorValue.starts(with: "@")) {
                    let hexColorFromArray = AppVariable.arrColor[hexColorValue]
                    if (hexColorFromArray != nil) {
                        let imageColor = UIColor(hexStr: hexColorFromArray!)
                        setImage(imageView?.image?.tint(with: imageColor), for: .normal)
                    }
                } else { // Load color from hex value
                    let imageColor = UIColor(hexStr: hexColorValue)
                    setImage(imageView?.image?.tint(with: imageColor), for: .normal)
                }
                
            }
        }
    }
}
