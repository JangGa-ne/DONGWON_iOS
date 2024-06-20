//
//  P_ELEVATOR.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/22.
//

import UIKit
import Alamofire

/// E/V호출(목록)
extension VC_ELEVATOR {
    
    func GET_EVCALL(NAME: String, AC_TYPE: String) {
        
        // 데이터 삭제
        OBJ_EV.removeAll(); TABLEVIEW.reloadData()
        
        NODATA(RECT: TABLEVIEW, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/ev.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.EV_L()
                        
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_MB_ID(MB_ID: DICT?["mb_id"] as Any)
                        AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT?["home_code"] as Any)
                        AP_VALUE.SET_CALL_TO(CALL_TO: DICT?["call_to"] as Any)
                        AP_VALUE.SET_CALL_TIME(CALL_TIME: DICT?["call_time"] as Any)
                        AP_VALUE.SET_REACH_TIME(REACH_TIME: DICT?["reach_time"] as Any)
                        // 데이터 추가
                        self.OBJ_EV.append(AP_VALUE)
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_EV.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.OBJ_EV.reverse(); self.TABLEVIEW.reloadData()
        }
    }
}
