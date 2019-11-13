
import Foundation
import RxSwift

class JsonUtility {
    
    static func parseJsonToCodableObject<T: Codable>(jsonString: String?) -> T? {
        if let jsonData = jsonString?.data(using: .utf8) {
            do {
                let data = try JSONDecoder().decode(T.self, from: jsonData)
                return data
            } catch let error {
                print(error)
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func parseData<T: Codable>(eventResponse: Event<ApiResponse<T>>) -> ApiResponse<T> {
        let apiResponse: ApiResponse = eventResponse.element!
        
        if (apiResponse.isSuccess()) {
            let jsonString = apiResponse.rawData
            let data: T? = self.parseJsonToCodableObject(jsonString: jsonString)
            apiResponse.data = data
        }
        return apiResponse
    }
}
