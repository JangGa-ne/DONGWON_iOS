//
//  P_LOADING.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/01.
//

import UIKit
import Alamofire

/// 로딩(로그인)
extension VC_LOADING {
    
    func GET_LOGIN(NAME: String, AC_TYPE: String) {
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        // 데이터 삭제
        UIViewController.APPDELEGATE.OBJ_LOGIN.removeAll()
        UIViewController.APPDELEGATE.OBJ_WEATHER.removeAll()
        UIViewController.APPDELEGATE.OBJ_SOSIK1.removeAll()
        UIViewController.APPDELEGATE.OBJ_EXPENESE = EXPENESE(AMOUNT: "", IN_OUT: "", TARGET_MONTH: "")
        UIViewController.APPDELEGATE.OBJ_PARKING = PARKING(PERM_CAR: "", TEMP_CAR: "")
        UIViewController.APPDELEGATE.OBJ_ALLMENU.removeAll()
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "mb_platform": "ios"
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/member/member.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    /// 프로필 정보
                    if let DICT1 = DICT["member_detail"] as? [String: Any], let DICT2 = DICT["member_info"] as? [String: Any] {
                        
                        UserDefaults.standard.setValue(DICT2["mb_id"] ?? "", forKey: "mb_id")
                        UserDefaults.standard.setValue(DICT2["bk_name"] ?? "", forKey: "bk_name")
                        UserDefaults.standard.setValue(DICT2["bk_nick"] ?? "", forKey: "bk_nick")
                        UserDefaults.standard.setValue(DICT1["ap_code"] ?? "", forKey: "ap_code")
                        UserDefaults.standard.setValue((DICT1["ap_name"] as? String ?? "").replacingOccurrences(of: "아파트", with: ""), forKey: "ap_name")
                        UserDefaults.standard.setValue(DICT1["building_id"] ?? "", forKey: "building_id")
                        UserDefaults.standard.setValue(DICT1["home_code"] ?? "", forKey: "home_code")
                        
                        let AP_VALUE = Apartment.LOGIN()
                        
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT1["ap_code"] as Any)
                        AP_VALUE.SET_AP_NAME(AP_NAME: DICT1["ap_name"] as Any)
                        AP_VALUE.SET_BK_NAME(BK_NAME: DICT2["bk_name"] as Any)
                        AP_VALUE.SET_BK_NICK(BK_NICK: DICT2["bk_nick"] as Any)
                        AP_VALUE.SET_BUILDING_ID(BUILDING_ID: DICT1["building_id"] as Any)
                        AP_VALUE.SET_FCM_ID(FCM_ID: DICT2["fcm_id"] as Any)
                        AP_VALUE.SET_HOME_ID(HOME_ID: DICT1["home_id"] as Any)
                        AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT1["home_code"] as Any)
                        AP_VALUE.SET_HOME_NAME(HOME_NAME: DICT1["home_name"] as Any)
                        AP_VALUE.SET_HOME_PHONE(HOME_PHONE: DICT1["home_phone"] as Any)
                        AP_VALUE.SET_HOME_SAFE_NUMBER(HOME_SAFE_NUMBER: DICT1["home_safe_number"] as Any)
                        AP_VALUE.SET_HOUSE_NUMBER(HOUSE_NUMBER: DICT1["house_number"] as Any)
                        AP_VALUE.SET_MB_ID(MB_ID: DICT2["mb_id"] as Any)
                        AP_VALUE.SET_MB_LEVEL(MB_LEVEL: DICT1["mb_level"] as Any)
                        AP_VALUE.SET_MB_PHOTO(MB_PHOTO: DICT2["mb_photo"] as Any)
                        AP_VALUE.SET_MB_TYPE(MB_TYPE: DICT1["mb_type"] as Any)
                        AP_VALUE.SET_MEMBER_FLOOR(MEMBER_FLOOR: DICT1["member_floor"] as Any)
                        AP_VALUE.SET_RESULT(RESULT: DICT1["result"] as Any)
                        AP_VALUE.SET_SAFE_NUMBER(SAFE_NUMBER: DICT1["safe_number"] as Any)
                        AP_VALUE.SET_SC_CITY(SC_CITY: DICT1["sc_city"] as Any)
                        AP_VALUE.SET_SD_CODE(SD_CODE: DICT1["sd_code"] as Any)
                        AP_VALUE.SET_SIP_ID(SIP_ID: DICT1["sip_id"] as Any)
                        AP_VALUE.SET_SIP_IP(SIP_IP: DICT1["sip_ip"] as Any)
                        AP_VALUE.SET_SIP_IP2(SIP_IP2: DICT1["sip_ip2"] as Any)
                        AP_VALUE.SET_SIP_IP3(SIP_IP3: DICT1["sip_ip3"] as Any)
                        AP_VALUE.SET_SIP_PORT(SIP_PORT: DICT1["sip_port"] as Any)
                        AP_VALUE.SET_SS_TOKEN(SS_TOKEN: DICT1["ss_token"] as Any)
                        AP_VALUE.SET_STUN_PORT(STUN_PORT: DICT1["stun_port"] as Any)
                        AP_VALUE.SET_TUYA_TOKEN(TUYA_TOKEN: DICT1["tuya_token"] as Any)
                        // 데이터 추가
                        UIViewController.APPDELEGATE.OBJ_LOGIN.append(AP_VALUE)
                    }
                    /// 날씨
                    if let DICT3 = DICT["weather"] as? [String: Any] {
                        
                        let AP_VALUE = Apartment.WEATHER()
                        
                        AP_VALUE.SET_AP_ADDR(AP_ADDR: DICT3["kaptAddr"] as Any)
                        AP_VALUE.SET_AP_LOGO(AP_LOGO: DICT3["apt_logo"] as Any)
                        AP_VALUE.SET_AP_NAME(AP_NAME: DICT3["ap_name"] as Any)
                        AP_VALUE.SET_LGT(LGT: DICT3["LGT"] as Any)
                        AP_VALUE.SET_PTY(PTY: DICT3["PTY"] as Any)
                        AP_VALUE.SET_REH(REH: DICT3["REH"] as Any)
                        AP_VALUE.SET_RN1(RN1: DICT3["RH1"] as Any)
                        AP_VALUE.SET_SKY(SKY: DICT3["SKY"] as Any)
                        AP_VALUE.SET_T1H(T1H: DICT3["T1H"] as Any)
                        AP_VALUE.SET_UUU(UUU: DICT3["UUU"] as Any)
                        AP_VALUE.SET_VEC(VEC: DICT3["VEC"] as Any)
                        AP_VALUE.SET_VVV(VVV: DICT3["VVV"] as Any)
                        AP_VALUE.SET_WSD(WSD: DICT3["WSD"] as Any)
                        AP_VALUE.SET_PM10VALUE(PM10VALUE: DICT3["pm10Value"] as Any)
                        AP_VALUE.SET_PM25VALUE(PM25VALUE: DICT3["pm25Value"] as Any)
                        // 데이터 추가
                        UIViewController.APPDELEGATE.OBJ_WEATHER.append(AP_VALUE)
                    }
                    /// 소식(공지사항,커뮤니티,동네소식)
                    let ARRAY4 = DICT["notice_contents"] as? Array<Any> ?? []
                    let ARRAY5 = DICT["schedule_contents"] as? Array<Any> ?? []
                    let ARRAY6 = DICT["circle_contents"] as? Array<Any> ?? []
                    let ARRAY7 = DICT["local_news"] as? Array<Any> ?? []
                    
                    for (I, DATA) in (ARRAY4+ARRAY5+ARRAY6+ARRAY7).enumerated() {
                        
                        let DICT4 = DATA as? [String: Any]
                        let AP_VALUE = Apartment.SOSIK_L1()
                        
                        if I < ARRAY4.count {
                            AP_VALUE.SET_ARRAY_CNT(ARRAY_CNT: 0)
                        } else if I < ARRAY4.count+ARRAY5.count {
                            AP_VALUE.SET_ARRAY_CNT(ARRAY_CNT: 1)
                        } else if I < ARRAY4.count+ARRAY5.count+ARRAY6.count {
                            AP_VALUE.SET_ARRAY_CNT(ARRAY_CNT: 2)
                        } else if I < ARRAY4.count+ARRAY5.count+ARRAY6.count+ARRAY7.count {
                            AP_VALUE.SET_ARRAY_CNT(ARRAY_CNT: 3)
                        }
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT4?["ap_code"] as Any)
                        AP_VALUE.SET_AP_COMMENT(AP_COMMENT: DICT4?["ap_cooment"] as Any)
                        AP_VALUE.SET_AP_CONTENT_TEXT(AP_CONTENT_TEXT: DICT4?["ap_content_text"] as Any)
                        AP_VALUE.SET_AP_LIKE(AP_LIKE: DICT4?["ap_like"] as Any)
                        AP_VALUE.SET_AP_MSG_GROUP(AP_MSG_GROUP: DICT4?["ap_msg_group"] as Any)
                        AP_VALUE.SET_AP_REQUEST_TIME(AP_REQUEST_TIME: DICT4?["ap_request_time"] as Any)
                        AP_VALUE.SET_AP_SEQ(AP_SEQ: DICT4?["ap_seq"] as Any)
                        AP_VALUE.SET_AP_SUBJECT(AP_SUBJECT: DICT4?["ap_subject"] as Any)
                        AP_VALUE.SET_AP_SUBJECT_TEXT(AP_SUBJECT_TEXT: DICT4?["ap_subject_text"] as Any)
                        AP_VALUE.SET_ARTICLE_TYPE(ARTICLE_TYPE: DICT4?["article_type"] as Any)
                        AP_VALUE.SET_BADGE_COLOR(BADGE_COLOR: DICT4?["badge_color"] as Any)
                        AP_VALUE.SET_BK_NAME(BK_NAME: DICT4?["bk_name"] as Any)
                        AP_VALUE.SET_BOARD_NAME(BOARD_NAME: DICT4?["board_name"] as Any)
                        AP_VALUE.SET_BOARD_TYPE(BOARD_TYPE: DICT4?["board_type"] as Any)
                        AP_VALUE.SET_CC_CODE(CC_CODE: DICT4?["cc_code"] as Any)
                        AP_VALUE.SET_CC_NAME(CC_NAME: DICT4?["cc_name"] as Any)
                        AP_VALUE.SET_LOGO_URL(LOGO_URL: DICT4?["logo_url"] as Any)
                        AP_VALUE.SET_READ_CNT(READ_CNT: DICT4?["read_cnt"] as Any)
                        AP_VALUE.SET_SD_CODE(SD_CODE: DICT4?["sd_code"] as Any)
                        AP_VALUE.SET_SENDER_NICK(SENDER_NICK: DICT4?["sender_nick"] as Any)
                        // 데이터 추가
                        UIViewController.APPDELEGATE.OBJ_SOSIK1.append(AP_VALUE)
                    }
                    /// 관리비(기본)
                    if let DICT5 = DICT["bill_info"] as? [String: Any] {
                        
                        let AP_VALUE = EXPENESE(
                            AMOUNT: DICT5["amount"] as? String ?? "",
                            IN_OUT: DICT5["in_out"] as? String ?? "",
                            TARGET_MONTH: DICT5["target_month"] as? String ?? ""
                        )
                        // 데이터 추가
                        UIViewController.APPDELEGATE.OBJ_EXPENESE = AP_VALUE
                    }
                    /// 주차정보(기본)
                    if let DICT6 = DICT["car_info"] as? [String: Any] {
                        
                        let AP_VALUE = PARKING(
                            PERM_CAR: DICT6["perm_car"] as? String ?? "",
                            TEMP_CAR: DICT6["temp_car"] as? String ?? ""
                        )
                        // 데이터 추가
                        UIViewController.APPDELEGATE.OBJ_PARKING = AP_VALUE
                    }
                    /// 전체메뉴(목록)
                    if let ARRAY8 = DICT["function_list"] as? Array<Any> {
                        
                        for (_, DATA) in ARRAY8.enumerated() {
                            
                            let DICT7 = DATA as? [String: Any]
                            let AP_VALUE = Apartment.ALLMENU_L()
                            
                            AP_VALUE.SET_AP_CODE(AP_CODE: DICT7?["ap_code"] as Any)
                            AP_VALUE.SET_AP_NAME(AP_NAME: DICT7?["ap_name"] as Any)
                            AP_VALUE.SET_CATEGORY_NAME(CATEGORY_NAME: DICT7?["category_name"] as Any)
                            AP_VALUE.SET_CATEGORY_TYPE(CATEGORY_TYPE: DICT7?["category_type"] as Any)
                            AP_VALUE.SET_DISPLAY_CONTENT(DISPLAY_CONTENT: DICT7?["display_content"] as Any)
                            AP_VALUE.SET_DISPLAY_LIST(DISPLAY_LIST: DICT7?["display_list"] as Any)
                            AP_VALUE.SET_DISPLAY_MAIN(DISPLAY_MAIN: DICT7?["display_main"] as Any)
                            AP_VALUE.SET_DISPLAY_OFFICE_CONTENT(DISPLAY_OFFICE_CONTENT: DICT7?["display_office_content"] as Any)
                            AP_VALUE.SET_DISPLAY_OFFICE_LIST(DISPLAY_OFFICE_LIST: DICT7?["display_office_list"] as Any)
                            AP_VALUE.SET_DISPLAY_OFFICE_MAIN(DISPLAY_OFFICE_MAIN: DICT7?["display_office_main"] as Any)
                            AP_VALUE.SET_FUNCTION_CODE(FUNCTION_CODE: DICT7?["function_code"] as Any)
                            AP_VALUE.SET_FUNCTION_EXPLAIN(FUNCTION_EXPLAIN: DICT7?["function_explain"] as Any)
                            AP_VALUE.SET_FUNCTION_NAME(FUNCTION_NAME: DICT7?["function_name"] as Any)
                            AP_VALUE.SET_FUNCTION_ORDER(FUNCTION_ORDER: DICT7?["function_order"] as Any)
                            AP_VALUE.SET_ICON_IMG(ICON_IMG: DICT7?["icon_img"] as Any)
                            AP_VALUE.SET_IDX(IDX: DICT7?["idx"] as Any)
                            AP_VALUE.SET_USE_COMPANY(USE_COMPANY: DICT7?["use_company"] as Any)
                            AP_VALUE.SET_USE_MODEL(USE_MODEL: DICT7?["use_model"] as Any)
                            // 데이터 추가
                            UIViewController.APPDELEGATE.OBJ_ALLMENU.append(AP_VALUE)
                        }
                    }
                    
                    if self.PUSH {
                        let TBC = self.storyboard?.instantiateViewController(withIdentifier: "TBC_MAIN") as! UITabBarController
                        TBC.selectedIndex = 0
                        self.navigationController?.pushViewController(TBC, animated: true, completion: {
                            for (KEY, VALUE) in UIViewController.APPDELEGATE.MENUS {
                                if VALUE != "VC_AA" && KEY == self.FC_NAME { UIViewController.APPDELEGATE.MENU = KEY
                                    if VALUE == "VC_SOSIK" {
                                        let VC = self.storyboard?.instantiateViewController(withIdentifier: "VC_SOSIK_1") as! VC_SOSIK_1
                                        VC.BD_TYPE = self.BD_TYPE; VC.AP_SEQ = self.AP_SEQ; VC.AP_MSG_GROUP = self.AP_MSG_GROUP
                                        self.navigationController?.pushViewController(VC, animated: true)
                                    } else {
                                        self.PRESENT_VC(IDENTIFIER: VALUE, ANIMATED: true)
                                    }
                                }
                            }
                        })
                    } else if self.UPDATE {
                        let TBC = self.storyboard?.instantiateViewController(withIdentifier: "TBC_MAIN") as! UITabBarController
                        TBC.selectedIndex = 0
                        self.navigationController?.pushViewController(TBC, animated: true, completion: {
                            self.PRESENT_VC(IDENTIFIER: "VC_SETTING", ANIMATED: true)
                        })
                    } else {
                        self.PRESENT_TBC(IDENTIFIER: "TBC_MAIN", INDEX: 0, ANIMATED: true)
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
//                self.S_ERROR(response.result.error as? AFError)
                
                let ALERT = UIAlertController(title: "오류", message: "서버에 연결할 수 없습니다. 나중에 재접속하시기 바랍니다.", preferredStyle: .alert)
                ALERT.addAction(UIAlertAction(title: "앱 종료하기", style: .destructive, handler: { _ in exit(0) }))
                self.present(ALERT, animated: true, completion: nil)
            }
        }
    }
}
