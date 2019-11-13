import Foundation
import UIKit

/*
 Size to fit
 */
extension UILabel {
    // Set font name
    @IBInspectable var isFitSize: Bool {
        get {return false}
        set(isCheck) {
            if (isCheck) {
                sizeToFit()
            }
        }
    }
}

/*
 Font
 */
extension UILabel {
    // Set font name
    @objc var substituteFontName: String {
        get {return self.font.fontName}
        set {self.font = UIFont(name: newValue, size: self.font.pointSize)}
    }
}

/*
 Color
 */
extension UILabel {
    // Set text color by hex value or constanst
    @IBInspectable var textColorHex: String? {
        get {return nil}
        set(hexColor) {
            setTextColorFromHex(hexColor: hexColor)
        }
    }
    
    func setTextColorFromHex(hexColor: String?) {
        if let hexColorValue = hexColor {
            if (!hexColorValue.isEmpty) {
                // Load hexColor from const
                if (hexColorValue.starts(with: "@")) {
                    let hexColorFromArray = AppVariable.arrColor[hexColorValue]
                    if (hexColorFromArray != nil) {
                        textColor = UIColor(hexStr: hexColorFromArray!)
                    }
                } else { // Load color from hex value
                    textColor = UIColor(hexStr: hexColorValue)
                }
            }
        }
    }
}

/*
 Localizable
 */
extension UILabel {
    // Set localizable key
    @IBInspectable var textLocalizable: String? {
        get {return nil}
        set(key) {
            text = key?.localized
        }
    }
}

//extension UILabel {
//    var substituteFontNameBold : String {
//        get { return self.font.fontName }
//        set {
//            if self.font.fontName.range(of:"-Bd") != nil {
//                self.font = UIFont(name: newValue, size: self.font.pointSize)
//            }
//        }
//    }
//}
//extension UITextField {
//    var substituteFontName : String {
//        get { return self.font!.fontName }
//        set { self.font = UIFont(name: newValue, size: (self.font?.pointSize)!) }
//    }
//}

extension UILabel {
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        
        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }
    
    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
        
        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
}
