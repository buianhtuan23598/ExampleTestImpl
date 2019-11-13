
import Foundation

class JsonParserManager {
    //
    static func topRate(jsonString: String) -> TopRateModel? {
        if let jsonData = jsonString.data(using: .utf8) {
            let data = try? JSONDecoder().decode(TopRateModel.self, from: jsonData)
            return data;
        }
        return nil
    }
    
    static func nowPlay(jsonString: String) -> NowPlayingModel? {
        if let jsonData = jsonString.data(using: .utf8) {
            let data = try? JSONDecoder().decode(NowPlayingModel.self, from: jsonData)
            return data;
        }
        return nil
    }
}
