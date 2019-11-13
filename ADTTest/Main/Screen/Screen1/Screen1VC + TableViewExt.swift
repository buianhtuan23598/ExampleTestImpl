

import Foundation
import UIKit

extension Screen1VC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 220
        case 1, 3, 5:
            return 44
        case 2, 4, 6:
            return 260
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1, 3, 5:
            return 1
        case 2, 4, 6:
            return 1
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return layoutCellImage(indexPath: indexPath)
        case 1:
            return layoutCellTitle(indexPath: indexPath)
        case 2:
            return layoutCellMovies(indexPath: indexPath)
        case 3:
            return layoutCellTitle1(indexPath: indexPath)
        case 4:
            return layoutCellMovies1(indexPath: indexPath)
        case 5:
            return layoutCellTitle2(indexPath: indexPath)
        case 6:
            return layoutCellMovies2(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = Screen2VC.init(nibName: "Screen2VC", bundle: nil)
//        vc.model = self.listData?.homes?[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func layoutCellImage(indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "CellImage")
        var cell:CellImage!
        if (cellTable == nil) {
            cell = Bundle.main.loadNibNamed("CellImage", owner: self, options: nil)?.first as? CellImage
        } else {
            cell = cellTable as? CellImage
        }
        cell.model = self.listData?.results ?? [Result]()
        return cell
    }
    func layoutCellTitle(indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "CellLabel")
        var cell:CellLabel!
        if (cellTable == nil) {
            cell = Bundle.main.loadNibNamed("CellLabel", owner: self, options: nil)?.first as? CellLabel
        } else {
            cell = cellTable as? CellLabel
        }
        cell.lblConten.text = "Phim hay trong tháng"
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    func layoutCellTitle1(indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "CellLabel")
        var cell:CellLabel!
        if (cellTable == nil) {
            cell = Bundle.main.loadNibNamed("CellLabel", owner: self, options: nil)?.first as? CellLabel
        } else {
            cell = cellTable as? CellLabel
        }
        cell.lblConten.text = "Phim xem nhiều"
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    func layoutCellTitle2(indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "CellLabel")
        var cell:CellLabel!
        if (cellTable == nil) {
            cell = Bundle.main.loadNibNamed("CellLabel", owner: self, options: nil)?.first as? CellLabel
        } else {
            cell = cellTable as? CellLabel
        }
        cell.lblConten.text = "Phim mới"
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    func layoutCellMovies(indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "CellMovies")
        var cell:CellMovies!
        if (cellTable == nil) {
            cell = Bundle.main.loadNibNamed("CellMovies", owner: self, options: nil)?.first as? CellMovies
        } else {
            cell = cellTable as? CellMovies
        }
        cell.model = self.listData?.results ?? [Result]()
        return cell
    }
    func layoutCellMovies1(indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "CellMovies")
        var cell:CellMovies!
        if (cellTable == nil) {
            cell = Bundle.main.loadNibNamed("CellMovies", owner: self, options: nil)?.first as? CellMovies
        } else {
            cell = cellTable as? CellMovies
        }
        cell.model = self.listDataTop?.results ?? [Result]()
        return cell
    }
    func layoutCellMovies2(indexPath: IndexPath) -> UITableViewCell {
        let cellTable = tableView.dequeueReusableCell(withIdentifier: "CellMovies")
        var cell:CellMovies!
        if (cellTable == nil) {
            cell = Bundle.main.loadNibNamed("CellMovies", owner: self, options: nil)?.first as? CellMovies
        } else {
            cell = cellTable as? CellMovies
        }
        cell.model = self.listDataTrend?.results ?? [Result]()
        return cell
    }
}
