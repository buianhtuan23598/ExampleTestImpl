

import Foundation
import UIKit

extension ShowMoreVC {
    
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
        let vc = Screen2VC.init(nibName: "Screen2VC", bundle: nil)
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

extension ShowMoreVC: UICollectionViewDelegateFlowLayout
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
