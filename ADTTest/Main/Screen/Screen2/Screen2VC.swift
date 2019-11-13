
import UIKit

class Screen2VC: BaseViewController {
    
    var model: Result?
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initView()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func initView() {
        self.lblName.text = "Tên Phim: \(self.model?.originalTitle ?? "")"
        self.lblDate.text = "Ngày chiếu: \(self.model?.releaseDate ?? "")"
        self.lblRate.text = "Đánh giá: \(self.model?.voteAverage ?? 0) /10"
        self.lblDescription.text = "Tổng quan: \(self.model?.overview ?? "")"
        
        guard let img = self.model?.posterPath else {
            return
        }
        let urlImg = "https://image.tmdb.org/t/p/w500/\(img)"
        if let url = URL(string: urlImg) {
            self.imgMain.kf.setImage(with: url)
        }
    }
}
