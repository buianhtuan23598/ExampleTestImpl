
import UIKit

class MainTabbar: UITabBarController {

    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view

        }

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let number = CGFloat((tabBar.items?.count)!)
            let tabBarSize = CGSize(width: tabBar.frame.width/number, height: tabBar.frame.height)
            tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: UIColor.white, size: tabBarSize)
            tabBar.tintColor = UIColor.init(hexStr: "454545")
            tabBar.unselectedItemTintColor = UIColor.white
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "Hiragino Sans", size: 12)!], for: .selected)
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font: UIFont(name: "Hiragino Sans", size: 12)!], for: .normal)
        }
        
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        }
    }

    extension UIImage {
        class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
            let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            color.setFill()
            UIRectFill(rect)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return image
        }
    }

