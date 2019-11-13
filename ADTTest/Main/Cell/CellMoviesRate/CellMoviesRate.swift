
import UIKit

class CellMoviesRate: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    var model: [TopRateModel.Result] = [TopRateModel.Result]()
        @IBOutlet weak var collectionView: UICollectionView!
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 2.0
            layout.minimumInteritemSpacing = 2.0
            collectionView.setCollectionViewLayout(layout, animated: false)
            collectionView.register(UINib.init(nibName: "CellCollectionMovies", bundle: nil), forCellWithReuseIdentifier: "CellCollectionMovies")
            self.collectionView.reloadData()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        
    }

    extension CellMoviesRate {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.model.count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            return layoutStatus(indexPath: indexPath)
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        }
        func layoutStatus(indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollectionMovies", for: indexPath) as! CellCollectionMovies
            let url = self.model[indexPath.row].posterPath ?? ""
            let urlImg = "https://image.tmdb.org/t/p/w500/\(url)"
            cell.configCell(url: urlImg)
            cell.lblMoviesName.text = self.model[indexPath.row].originalTitle ?? ""
            return cell
        }
    }

    extension CellMoviesRate: UICollectionViewDelegateFlowLayout
    {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            if section == 0 {
                return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
            } else if section == 1 {
                return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
            }
            return UIEdgeInsets()
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let lay = collectionViewLayout as! UICollectionViewFlowLayout
            let widthPerItem = collectionView.frame.size.width/3 - lay.minimumInteritemSpacing - lay.sectionInset.left - lay.sectionInset.right
            return CGSize(width:widthPerItem, height: 250)
        }
    }

