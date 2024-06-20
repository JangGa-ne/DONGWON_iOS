//
//  S_NETWORK.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/28.
//

import UIKit
import SystemConfiguration

// MARK: 네트워크 연결 확인
extension UIViewController {
    
    func S_NETWORK() -> Bool {
        
        var ZERO_ADDRESS = sockaddr_in()
        ZERO_ADDRESS.sin_len = UInt8(MemoryLayout.size(ofValue: ZERO_ADDRESS))
        ZERO_ADDRESS.sin_family = sa_family_t(AF_INET)
        
        let DEFAULT_ROUTE_REACHABILITY = withUnsafePointer(to: &ZERO_ADDRESS, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1, { zero_Sock_Address in
                SCNetworkReachabilityCreateWithAddress(nil, zero_Sock_Address)
            })
        })
        
        var FLAGS = SCNetworkReachabilityFlags()
        
        if !SCNetworkReachabilityGetFlags(DEFAULT_ROUTE_REACHABILITY!, &FLAGS) { return false }
        
        let IS_REACHABLE = FLAGS.contains(.reachable)
        let NEEDS_CONNECTION = FLAGS.contains(.connectionRequired)
        
        return IS_REACHABLE && !NEEDS_CONNECTION
    }
}
