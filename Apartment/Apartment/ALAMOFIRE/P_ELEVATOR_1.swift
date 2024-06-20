//
//  P_ELEVATOR_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/22.
//

import UIKit
import Alamofire

/// E/V호출(요청)
extension VC_ELEVATOR_1 {
    
    func PUT_EVCALL(NAME: String, AC_TYPE: String) {
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "call_to": FLOOR[POSITION]
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/ev.php", method: .post, parameters: PARAMETERS).responseJSON(completionHandler: { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("KEY: \(KEY), VALUE: \(VALUE)") }; print(response)
            
            if let DICT = response.result.value as? [String: Any] {
                
                if DICT["result"] as? String ?? "fail" == "success" {
                    
                    self.S_NOTICE(":| EV \(self.FLOOR[self.POSITION])층으로 요청")
                    
                    if let BVC = UIViewController.APPDELEGATE.VC_ELEVATOR_DEL {
                        BVC.GET_EVCALL(NAME: "EV호출(목록)", AC_TYPE: "list")
                    }
                    self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
}

