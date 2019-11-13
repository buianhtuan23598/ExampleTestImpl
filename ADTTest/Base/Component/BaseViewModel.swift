
import Foundation
import RxSwift

class BaseViewModel {
//    var userDataManager = UserDataManager()
    
    func parseData<T: Codable>(eventResponse: Event<ApiResponse<T>>, callBack: @escaping (
        (data: T?, isSuccess: Bool, message: String)
        ) -> ()) {
        let apiResponse: ApiResponse = eventResponse.element!
        
        print(apiResponse.status)
        
        if (apiResponse.isSuccess()) {
            let jsonString = apiResponse.rawData
            
            if let jsonData = jsonString?.data(using: .utf8) {
                let data = try? JSONDecoder().decode(T.self, from: jsonData)
                apiResponse.data = data
            }
        }
        callBack((apiResponse.data, apiResponse.isSuccess(), apiResponse.message))
    }
    
    func parseData<T: Codable>(eventResponse: Event<ApiResponse<T>>) -> ApiResponse<T> {
        let apiResponse: ApiResponse = eventResponse.element!
        
        print("\(apiResponse.status)")
        
        if (apiResponse.isSuccess()) {
            let jsonString = apiResponse.rawData
            
            if let jsonData = jsonString?.data(using: .utf8) {
                let data = try? JSONDecoder().decode(T.self, from: jsonData)
                apiResponse.data = data
            }
        }
        return apiResponse
    }
}
