//
//  P_INPUT.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/04.
//

import UIKit
import Alamofire

/// 정보입력(로그인/회원가입)
extension VC_INPUT {
    
    func PUT_INPUT(NAME: String, AC_TYPE: String) {
        
        let DATA = OBJ_AUTH[POSITION]
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": OBJ_AUTH[POSITION].MB_ID,
            "bk_nick": NICK_TF.text!,
            "ap_code": AP_CODE,
            "building_id": BUILDING_ID,
            "house_number": HOUSE_NUMBER,
            "home_code": AP_CODE+BUILDING_ID+HOUSE_NUMBER,
            "mb_platform": "ios"
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/member/member.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    let RESULT = DICT["result"] as? String ?? "fail"
                    
                    if RESULT == "success" {
                        
                        UserDefaults.standard.setValue(DATA.MB_ID, forKey: "mb_id")
                        UserDefaults.standard.setValue(DATA.BK_NICK, forKey: "bk_nick")
                        UserDefaults.standard.setValue(self.AP_CODE, forKey: "ap_code")
                        UserDefaults.standard.setValue(self.APT_B.titleLabel?.text!.replacingOccurrences(of: "   ", with: ""), forKey: "ap_name")
                        UserDefaults.standard.setValue(self.BUILDING_ID, forKey: "building_id")
                        UserDefaults.standard.setValue(self.AP_CODE+self.BUILDING_ID+self.HOUSE_NUMBER, forKey: "home_code")
                        
                        self.PRESENT_VC(IDENTIFIER: "VC_LOADING", ANIMATED: true)
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError); return
            }
        }
    }
}
