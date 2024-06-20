//
//  P_CONTACT.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/01.
//

import UIKit
import Alamofire

/// 동네연락처(목록)
extension VC_CONTACT {
    
    func GET_CONTACT_L(NAME: String, AC_TYPE: String) {
        
        // 데이터 삭제
        OBJ_CONTACT.removeAll(); TABLEVIEW.reloadData()
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/phone_book.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.CONTACT_L()
                        
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_PH_ADDR(PH_ADDR: DICT?["ph_addr"] as Any)
                        AP_VALUE.SET_PH_EMAIL(PH_EMAIL: DICT?["ph_email"] as Any)
                        AP_VALUE.SET_PH_FAX(PH_FAX: DICT?["ph_fax"] as Any)
                        AP_VALUE.SET_PH_NAME(PH_NAME: DICT?["ph_name"] as Any)
                        AP_VALUE.SET_PH_PHONE1(PH_PHONE1: DICT?["ph_phone"] as Any)
                        AP_VALUE.SET_PH_PHONE2(PH_PHONE2: DICT?["ph_phone2"] as Any)
                        // 데이터 추가
                        self.OBJ_CONTACT.append(AP_VALUE)
                    }
                } else if self.OBJ_CONTACT.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_CONTACT.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.TABLEVIEW.reloadData()
        }
    }
}
