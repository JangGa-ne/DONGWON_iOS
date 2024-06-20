//
//  P_SEARCH.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/02.
//

import UIKit
import Alamofire

/// 아파트검색(목록)
extension VC_SEARCH {
    
    func GET_SEARCH_L(NAME: String, AC_TYPE: String) {
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "app_number": "4168602768"
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/member/apt_list.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.SEARCH_L()
                        
                        AP_VALUE.SET_DON_HO_INFO(DON_HO_INFO: self.GET_SEARCH_D(ARRAY: DICT?["DongHoInfo"] as? [Any] ?? []))
                        AP_VALUE.SET_SD_CODE(SD_CODE: DICT?["sd_code"] as Any)
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                        AP_VALUE.SET_AP_NAME(AP_NAME: DICT?["ap_name"] as Any)
                        AP_VALUE.SET_APP_NUMBER(APP_NUMBER: DICT?["app_number"] as Any)
                        AP_VALUE.SET_APT_LOGO(APT_LOGO: DICT?["apt_logo"] as Any)
                        AP_VALUE.SET_K_APT_ADDR(K_APT_ADDR: DICT?["kaptAddr"] as Any)
                        AP_VALUE.SET_K_APT_LAT(K_APT_LAT: DICT?["kapt_lat"] as Any)
                        AP_VALUE.SET_K_APT_LNG(K_APT_LNG: DICT?["kapt_lng"] as Any)
                        // 데이터 추가
                        self.OBJ_SEARCH_L.append(AP_VALUE)
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_SEARCH_L.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.TABLEVIEW.reloadData()
        }
    }
      
    func GET_SEARCH_D(ARRAY: [Any]) -> [SEARCH_D] {
        
        var OBJ_SEARCH_D: [SEARCH_D] = []
        
        for (_, DATA) in ARRAY.enumerated() {
            
            let DICT = DATA as? [String: Any]
            let AP_VALUE = Apartment.SEARCH_D()
            
            AP_VALUE.SET_BUILDING_ID(BUILDING_ID: DICT?["building_id"] as Any)
            AP_VALUE.SET_HOUSE_INFO(HOUSE_INFO: DICT?["houseInfo"] as Any)
            // 데이터 추가
            OBJ_SEARCH_D.append(AP_VALUE)
        }
        
        return OBJ_SEARCH_D
    }
}
