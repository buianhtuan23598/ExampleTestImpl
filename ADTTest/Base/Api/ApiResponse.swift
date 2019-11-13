

import UIKit
import Alamofire
import SwiftyJSON

class ApiResponse<T>: NSObject {
    let STATUS_SUCCESS = ApiConst.STATUS_SUCCESS
    let STATUS_ERROR = ApiConst.STATUS_ERROR
    
    var status: Int = 0
    var message: String = ""
    var data: T?
    var rawData: String?
    
    override init() {
        
    }
    
    init(errorMessage: String) {
        self.status = STATUS_ERROR
        self.message = errorMessage
    }
    
    init(data: T) {
        self.status = STATUS_SUCCESS
        self.data = data
    }
    
    init(rawData: String?) {
        self.status = STATUS_SUCCESS
        self.rawData = rawData
    }
    
    func isSuccess() -> Bool {
        return self.status == STATUS_SUCCESS
    }
    
    func isError() -> Bool {
        return !isSuccess()
    }
}
