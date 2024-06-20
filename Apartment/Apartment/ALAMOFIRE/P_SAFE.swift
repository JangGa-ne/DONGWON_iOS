//
//  P_SAFE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/22.
//

import UIKit
import Alamofire

extension VC_SAFE {
    
    func GET_FAMILY_L(NAME: String, AC_TYPE: String) {
        
        // 데이터 삭제
        OBJ_FAMILY.removeAll(); TABLEVIEW.reloadData()
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/member/family.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.FAMILY()
                        
                        AP_VALUE.SET_BK_HP(BK_HP: DICT?["bk_hp"] as Any)
                        AP_VALUE.SET_BK_NAME(BK_NAME: DICT?["bk_name"] as Any)
                        AP_VALUE.SET_BK_NICK(BK_NICK: DICT?["bk_nick"] as Any)
                        AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT?["home_code"] as Any)
                        AP_VALUE.SET_MB_PHOTO(MB_PHOTO: DICT?["mb_photo"] as Any)
                        AP_VALUE.SET_MB_TYPE(MB_TYPE: DICT?["mb_type"] as Any)
                        // 데이터 추가
                        self.OBJ_FAMILY.append(AP_VALUE)
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_FAMILY.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.TABLEVIEW.reloadData()
        }
    }
}
