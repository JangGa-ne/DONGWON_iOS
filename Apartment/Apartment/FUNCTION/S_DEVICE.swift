//
//  S_DEVICE.swift
//  Kkumnamu
//
//  Created by 장 제현 on 2021/12/23.
//

import UIKit

// MARK: 디바이스 비율
extension UIViewController {
    
    func DEVICE_RATIO() -> Bool {
        
        switch UIDevice.current.model {
        case "iPhone":
            if APPLE_DEVICE() == "Ratio 18:9" { return true } else { return false }
        default:
            print("\(UIDevice.current.model) 지원하지 않음"); return false
        }
    }
    
    func GET_DEVICE_IDENTIFIER() -> String {
        
        var SYSTEM_INFO = utsname()
        uname(&SYSTEM_INFO)
        let MACHINE_MIRROR = Mirror(reflecting: SYSTEM_INFO.machine)
        let IDENTIFIER = MACHINE_MIRROR.children.reduce("") { identifier, element in
            guard let VALUE = element.value as? Int8, VALUE != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(VALUE)))
        }
        
        return IDENTIFIER
    }
    
    func APPLE_DEVICE() -> String {
        
        switch GET_DEVICE_IDENTIFIER() {
        
        // MARK: iPhone
        
        case "iPhone10,3", "iPhone10,6":                return "Ratio 18:9"         // iPhone X
        case "iPhone11,2":                              return "Ratio 18:9"         // iPhone XS
        case "iPhone11,4", "iPhone11,6":                return "Ratio 18:9"         // iPhone XS Max
        case "iPhone11,8":                              return "Ratio 18:9"         // iPhone XR
        case "iPhone12,1":                              return "Ratio 18:9"         // iPhone 11
        case "iPhone12,3":                              return "Ratio 18:9"         // iPhone 11 Pro
        case "iPhone12,5":                              return "Ratio 18:9"         // iPhone 11 Pro Max
        
        case "iPhone12,8":                              return "Ratio 16:9"         // iPhone SE (2G)
        
        case "iPhone13,1":                              return "Ratio 18:9"         // iPhone 12 Mini
        case "iPhone13,2":                              return "Ratio 18:9"         // iPhone 12
        case "iPhone13,3":                              return "Ratio 18:9"         // iPhone 12 Pro
        case "iPhone13,4":                              return "Ratio 18:9"         // iPhone 12 Pro Max
            
        case "iPhone14,4":                              return "Ratio 18:9"         // iPhone 13 Mini
        case "iPhone14,5":                              return "Ratio 18:9"         // iPhone 13
        case "iPhone14,2":                              return "Ratio 18:9"         // iPhone 13 Pro
        case "iPhone14,3":                              return "Ratio 18:9"         // iPhone 13 Pro Max
            
        default: return "Ratio 16:9" }
    }
}
