//
//  P_CCTV.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/14.
//

import UIKit
import Alamofire

/// CCTV(목록)
extension VC_CCTV {
    
    func GET_CCTV(NAME: String, AC_TYPE: String) {
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/cctv.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.CCTV()
                        
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                        AP_VALUE.SET_AP_NAME(AP_NAME: DICT?["ap_name"] as Any)
                        AP_VALUE.SET_COM_TYPE(COM_TYPE: DICT?["com_type"] as Any)
                        AP_VALUE.SET_ETC_PARAM(ETC_PARAM: DICT?["etc_param"] as Any)
                        AP_VALUE.SET_ETC_VALUE(ETC_VALUE: DICT?["etc_value"] as Any)
                        AP_VALUE.SET_ID_PARAM(ID_PARAM: DICT?["id_param"] as Any)
                        AP_VALUE.SET_ID_VALUE(ID_VALUE: DICT?["id_value"] as Any)
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_PW_PARAM(PW_PARAM: DICT?["pw_param"] as Any)
                        AP_VALUE.SET_PW_VALUE(PW_VALUE: DICT?["pw_value"] as Any)
                        AP_VALUE.SET_REG_DATE(REG_DATE: DICT?["reg_date"] as Any)
                        AP_VALUE.SET_URL(URL: DICT?["url"] as Any)
                        AP_VALUE.SET_VIDEO_NAME(VIDEO_NAME: DICT?["video_name"] as Any)
                        AP_VALUE.SET_VIEW_TYPE(VIEW_TYPE: DICT?["view_type"] as Any)
                        // 데이터 추가
                        self.OBJ_CCTV.append(AP_VALUE)
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_CCTV.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.TABLEVIEW.reloadData()
        }
    }
}
