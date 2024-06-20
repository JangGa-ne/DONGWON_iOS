//
//  P_LOCATE.swift
//  Apartment
//
//  Created by 부산광역시교육청 on 2022/07/02.
//

import UIKit
import Alamofire

extension VC_LOCATE {
    
    func GET_LOCATE(NAME: String, AC_TYPE: String) {
        
        // 데이터 삭제
        OBJ_LOCATE.removeAll(); MAPVIEW.removeAnnotations(MAPVIEW.annotations)
        COORDINATE.removeAll(); MAPVIEW.removeOverlays(MAPVIEW.overlays)
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        var P_URL2: String = ""
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "req_id": OBJ_FAMILY[POSITION].BK_HP,
            "req_name": OBJ_FAMILY[POSITION].BK_NAME
        ]
        
        if NAME == "최근위치(목록)" {
            P_URL2 = "/location/get_location.php"
        } else if NAME == "이동경로(목록)" {
            P_URL2 = "/location/get_history.php"
        }
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+P_URL2, method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.LOCATE()
                        
                        AP_VALUE.SET_ACCURACY(ACCURACY: DICT?["accuracy"] as Any)
                        AP_VALUE.SET_BK_NAME(BK_NAME: DICT?["bk_name"] as Any)
                        AP_VALUE.SET_BK_NICK(BK_NICK: DICT?["bk_nick"] as Any)
                        AP_VALUE.SET_LAT(LAT: DICT?["lat"] as Any)
                        AP_VALUE.SET_LNG(LNG: DICT?["lng"] as Any)
                        AP_VALUE.SET_MB_ID(MB_ID: DICT?["mb_id"] as Any)
                        AP_VALUE.SET_REG_DATE(REG_DATE: DICT?["reg_date"] as Any)
                        AP_VALUE.SET_RESULT(RESULT: DICT?["result"] as Any)
                        // 데이터 추가
                        self.OBJ_LOCATE.append(AP_VALUE)
                    }
                    
                    self.SETUP()
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                
                self.S_ERROR(response.result.error as? AFError)
            }
        }
    }
}
