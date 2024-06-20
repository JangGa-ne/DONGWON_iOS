//
//  P_RESERVE_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/24.
//

import UIKit
import Alamofire

/// 시설예약(디테일)
extension VC_RESERVE_1 {
    
    func GET_RESERVE_TIME(NAME: String, AC_TYPE: String, FACIL_CODE: String, BK_DATE: String) {
        
        // 데이터 삭제
        OBJ_RESERVE_D.removeAll(); VIEWS1.removeAll(); LABELS1.removeAll(); IMAGES1.removeAll(); CUSTOM_SV1.removeAllArrangedSubviews()
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "facil_code": FACIL_CODE,
            "book_date": BK_DATE
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/book.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        
                        for (_, DATA) in (DICT?["time_list"] as? Array<Any> ?? []).enumerated() {
                            
                            let DICT = DATA as? [String: Any]
                            let AP_VALUE = RESERVE_D()
                            
                            if DICT?["book_avail"] as? String ?? "N" == "Y" {
                                
                                AP_VALUE.SET_BOOK_AVAIL(BOOK_AVAIL: DICT?["book_avail"] as Any)
                                AP_VALUE.SET_FACIL_BOOK_END(FACIL_BOOK_END: DICT?["facil_book_end"] as Any)
                                AP_VALUE.SET_FACIL_BOOK_START(FACIL_BOOK_START: DICT?["facil_book_start"] as Any)
                                AP_VALUE.SET_FACIL_CODE(FACIL_CODE: DICT?["facil_code"] as Any)
                                AP_VALUE.SET_FACIL_DAY(FACIL_DAY: DICT?["facil_day"] as Any)
                                AP_VALUE.SET_FACIL_TIME_NAME(FACIL_TIME_NAME: DICT?["facil_time_name"] as Any)
                                AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                                // 데이터 추가
                                self.OBJ_RESERVE_D.append(AP_VALUE)
                            }
                        }
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            self.SETUP()
        }
    }
    
    func PUT_RESERVE(NAME: String, AC_TYPE: String) {
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "facil_code": OBJ_RESERVE_L[POSITION].FACIL_CODE,
            "book_start": START,
            "book_end": END
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/book.php", method: .post, parameters: PARAMETERS).responseJSON(completionHandler: { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("KEY: \(KEY), VALUE: \(VALUE)") }; print(response)
            
            if let DICT = response.result.value as? [String: Any] {
                
                let RESULT = DICT["result"] as? String ?? "fail"
                
                if RESULT == "success" {
                    self.S_NOTICE(":) 예약 하였습니다")
                } else if RESULT == "taken" {
                    self.S_NOTICE(":) 이미 등록된 예약입니다")
                } else {
                    self.S_NOTICE(":( 예약 실패하였습니다"); self.dismiss(animated: true, completion: nil)
                }
            }
        })
    }
}
