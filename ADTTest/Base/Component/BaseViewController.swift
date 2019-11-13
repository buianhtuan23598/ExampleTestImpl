

import UIKit
//import MBProgressHUD

class BaseViewController: UIViewController, ViewContainsLoadingViewProtocol, ViewContainsFormatLoadingViewProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set status bar background color by add container view
        addContainerViewWithBackgroundColor(hexColor: AppVariable.arrColor["@colorStatusBar"]!)
        
        // Setup back button
        setupBackButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getMenuButton() -> UIButton? {
        return nil
    }
    
    func getBackButton() -> UIButton? {
        return nil
    }
    
    func setupBackButton() {
        getBackButton()?.addTarget(self, action: #selector(self.buttonBackOnClick(_:)), for: .touchUpInside)
    }
    
    @objc func buttonBackOnClick(_ sender: AnyObject?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Set status bar background color by add container view
    func addContainerViewWithBackgroundColor(hexColor: String) {
        let layer = CALayer()
        layer.frame = self.view.bounds
        layer.zPosition = -1
        layer.backgroundColor = UIColor(hexStr: hexColor).cgColor
        self.view.layer.addSublayer(layer)
    }
    
    // UIAlertController Helper ========================================================================================
    
    
    func showCustomAlertTextView(modalStyle: UIModalPresentationStyle = UIModalPresentationStyle.overCurrentContext,title: String? = nil, message: String? = nil, buttonOkOnClick: ((_ star: Int) -> ())?) {
        let alertController = AlertViewController.getStartViewController()
        alertController.modalPresentationStyle = modalStyle
    
        alertController.buttonOkOnClick = buttonOkOnClick
        alertController.typeAlertViewController = .textField
        alertController.titleText = title
        alertController.messageText = message
        
        self.present(alertController, animated: false, completion: nil)
    }
  
    func showCustomAlert(modalStyle: UIModalPresentationStyle = UIModalPresentationStyle.overCurrentContext, title: String? = nil, message: String? = nil, okTitle: String? = nil, cancelTitle: String, buttonOkOnClick:(() -> ())?, buttonCancelOnClick:(() -> ())?) {
        let controller = AlertConfirmViewController.getStartViewController()
        controller.modalPresentationStyle = modalStyle
        
        controller.titleText = title
        controller.message = message
        controller.okTitle = okTitle
        controller.cancelTitle = cancelTitle
        controller.buttonOkOnClick = buttonOkOnClick
        controller.buttonCancelOnClick = buttonCancelOnClick
    
        self.present(controller, animated: false, completion: nil)
        
    }
    
    
    
    // Show message alert with message only
    func showAlertMessage(message: String) {
        showAlertMessage(title: "", message: message)
    }
    
    // Show message alert with title, message
    func showAlertMessage(title: String, message: String) {
        showAlertMessage(title: title, message: message, okText: "OK".localized, callBack: {() in })
    }
    
    // Show message alert with message, complete
    func showAlertMessage(message: String, callback: @escaping() -> ()) {
        showAlertMessage(title: "", message: message, callback: callback)
    }
    
    // Show message alert with title, message, complete
    func showAlertMessage(title: String, message: String, callback: @escaping() -> ()) {
        showAlertMessage(title: title, message: message, okText: "OK".localized, callBack: callback)
    }
    
    // Show confirm message with message
    func showConfirmMessage(message: String, callBack: @escaping () -> ()) {
        showConfirmMessage(title: "", message: message, callBack: callBack)
    }
    
    // Show confirm message with title, message
    func showConfirmMessage(title: String, message: String, callBack: @escaping () -> ()) {
        showConfirmMessage(title: title, message: message, okText: "OK".localized, cancelText: "Cancel".localized, callBack: callBack)
    }
    
    // Show alert
    func showAlertMessage(title: String, message: String, okText: String, callBack: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okText, style: UIAlertAction.Style.default, handler: { action in
            alert.dismiss(animated: false, completion: nil)
            callBack()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Show confirm message
    func showConfirmMessage(title: String, message: String, okText: String, cancelText:String, callBack: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okText, style: UIAlertAction.Style.default, handler: { action in
            callBack()
        }))
        alert.addAction(UIAlertAction(title: cancelText, style: UIAlertAction.Style.cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showConfirmMessage(title: String, message: String, okText: String, cancelText:String, callBackOK: @escaping () -> (), callBackCancel: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okText, style: UIAlertAction.Style.default, handler: { action in
            callBackOK()
        }))
        alert.addAction(UIAlertAction(title: cancelText, style: UIAlertAction.Style.cancel, handler: { action in
            callBackCancel()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Change screen ===================================================================================================
    // Change screen with animation
    func goToScreen(controller: UIViewController) {
        goToScreen(controller: controller, animated: true)
    }
    
    // Change screen
    func goToScreen(controller: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }
    
    // Progress bar ===================================================================================================
    
    var formatLoadingView : FormatLoadingView?
    
    func showFormatLoadingView(_ show: Bool) {
        self.showFormatLoadingView(in: self.view, show: show)
    }
    
    func showFormatLoading() {
        self.showFormatLoadingView(true)
    }
    
    func hideFormatLoading() {
        self.showFormatLoadingView(false)
    }
    // Progress bar ===================================================================================================
    func showLoadingView(_ show: Bool) {
        self.showLoadingView(in: self.view, show: show)
    }
    
    func showLoading() {
        self.showLoadingView(true)
    }
    
    func hideLoading() {
        self.showLoadingView(false)
    }
    
    var loadingView: LoadingView?
    
    // Enable / Disable touch event ===================================================================================================
    func enableTouchEvent() {
        self.view.isUserInteractionEnabled = true
    }
    
    func disableTouchEvent() {
        self.view.isUserInteractionEnabled = false
    }
    
    func showAlert(title: String? = nil, message: String) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        self.present(alert, animated: true, completion: nil)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
//            alert.dismiss(animated: true, completion: nil)
//        }
        
        guard let title = title else {
            self.showAlertMessage(message: message)
            return
        }
        self.showAlertMessage(title: title, message: message)
    }
    
}
