

import UIKit

class ShowMoreVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var lblList: UILabel!
    var arrCustomerOriginal: [Result] = [Result]()
    var arrCustomer: [Result] = [Result]()
    var titleScreen: String = ""
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectView: UICollectionView!
    var showGird: Bool = true
    var loadingData: Bool = false
    
    var refreshControl   = UIRefreshControl()
    
    @IBAction func touchList(_ sender: Any) {
        if showGird {
            self.tableView.isHidden = true
            self.collectView.isHidden = false
            self.lblList.text = "Grid"
        } else {
            self.tableView.isHidden = false
            self.collectView.isHidden = true
            self.lblList.text = "List"
        }
        showGird = !showGird
    }
    
    @IBAction func touchBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
        
        self.lblTitle.text = self.titleScreen
        // Do any additional setup after loading the view.
        self.collectView.dataSource = self
        self.collectView.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 2.0
        layout.minimumInteritemSpacing = 2.0
        collectView.setCollectionViewLayout(layout, animated: false)
        collectView.register(UINib.init(nibName: "CellCollectionMovies", bundle: nil), forCellWithReuseIdentifier: "CellCollectionMovies")
        self.collectView.reloadData()
        self.tableView.reloadData()
        self.arrCustomer = self.arrCustomerOriginal
        searchBar.delegate = self

    }
    
    @objc func refresh(_ sender: Any) {
        // Call webservice here after reload tableview.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.arrCustomer.removeAll()
            self.arrCustomer = self.arrCustomerOriginal
            self.searchBar.text = ""
            self.tableView.reloadData()
            self.collectView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            arrCustomer.removeAll()
            arrCustomer.append(contentsOf: arrCustomerOriginal)
        } else {
            arrCustomer = arrCustomerOriginal.filter({ (customer) -> Bool in
                let searchString = searchText.lowercased()
                let customerId = customer.originalTitle?.lowercased() ?? ""
                return customerId.contains(searchString)
            })
        }
        
        self.tableView.reloadData()
        self.collectView.reloadData()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
}

