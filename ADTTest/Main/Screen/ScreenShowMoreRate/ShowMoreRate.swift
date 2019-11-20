
import UIKit

class ShowMoreRate: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var lblList: UILabel!
    var arrCustomerOriginal: [TopRateModel.Result] = [TopRateModel.Result]()
    var arrCustomer: [TopRateModel.Result] = [TopRateModel.Result]()
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

extension ShowMoreRate: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(arrCustomer.count)
        return self.arrCustomer.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "CellImageMovies")
        var cell:CellImageMovies!
        if (cellTable == nil) {
            cell = Bundle.main.loadNibNamed("CellImageMovies", owner: self, options: nil)?.first as? CellImageMovies
        } else {
            cell = cellTable as? CellImageMovies
        }
        let url = self.arrCustomer[indexPath.row].posterPath ?? ""
        let urlImg = "https://image.tmdb.org/t/p/w500/\(url)"
        cell.configCell(url: urlImg)
        cell.lblname.text = "Tên Phim: \(self.arrCustomer[indexPath.row].originalTitle ?? "")"
        cell.lblDate.text = "Ngày chiếu: \(self.arrCustomer[indexPath.row].releaseDate ?? "")"
        cell.lblTitle.text = "Tổng quan: \(self.arrCustomer[indexPath.row].overview ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ScreenDetailRate.init(nibName: "ScreenDetailRate", bundle: nil)
        vc.model = self.arrCustomer[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.arrCustomer.count - 1
        if !loadingData && lastElement != 0 && indexPath.row == lastElement {
            self.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.hideLoading()
                self.arrCustomer = self.arrCustomer + self.arrCustomer
                self.tableView.reloadData()
                self.collectView.reloadData()
            }
        }
    }
}

extension ShowMoreRate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrCustomer.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return layoutStatus(indexPath: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ScreenDetailRate.init(nibName: "ScreenDetailRate", bundle: nil)
        vc.model = self.arrCustomer[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func layoutStatus(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "CellCollectionMovies", for: indexPath) as! CellCollectionMovies
        let url = self.arrCustomer[indexPath.row].posterPath ?? ""
        let urlImg = "https://image.tmdb.org/t/p/w500/\(url)"
        cell.configCell(url: urlImg)
        cell.lblMoviesName.text = self.arrCustomer[indexPath.row].originalTitle ?? ""
        return cell
    }
}

extension ShowMoreRate: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.size.width/3 - lay.minimumInteritemSpacing - lay.sectionInset.left - lay.sectionInset.right
        return CGSize(width:widthPerItem, height: 250)
    }
}
