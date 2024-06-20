//
//  P_EVCAR.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/28.
//

import UIKit
import Alamofire

extension VC_EVCAR {
    
    func GET_EVCAR_L(NAME: String, AC_TYPE: String) {
        
        // 데이터 삭제
        OBJ_EVCAR.removeAll(); UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/charger.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.EVCAR_L()
                        
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                        AP_VALUE.SET_CHARGER_END(CHARGER_END: DICT?["charger_end"] as Any)
                        AP_VALUE.SET_CHARGER_ID(CHARGER_ID: DICT?["charger_id"] as Any)
                        AP_VALUE.SET_CHARGER_NAME(CHARGER_NAME: DICT?["charger_name"] as Any)
                        AP_VALUE.SET_CHARGER_START(CHARGER_START: DICT?["charger_start"] as Any)
                        AP_VALUE.SET_CHARGER_STATUS(CHARGER_STATUS: DICT?["charger_status"] as Any)
                        AP_VALUE.SET_CHARGER_TYPE(CHARGER_TYPE: DICT?["charger_type"] as Any)
                        AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT?["home_code"] as Any)
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_PLATE_INFO(PLATE_INFO: DICT?["plate_info"] as Any)
                        // 데이터 추가
                        self.OBJ_EVCAR.append(AP_VALUE)
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_EVCAR.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
        }
    }
}
