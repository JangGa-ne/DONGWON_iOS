//
//  P_MEDICAL.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/01.
//

import UIKit
import Alamofire

/// 병원/약국(목록)
extension VC_MEDICAL {
    
    func GET_MEDICAL_L(NAME: String, AC_TYPE: String, LM_START: Int) {
        
        if LM_START == 0 { OBJ_MEDICAL.removeAll(); UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }; NODATA(RECT: view, MESSAGE: "데이터 없음") }; if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "hos_type": MN_POSITION+1,
            "limit_start": LM_START,
            "lat": UIViewController.APPDELEGATE.LOC_MANAGER.location?.coordinate.latitude ?? 0,
            "lng": UIViewController.APPDELEGATE.LOC_MANAGER.location?.coordinate.longitude ?? 0
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/medi.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.MEDICAL_L()
                        
                        AP_VALUE.SET_TIME_1C(TIME_1C: DICT?["Time1c"] as Any)
                        AP_VALUE.SET_TIME_1S(TIME_1S: DICT?["Time1c"] as Any)
                        AP_VALUE.SET_TIME_2C(TIME_2C: DICT?["Time2c"] as Any)
                        AP_VALUE.SET_TIME_2S(TIME_2S: DICT?["Time2c"] as Any)
                        AP_VALUE.SET_TIME_3C(TIME_3C: DICT?["Time3c"] as Any)
                        AP_VALUE.SET_TIME_3S(TIME_3S: DICT?["Time3c"] as Any)
                        AP_VALUE.SET_TIME_4C(TIME_4C: DICT?["Time4c"] as Any)
                        AP_VALUE.SET_TIME_4S(TIME_4S: DICT?["Time4c"] as Any)
                        AP_VALUE.SET_TIME_5C(TIME_5C: DICT?["Time5c"] as Any)
                        AP_VALUE.SET_TIME_5S(TIME_5S: DICT?["Time5c"] as Any)
                        AP_VALUE.SET_TIME_6C(TIME_6C: DICT?["Time6c"] as Any)
                        AP_VALUE.SET_TIME_6S(TIME_6S: DICT?["Time6c"] as Any)
                        AP_VALUE.SET_TIME_7C(TIME_7C: DICT?["Time7c"] as Any)
                        AP_VALUE.SET_TIME_7S(TIME_7S: DICT?["Time7c"] as Any)
                        AP_VALUE.SET_TIME_8C(TIME_8C: DICT?["Time8c"] as Any)
                        AP_VALUE.SET_TIME_8S(TIME_8S: DICT?["Time8c"] as Any)
                        AP_VALUE.SET_ADDR(ADDR: DICT?["addr"] as Any)
                        AP_VALUE.SET_BREAK_DAY(BREAK_DAY: DICT?["break_day"] as Any)
                        AP_VALUE.SET_CLCD(CLCD: DICT?["clCd"] as Any)
                        AP_VALUE.SET_CLCD_NAME(CLCD_NAME: DICT?["clCd_name"] as Any)
                        AP_VALUE.SET_DGSBJTCD(DGSBJTCD: DICT?["dgsbjtCd"] as Any)
                        AP_VALUE.SET_DGSBJTCD_NAME(DGSBJTCD_NAME: DICT?["dgsbjtCd_name"] as Any)
                        AP_VALUE.SET_DISTANCE(DISTANCE: DICT?["distance"] as Any)
                        AP_VALUE.SET_HOS_ID(HOS_ID: DICT?["hos_id"] as Any)
                        AP_VALUE.SET_HOS_NAME(HOS_NAME: DICT?["hos_name"] as Any)
                        AP_VALUE.SET_HOS_TYPE(HOS_TYPE: DICT?["hos_type"] as Any)
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_LAT(LAT: DICT?["lat"] as Any)
                        AP_VALUE.SET_LNG(LNG: DICT?["lng"] as Any)
                        AP_VALUE.SET_TEL_NO(TEL_NO: DICT?["telno"] as Any)
                        AP_VALUE.SET_ZIPCD(ZIPCD: DICT?["zipCd"] as Any)
                        AP_VALUE.SET_ZIPCD_NAME(ZIPCD_NAME: DICT?["zipCd_name"] as Any)
                        // 데이터 추가
                        self.OBJ_MEDICAL.append(AP_VALUE)
                    }
                } else if self.OBJ_MEDICAL.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            self.FETCHING_MORE = false
            if self.OBJ_MEDICAL.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
        }
    }
}
