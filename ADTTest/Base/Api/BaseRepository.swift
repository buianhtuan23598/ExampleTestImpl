import Foundation
import Alamofire
import SwiftyJSON
import RxSwift

class BaseRepository {
    let ERROR_NETWORK_MESSAGE = "Có lỗi xảy ra trong quá trình kết nối đến máy chủ."
    let ERROR_DATA_MESSAGE = "Có lỗi trong quá trình xử lý dữ liệu."
    
    func callPostMethod<T>(url: String, parameters: Dictionary<String, Any>, onComplete: @escaping (ApiResponse<T>) -> ()) {
        callApi(url: url, method: "POST", parameters: parameters, onComplete: onComplete)
    }
    
    func callGetMethod<T>(url: String, parameters: Dictionary<String, Any>, onComplete: @escaping (ApiResponse<T>) -> ()) {
        callApi(url: url, method: "GET", parameters: parameters, onComplete: onComplete)
    }
    
    
    func callGetMethod<T>(url: String, onComplete: @escaping (ApiResponse<T>) -> ()) {
        return callApi(url: url, method: "GET", parameters: [String: Any](), onComplete: onComplete)
    }
    
    func callGetMethod<T>(url: String) -> Observable<ApiResponse<T>> {
        return callApi(url: url, method: "GET", parameters: [String: Any]())
    }
    
    func callPostMethod<T>(url: String, parameters: Dictionary<String, Any>) -> Observable<ApiResponse<T>> {
        return callApi(url: url, method: "POST", parameters: parameters)
    }
    
    func callGetMethod<T>(url: String, parameters: Dictionary<String, Any>) -> Observable<ApiResponse<T>> {
        return callApi(url: url, method: "GET", parameters: parameters)
    }
    
    func callApi<T>(url: String, method: String, parameters: Dictionary<String, Any>, onComplete: @escaping (ApiResponse<T>) -> ()) {
        self.callApiCore(onComplete: onComplete, emitter: nil, url: url, method: method, parameters: parameters)
    }
    
    func callApi<T>(url: String, method: String, parameters: Dictionary<String, Any>) -> Observable<ApiResponse<T>> {
        return Observable<ApiResponse<T>>.create { (emitter) -> Disposable in
            self.callApiCore(onComplete: nil, emitter: emitter, url: url, method: method, parameters: parameters)
            return Disposables.create()
        }
    }
    
    func callApiCore<T>(onComplete: ((ApiResponse<T>) -> ())?, emitter: (AnyObserver<ApiResponse<T>>)?, url: String, method: String, parameters: Dictionary<String, Any>) {
        var httpMethod: HTTPMethod = .get
        
        if (method == "GET") {
            httpMethod = .get
        } else if (method == "POST") {
            httpMethod = .post
        }
        
        var header: HTTPHeaders?
        let authorization = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MzYsImlzQWN0aXZlIjp0cnVlfQ.Pgq2WTdzdUGEo9Cys4qUsmfniowPU8akbCgiDSePy-Y"
        header = ["Authorization" : authorization]
        
        Alamofire.request(url, method: httpMethod, parameters: parameters, headers: header).responseJSON(completionHandler: {response in
            switch response.result {
            case .success(let data):
                guard let jsonData = JSON(data).dictionary else {
                    emitter?.onNext(ApiResponse(errorMessage: self.ERROR_NETWORK_MESSAGE))
                    onComplete?(ApiResponse(errorMessage: self.ERROR_NETWORK_MESSAGE))
                    
                    return;
                }
                
                
                let resultStatus: Int = jsonData["status"]?.int ?? ApiConst.STATUS_SUCCESS
                if (resultStatus == ApiConst.STATUS_SUCCESS) {
                    let rawData: String = JSON(data).rawString()!
                    
                    let apiResponse: ApiResponse<T> = ApiResponse(rawData: rawData)
                    apiResponse.message = jsonData["message"]?.string ?? ""
                    
                    emitter?.onNext(apiResponse)
                    onComplete?(apiResponse)
                } else {
                    emitter?.onNext(ApiResponse(errorMessage: jsonData["message"]?.string ?? ""))
                    onComplete?(ApiResponse(errorMessage: jsonData["message"]?.string ?? ""))
                }
                
                break
            case .failure(let error):
                print(error.localizedDescription)
                emitter?.onNext(ApiResponse(errorMessage: self.ERROR_NETWORK_MESSAGE))
                onComplete?(ApiResponse(errorMessage: self.ERROR_NETWORK_MESSAGE))
            }
            
        })
    }
    
    
    
    
    
    
    
    //    func callPostMethodWithCallBack<T>(url: String, parameters: Dictionary<String, Any>, onComplete: @escaping (ApiResponse<T>) -> ()) {
    //        Alamofire.request(url, method: .post, parameters: parameters).responseJSON(completionHandler: {response in
    //
    //            switch response.result {
    //            case .success(let data):
    //                //print(type(of: data))
    //                guard let jsonData = JSON(data).dictionary else {
    //                    onComplete(ApiResponse(errorMessage: self.ERROR_NETWORK_MESSAGE))
    //                    return;
    //                }
    //
    //                if let errorMessage = jsonData["_ERROR_MESSAGE_"]?.string {
    //                    onComplete(ApiResponse(errorMessage: errorMessage))
    //                    return;
    //                }
    //
    //                let rawData: String = JSON(data).rawString()!
    //                onComplete(ApiResponse(rawData: rawData))
    //
    //                break
    //            case .failure(let error):
    //                print(error.localizedDescription)
    //                onComplete(ApiResponse(errorMessage: self.ERROR_NETWORK_MESSAGE))
    //            }
    //
    //        });
    //    }
}
