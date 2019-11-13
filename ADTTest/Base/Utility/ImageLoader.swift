
import Foundation
import Kingfisher

class ImageLoader {
    static func loadImage(imageUrl: String, imageView: UIImageView) {
        if let img = Utils.shared.getCachedImage(urlString: imageUrl) {
            imageView.image = img
        } else {
            let url = URL(string: imageUrl)
            imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil)
        }
    }
}
