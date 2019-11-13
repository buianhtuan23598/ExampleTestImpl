//
//  UIImageExts.swift

import Foundation
import UIKit

/*
 Tint Color
 */
extension UIImage {
    
    //    func tint(with color: UIColor) -> UIImage {
    //        var image = withRenderingMode(.alwaysTemplate)
    //        UIGraphicsBeginImageContextWithOptions(size, false, scale)
    //        color.set()
    //
    //        image.draw(in: CGRect(origin: .zero, size: size))
    //        image = UIGraphicsGetImageFromCurrentImageContext()!
    //        UIGraphicsEndImageContext()
    //        return image
    //    }
    
    func tint(with color: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContext(self.size)
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        guard let cgImage = cgImage else { return self }
        
        // flip the image
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -size.height)
        
        // multiply blend mode
        context.setBlendMode(.multiply)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage)
        color.setFill()
        context.fill(rect)
        
        // create uiimage
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
}

extension UIImage {
    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }
}
