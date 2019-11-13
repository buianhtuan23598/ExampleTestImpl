

import UIKit

class Screen1VC: BaseViewController, CellLabelDelegate {

    @IBOutlet weak var tableView: UITableView!
    var listData: NowPlayingModel?
    var listDataTop: NowPlayingModel?
    var listDataTrend: NowPlayingModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //init table
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.getData()
        self.getDataTop()
        self.getDataTrend()
        self.tabBarController?.tabBar.isHidden = false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func showMore(indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let vc = ShowMoreVC.init(nibName: "ShowMoreVC", bundle: nil)
            vc.arrCustomerOriginal = self.listData?.results ?? [Result]()
            vc.titleScreen = "Phim hay trong tháng"
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = ShowMoreVC.init(nibName: "ShowMoreVC", bundle: nil)
            vc.arrCustomerOriginal = self.listDataTop?.results ?? [Result]()
            vc.titleScreen = "Phim xem nhiều"
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = ShowMoreVC.init(nibName: "ShowMoreVC", bundle: nil)
            vc.arrCustomerOriginal = self.listDataTrend?.results ?? [Result]()
            vc.titleScreen = "Phim mới"
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("Default")
        }
    }
    func getData() {
        self.showLoading()
        Repository().adtDisplay(page: 1) { (response) in
            self.hideLoading()
            if response.isSuccess() {
                let data = JsonParserManager.nowPlay(jsonString: response.rawData ?? "")
                self.listData = data
            } else {
                self.showAlert(message: response.message)
            }
            self.tableView.reloadData()
        }
    }
    func getDataTop() {
        self.showLoading()
        Repository().adtDisplay(page: 2) { (response) in
            self.hideLoading()
            if response.isSuccess() {
                let data = JsonParserManager.nowPlay(jsonString: response.rawData ?? "")
                self.listDataTop = data
            } else {
                self.showAlert(message: response.message)
            }
            self.tableView.reloadData()
        }
    }
    func getDataTrend() {
        self.showLoading()
        Repository().adtDisplay(page: 3) { (response) in
            self.hideLoading()
            if response.isSuccess() {
                let data = JsonParserManager.nowPlay(jsonString: response.rawData ?? "")
                self.listDataTrend = data
            } else {
                self.showAlert(message: response.message)
            }
            self.tableView.reloadData()
        }
    }
}

