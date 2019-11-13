

import UIKit

protocol CellLabelDelegate {
    func showMore(indexPath: IndexPath)
}

class CellLabel: UITableViewCell {

    var delegate : CellLabelDelegate! = nil
    var indexPath = IndexPath(row: -1, section: -1)
    @IBOutlet weak var lblConten: UILabel!
    @IBAction func touchShowMore(_ sender: Any) {
        delegate.showMore(indexPath: indexPath)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
