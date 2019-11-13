
import UIKit

class CellImageMovies: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var imgMain: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(url: String) {
        let data = URL(string: url)
        self.imgMain.kf.setImage(with: data, placeholder: nil, options: nil, progressBlock: nil) { (image, size, cache, url) in
        }
    }
}
