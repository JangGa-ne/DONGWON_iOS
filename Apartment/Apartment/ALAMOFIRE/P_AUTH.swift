//
//  P_AUTH.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/30.
//

import UIKit
import Alamofire

/// 본인인증(로그인/회원가입)
extension VC_AUTH {
    
    func PUT_AUTH(NAME: String, AC_TYPE: String) {
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        // 데이터 삭제
        OBJ_AUTH.removeAll()
        
        var PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": NUMBER_TF1.text!.replacingOccurrences(of: "-", with: "")
        ]
        
        if AC_TYPE == "check" { PARAMETERS["sign_key"] = NUMBER_TF2.text! }
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/member/sms_sign.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    let RESULT = DICT["result"] as? String ?? "fail"
                    let SIGN_KEY = DICT["sign_key"] as? String ?? ""
                    
                    if AC_TYPE == "request" {
                        
                        if RESULT == "success" || (RESULT == "none" && SIGN_KEY != "") {
                        
                            self.NUMBER_V1.isHidden = true; self.NUMBER_V2.isHidden = true
                            self.CUSTOM_V1_1.isHidden = true; self.CUSTOM_V1_2.isHidden = false
                            
                            if SIGN_KEY != "" && ((self.NUMBER_TF1.text!.replacingOccurrences(of: "-", with: "") == "01031870005") || (self.NUMBER_TF1.text!.replacingOccurrences(of: "-", with: "") == "01095330004")) {
                                self.NUMBER_TF1.resignFirstResponder(); self.NUMBER_TF2.text = SIGN_KEY; self.NUMBER_V2.isHidden = false
                            } else {
                                self.NUMBER_TF2.becomeFirstResponder()
                            }
                            
                            self.ALERT(TITLE: "", BODY: ":) 인증번호를 요청하였습니다.", STYLE: .alert)
                        } else if RESULT == "exceeded" {
                            self.ALERT(TITLE: "", BODY: ":( 하루에 3회 요청 할 수 있습니다.", STYLE: .alert)
                        } else if RESULT == "nouser" {
                            self.ALERT(TITLE: "", BODY: ":( 등록되지 않은 멤버입니다. 관리사무소에 문의하시기 바랍니다.", STYLE: .alert)
                        } else {
                            self.ALERT(TITLE: "", BODY: ":( 인증번호 요청 실패하였습니다.", STYLE: .alert)
                        }
                    } else if AC_TYPE == "check" {
                        
                        if RESULT == "success" {
                            
                            UserDefaults.standard.setValue(self.NUMBER_TF1.text!.replacingOccurrences(of: "-", with: ""), forKey: "mb_id")
                            
                            self.SIGNCHECK = true
                            
                            if let DICT1 = DICT["Member_info"] as? [String: Any] {
                                
                                let AP_VALUE = Apartment.AUTH()
                                
                                AP_VALUE.SET_ADMIN_NUMBER(ADMIN_NUMBER: DICT1["admin_number"] as Any)
                                AP_VALUE.SET_AP_CODE(AP_CODE: DICT1["ap_code"] as Any)
                                AP_VALUE.SET_AP_NAME(AP_NAME: DICT1["ap_name"] as Any)
                                AP_VALUE.SET_BG_NAME(BG_NAME: DICT1["bg_name"] as Any)
                                AP_VALUE.SET_BG_NO(BG_NO: DICT1["bg_no"] as Any)
                                AP_VALUE.SET_BK_NAME(BK_NAME: DICT1["bk_name"] as Any)
                                AP_VALUE.SET_BK_NICK(BK_NICK: DICT1["bk_nick"] as Any)
                                AP_VALUE.SET_BUILDING_ID(BUILDING_ID: DICT1["building_id"] as Any)
                                AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT1["home_code"] as Any)
                                AP_VALUE.SET_HOUSE_NUMBER(HOUSE_NUMBER: DICT1["house_number"] as Any)
                                AP_VALUE.SET_MB_ID(MB_ID: DICT1["mb_id"] as Any)
                                AP_VALUE.SET_MB_LEVEL(MB_LEVEL: DICT1["mb_level"] as Any)
                                AP_VALUE.SET_MB_PHOTO(MB_PHOTO: DICT1["mb_photo"] as Any)
                                AP_VALUE.SET_MB_TYPE(MB_TYPE: DICT1["mb_type"] as Any)
                                AP_VALUE.SET_SD_CODE(SD_CODE: DICT1["sd_code"] as Any)
                                AP_VALUE.SET_SS_TOKEN(SS_TOKEN: DICT1["ss_token"] as Any)
                                AP_VALUE.SET_TUYA_TOKEN(TUYA_TOKEN: DICT1["tuya_token"] as Any)
                                // 데이터 추가
                                self.OBJ_AUTH.append(AP_VALUE)
                            }
                            self.view.endEditing(true); self.NUMBER_V2.isHidden = true; self.CUSTOM_V1_2.isHidden = true
                            
                            self.ALERT(TITLE: "", BODY: ":) 인증되었습니다.", STYLE: .alert)
                        } else if RESULT == "timeover" {
                            self.ALERT(TITLE: "", BODY: ":( 입력시간 초과입니다.", STYLE: .alert)
                        } else {
                            self.ALERT(TITLE: "", BODY: ":( 인증번호가 맞지 않거나, 확인 할 수 없습니다.", STYLE: .alert)
                        }
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
        }
    }
}
