
import Foundation
import UIKit

extension ShowMoreVC: UITableViewDelegate, UITableViewDataSource {
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
        let vc = Screen2VC.init(nibName: "Screen2VC", bundle: nil)
        vc.model = self.arrCustomer[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = self.arrCustomer.count - 1
        if !loadingData && indexPath.row == lastElement {
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
