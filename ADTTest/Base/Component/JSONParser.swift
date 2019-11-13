//
//  JSONParser.swift
//  Format
//
//  Created by Nguyễn Trung on 12/6/18.
//  Copyright © 2018 Nguyễn Trung. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ParseDataFromJSON: AnyObject {
    func parseData(json: JSON)
}

protocol JsonObject {
    init()
    func toDictionary() -> [String : Any]
}

extension ParseDataFromJSON {
    
    func object<T: JsonObject>(from json: JSON, key: String) -> T? where T: ParseDataFromJSON {
        guard json[key].exists() else { return nil }
        
        let object = T()
        object.parseData(json: json[key])
        return object
    }
    
    func listObjects<T: JsonObject>(from json: JSON, key: String) -> [T]? where T: ParseDataFromJSON {
        guard json[key].exists() else { return nil }
        guard let arrayJSON = json[key].array else { return nil }
        
        var listObjects: [T] = []
        
        for subJSON in arrayJSON {
            let object = T()
            object.parseData(json: subJSON)
            listObjects.append(object)
        }
        
        return listObjects
    }
    
    func processTimeString(input: String?) -> String? {
        guard input != nil else { return nil }
        let arrayStrings: [String] = input!.components(separatedBy: ".")
        guard arrayStrings.count > 0 else { return nil }
        
        if arrayStrings.count > 1 {
            return arrayStrings.first! + "Z"
        } else {
            return arrayStrings.first!
        }
    }
}
