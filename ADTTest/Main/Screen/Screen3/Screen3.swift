
import UIKit

class Screen3: BaseViewController, CellLabelDelegate {

    var listData: TopRateModel?
    var listDataTop: TopRateModel?
    var listDataTrend: TopRateModel?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getData()
        self.getDataTrend()
        self.getDataTop()
        //init tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
        
    func showMore(indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let vc = ShowMoreRate.init(nibName: "ShowMoreRate", bundle: nil)
            vc.arrCustomerOriginal = self.listData?.results ?? [TopRateModel.Result]()
            vc.titleScreen = "Top Phim hay trong tháng"
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = ShowMoreRate.init(nibName: "ShowMoreRate", bundle: nil)
            vc.arrCustomerOriginal = self.listDataTop?.results ?? [TopRateModel.Result]()
            vc.titleScreen = "Top xem nhiều"
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = ShowMoreRate.init(nibName: "ShowMoreRate", bundle: nil)
            vc.arrCustomerOriginal = self.listDataTrend?.results ?? [TopRateModel.Result]()
            vc.titleScreen = "Top Rate"
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("Default")
        }
    }
    
    func getData() {
        self.showLoading()
        Repository().topRate(page: 1) { (response) in
            self.hideLoading()
            if response.isSuccess() {
                let data = JsonParserManager.topRate(jsonString: response.rawData ?? "")
                self.listData = data
            } else {
                self.showAlert(message: response.message)
            }
            self.tableView.reloadData()
        }
    }
    func getDataTop() {
        self.showLoading()
        Repository().topRate(page: 2) { (response) in
            self.hideLoading()
            if response.isSuccess() {
                let data = JsonParserManager.topRate(jsonString: response.rawData ?? "")
                self.listDataTop = data
            } else {
                self.showAlert(message: response.message)
            }
            self.tableView.reloadData()
        }
    }
    func getDataTrend() {
        self.showLoading()
        Repository().topRate(page: 3) { (response) in
            self.hideLoading()
            if response.isSuccess() {
                let data = JsonParserManager.topRate(jsonString: response.rawData ?? "")
                self.listDataTrend = data
            } else {
                self.showAlert(message: response.message)
            }
            self.tableView.reloadData()
        }
    }
}
