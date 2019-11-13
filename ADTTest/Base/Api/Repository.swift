
import Foundation
import SwiftyJSON
import RxSwift

class Repository: BaseRepository {
    func adtDisplay(page: Int, callBack: @escaping (ApiResponse<BaseResponse>) -> ()) -> () {
        let url = "\(URLConst.NOW_PLAYING_URL)"
        var params = Dictionary<String, Any>.init()
        params["page"] = page
        return self.callGetMethod(url: url, parameters: params, onComplete: callBack)
    }
    
    func topRate(page: Int, callBack: @escaping (ApiResponse<BaseResponse>) -> ()) -> () {
        let url = "\(URLConst.TOP_RATE_URL)"
        var params = Dictionary<String, Any>.init()
        params["page"] = page
        return self.callGetMethod(url: url, parameters: params, onComplete: callBack)
    }
}
