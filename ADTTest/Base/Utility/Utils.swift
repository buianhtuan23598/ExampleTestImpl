//
//  Utils.swift
//  Format
//
//  Created by Nguyễn Trung on 11/28/18.
//  Copyright © 2018 Nguyễn Trung. All rights reserved.
//

import Foundation
import Kingfisher
import CommonCrypto

class Utils: NSObject {
    
    static let shared = Utils()
    
    func formatPercent(value: Double,isManual: Bool = false,maximumFractionDigits : Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        if isManual
        {
            formatter.maximumFractionDigits = maximumFractionDigits
        }
        else
        {
            if -1.0 < value && value < 1.0 {
                formatter.maximumFractionDigits = 8
            }
            else
            {
                formatter.maximumFractionDigits = 2
            }
        }
        let result = formatter.string(from: (value/100.0) as NSNumber)
        return result!
    }
    
    func formatValue(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if -1.0 < value && value < 1.0 {
            formatter.maximumFractionDigits = 8
            var result = formatter.string(from: value as NSNumber)
            if let range = result?.range(of: ".") {
                result?.replaceSubrange(range, with: "0.")
            }
            if let range = result?.range(of: "00.") {
                result?.replaceSubrange(range, with: "0.")
            }
            return result!
        }
        else
        {
            formatter.maximumFractionDigits = 2
            if (value > 1000000.0 && value < 1000000000.0) || (value < -1000000.0 && value > -1000000000.0) {
                let newValue = value/1000000.0
                if let result = formatter.string(from: newValue as NSNumber)
                {
                    return result + "MM"
                }
            }
            if value > 1000000000.0 || value < -1000000000.0 {
                let newValue = value/1000000000.0
                if let result = formatter.string(from: newValue as NSNumber)
                {
                    return result + "B"
                }
            }
            
        }
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    func formatValue(maximumFractionDigits : Int,value : Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ""
        formatter.maximumFractionDigits = maximumFractionDigits
        if -1.0 < value && value < 1.0 {
            var result = formatter.string(from: value as NSNumber)
            if let range = result?.range(of: ".") {
                result?.replaceSubrange(range, with: "0.")
            }
            if let range = result?.range(of: "00.") {
                result?.replaceSubrange(range, with: "0.")
            }
            return result!
        }
        
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    func formatValue2(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 3
        if -1.0 < value && value < 1.0 {
            formatter.maximumFractionDigits = 8
            var result = formatter.string(from: value as NSNumber)
            if let range = result?.range(of: ".") {
                result?.replaceSubrange(range, with: "0.")
            }
            if let range = result?.range(of: "00.") {
                result?.replaceSubrange(range, with: "0.")
            }
            return result!
        }
        else
        {
            formatter.maximumFractionDigits = 4
            if (value > 1000000.0 && value < 1000000000.0) || (value < -1000000.0 && value > -1000000000.0) {
                let newValue = value/1000000.0
                if let result = formatter.string(from: newValue as NSNumber)
                {
                    return result + "MM"
                }
            }
            if value > 1000000000.0 || value < -1000000000.0 {
                let newValue = value/1000000000.0
                if let result = formatter.string(from: newValue as NSNumber)
                {
                    return result + "B"
                }
            }
            
        }
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    func convertTimeStringToDouble(tString : String) -> Double {
        let dateFormatter = DateFormatter()
        //        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssz"
        let date = dateFormatter.date(from: tString)!
        let timeStamp = date.timeIntervalSince1970
        return Double(timeStamp)
    }
    func convertTimeStringToDouble(tString : String,format : String) -> String {
        var nFormat = "yyyy/MM/dd HH:mm:ss"
        if tString.contains(".")
        {
            nFormat = "yyyy/MM/dd HH:mm:ss.z"
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        if nFormat == format
        {
            dateFormatter.dateFormat = format
        }
        else
        {
            dateFormatter.dateFormat = nFormat
        }
        let date = dateFormatter.date(from: tString)!
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = tempLocale
        dateFormatter.dateFormat = "HH:mm - dd/MM"
        let date21 = dateFormatter.string(from: date)
        return date21
    }
    
    func convertTimeString(tString : String,format : String) -> String {
        var nFormat = "yyyy/MM/dd HH:mm:ss"
        if tString.contains(".")
        {
            nFormat = "yyyy/MM/dd HH:mm:ss.z"
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        if nFormat == format
        {
            dateFormatter.dateFormat = format
        }
        else
        {
            dateFormatter.dateFormat = nFormat
        }
        let date = dateFormatter.date(from: tString)!
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = tempLocale
        dateFormatter.dateFormat = "dd 'thg' MM"
        let date21 = dateFormatter.string(from: date)
        return date21
    }
    
    func convertTime(tString : String,format : String) -> String {
        var nFormat = "yyyy/MM/dd HH:mm:ss"
        if tString.contains(".")
        {
            nFormat = "yyyy/MM/dd HH:mm:ss.z"
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        if nFormat == format
        {
            dateFormatter.dateFormat = format
        }
        else
        {
            dateFormatter.dateFormat = nFormat
        }
        let date = dateFormatter.date(from: tString)!
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = tempLocale
        dateFormatter.dateFormat = "HH:mm - dd/MM"
        let date21 = dateFormatter.string(from: date)
        return date21
    }
    
    func convertTimetoDateYear(tString : String,format : String) -> String {
        var nFormat = "yyyy/MM/dd HH:mm:ss"
        if tString.contains(".")
        {
            nFormat = "yyyy/MM/dd HH:mm:ss.z"
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        if nFormat == format
        {
            dateFormatter.dateFormat = format
        }
        else
        {
            dateFormatter.dateFormat = nFormat
        }
        let date = dateFormatter.date(from: tString)!
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = tempLocale
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let date21 = dateFormatter.string(from: date)
        return date21
    }
    
    func convertTimetoHour(tString : String,format : String) -> String {
        var nFormat = "yyyy/MM/dd HH:mm:ss"
        if tString.contains(".")
        {
            nFormat = "yyyy/MM/dd HH:mm:ss.z"
        }
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        if nFormat == format
        {
            dateFormatter.dateFormat = format
        }
        else
        {
            dateFormatter.dateFormat = nFormat
        }
        let date = dateFormatter.date(from: tString)!
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = tempLocale
        dateFormatter.dateFormat = "HH:mm"
        let date21 = dateFormatter.string(from: date)
        return date21
    }
    
    func UTCToLocal(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        
        return dateFormatter.string(from: dt!)
    }
    
    func formatCurrency(currencyString : String) -> String {
        if let value = Int(currencyString)
        {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = "."
            formatter.maximumFractionDigits = 0
            if let result = formatter.string(from: value as NSNumber)
            {
                return result
            }
        }
        return ""
    }
    
    func getCachedImage(urlString : String) -> UIImage? {
        let cacheResult = KingfisherManager.shared.cache.imageCachedType(forKey: urlString)
        var image : UIImage?
        switch cacheResult {
        case .memory:
            image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: urlString)
            break
        case .disk:
            image = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: urlString)
            break
        case .none:
            image = nil
        }
        return image
    }
    
    //    func md5(_ string: String) -> String {
    //
    //        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
    //        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
    //        CC_MD5_Init(context)
    //        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
    //        CC_MD5_Final(&digest, context)
    //        context.deallocate(capacity: 1)
    //        var hexString = ""
    //        for byte in digest {
    //            hexString += String(format:"%02x", byte)
    //        }
    //
    //        return hexString
    //    }
    
    func isValidEmail(email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return predicate.evaluate(with: email)
    }
}
