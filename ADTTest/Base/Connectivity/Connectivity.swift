//
//  Connectivity.swift
//  PickUser
//
//  Created by eragon on 5/10/19.
//  Copyright © 2019 eragon. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
