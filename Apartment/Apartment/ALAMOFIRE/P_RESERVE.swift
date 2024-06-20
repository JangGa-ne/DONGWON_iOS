//
//  P_RESERVE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/30.
//

import UIKit
import Alamofire

/// 시설예약(목록)
extension VC_RESERVE {
    
    func GET_RESERVE(NAME: String, AC_TYPE: String) {
        
        // 데이터 삭제
        OBJ_RESERVE.removeAll(); COLLECTIONVIEW.reloadData()
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/book.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.RESERVE_L()
                        
//                        if DICT?["display"] as? String ?? "N" == "Y" {
                            
                            AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                            AP_VALUE.SET_AUTO_APPROVE(AUTO_APPROVE: DICT?["auto_approve"] as Any)
                            AP_VALUE.SET_BOOK_AVIL_DAYS(BOOK_AVIL_DAYS: DICT?["book_avil_days"] as Any)
                            AP_VALUE.SET_BOOK_ONETIME_USE(BOOK_ONETIME_USE: DICT?["book_onetime_use"] as Any)
                            AP_VALUE.SET_DISPLAY(DISPLAY: DICT?["display"] as Any)
                            AP_VALUE.SET_FACIL_CODE(FACIL_CODE: DICT?["facil_code"] as Any)
                            AP_VALUE.SET_FACIL_CODE_NAME(FACIL_CODE_NAME: DICT?["facil_code_name"] as Any)
                            AP_VALUE.SET_FACIL_EXPLAIN(FACIL_EXPLAIN: DICT?["facil_explain"] as Any)
                            AP_VALUE.SET_FACIL_FILE(FACIL_FILE: DICT?["facil_file"] as Any)
                            AP_VALUE.SET_FACIL_OPEN(FACIL_OPEN: DICT?["facil_open"] as Any)
                            AP_VALUE.SET_FACIL_PRICE_MEMBER(FACIL_PRICE_MEMBER: DICT?["facil_price_member"] as Any)
                            AP_VALUE.SET_FACIL_PRICE_ONETIME(FACIL_PRICE_ONETIME: DICT?["facil_price_onetime"] as Any)
                            AP_VALUE.SET_FACIL_THUMB(FACIL_THUMB: DICT?["facil_thumb"] as Any)
                            AP_VALUE.SET_FACIL_TYPE(FACIL_TYPE: DICT?["facil_type"] as Any)
                            AP_VALUE.SET_ICON_URL(ICON_URL: DICT?["icon_url"] as Any)
                            AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                            AP_VALUE.SET_MANAGER_NAME(MANAGER_NAME: DICT?["member_name"] as Any)
                            AP_VALUE.SET_MANAGER_PHONE(MANAGER_PHONE: DICT?["member_phone"] as Any)
                            AP_VALUE.SET_MAX_BOOK_CNT(MAX_BOOK_CNT: DICT?["max_book_cnt"] as Any)
                            AP_VALUE.SET_MAX_BOOK_TYPE(MAX_BOOK_TYPE: DICT?["max_book_only"] as Any)
                            AP_VALUE.SET_MEMBER_ONLY(MEMBER_ONLY: DICT?["member_only"] as Any)
                            AP_VALUE.SET_MEMBER_USE(MEMBER_USE: DICT?["member_use"] as Any)
                            AP_VALUE.SET_OPEN_INFO(OPEN_INFO: DICT?["open_info"] as Any)
                            AP_VALUE.SET_SEND_QR(SEND_QR: DICT?["send_qr"] as Any)
                            AP_VALUE.SET_USE_BOOK_TIME(USE_BOOK_TIME: DICT?["use_book_time"] as Any)
                            AP_VALUE.SET_USER_CNT(USER_CNT: DICT?["user_cnt"] as Any)
                            // 데이터 추가
                            self.OBJ_RESERVE.append(AP_VALUE)
//                        }
                    }
                } else if self.OBJ_RESERVE.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_RESERVE.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.COLLECTIONVIEW.reloadData()
        }
    }
}
