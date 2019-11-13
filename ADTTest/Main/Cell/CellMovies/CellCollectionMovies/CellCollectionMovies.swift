
import UIKit

class CellCollectionMovies: UICollectionViewCell {
    @IBOutlet weak var lblMoviesName: UILabel!
    @IBOutlet weak var imgMain: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(url: String) {
        let data = URL(string: url)
        self.imgMain.kf.setImage(with: data, placeholder: nil, options: nil, progressBlock: nil) { (image, size, cache, url) in
        }
    }
}
