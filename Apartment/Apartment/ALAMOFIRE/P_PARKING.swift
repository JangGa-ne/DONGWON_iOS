//
//  P_2.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/28.
//

import UIKit
import Alamofire

/// 주차등록(목록)
extension VC_PARKING {
    
    /// 방문주차
    func GET_PARKING_L1(NAME: String, AC_TYPE: String, LM_START: Int) {
        
        if LM_START == 0 { OBJ_PARKING.removeAll(); UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }; NODATA(RECT: view, MESSAGE: "데이터 없음") }; if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "limit_start": LM_START
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/visit.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.PARKING_L()
                        
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                        AP_VALUE.SET_BK_NAME(BK_NAME: DICT?["bk_name"] as Any)
                        AP_VALUE.SET_BUILDING_ID(BUILDING_ID: DICT?["building_id"] as Any)
                        AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT?["home_code"] as Any)
                        AP_VALUE.SET_HOUSE_NUMBER(HOUSE_NUMBER: DICT?["house_number"] as Any)
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_INPUT_DATETIME(INPUT_DATETIME: DICT?["input_datetime"] as Any)
                        AP_VALUE.SET_MB_ID(MB_ID: DICT?["mb_id"] as Any)
                        AP_VALUE.SET_QUE_STATUS(QUE_STATUS: DICT?["que_status"] as Any)
                        AP_VALUE.SET_CAR_CHAR(CAR_CHAR: DICT?["visit_car_char"] as Any)
                        AP_VALUE.SET_CAR_END(CAR_END: DICT?["visit_car_end"] as Any)
                        AP_VALUE.SET_CAR_INIT(CAR_INIT: DICT?["visit_car_init"] as Any)
                        AP_VALUE.SET_DATE(DATE: DICT?["visit_date"] as Any)
                        AP_VALUE.SET_END(END: DICT?["visit_end"] as Any)
                        AP_VALUE.SET_MEMO(MEMO: DICT?["visit_memo"] as Any)
                        AP_VALUE.SET_MODIFY(MODIFY: DICT?["visit_modify"] as Any)
                        AP_VALUE.SET_NAME(NAME: DICT?["visit_name"] as Any)
                        AP_VALUE.SET_PHONE(PHONE: DICT?["visit_phone"] as Any)
                        AP_VALUE.SET_PUSH(PUSH: DICT?["visit_push"] as Any)
                        AP_VALUE.SET_RESON(RESON: DICT?["visit_reson"] as Any)
                        AP_VALUE.SET_START(START: DICT?["visit_start"] as Any)
                        AP_VALUE.SET_STATUS(STATUS: DICT?["visit_status"] as Any)
                        // 데이터 추가
                        self.OBJ_PARKING.append(AP_VALUE)
                    }
                } else if self.OBJ_PARKING.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            self.FETCHING_MORE = false
            if self.OBJ_PARKING.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
        }
    }
    
    /// 세대주차/차량출입
    func GET_PARKING_L2(NAME: String, AC_TYPE: String) {
        
        // 데이터 삭제
        OBJ_PARKING.removeAll(); UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/parking.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.PARKING_L()
                        
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                        AP_VALUE.SET_APPROVE_END(APPROVE_END: DICT?["approve_end"] as Any)
                        AP_VALUE.SET_APPROVE_START(APPROVE_START: DICT?["approve_start"] as Any)
                        AP_VALUE.SET_BK_NAME(BK_NAME: DICT?["bk_name"] as Any)
                        AP_VALUE.SET_BUILDING_ID(BUILDING_ID: DICT?["building_id"] as Any)
                        AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT?["home_code"] as Any)
                        AP_VALUE.SET_HOUSE_NUMBER(HOUSE_NUMBER: DICT?["house_number"] as Any)
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_INPUT_DATETIME(INPUT_DATETIME: DICT?["input_datetime"] as Any)
                        AP_VALUE.SET_IN_DATE(IN_DATE: DICT?["in_date"] as Any)
                        AP_VALUE.SET_IN_TIME(IN_TIME: DICT?["in_time"] as Any)
                        AP_VALUE.SET_MB_ID(MB_ID: DICT?["mb_id"] as Any)
                        AP_VALUE.SET_QUE_STATUS(QUE_STATUS: DICT?["que_status"] as Any)
                        AP_VALUE.SET_CAR_CHAR(CAR_CHAR: DICT?["car_char"] as Any)
                        AP_VALUE.SET_CAR_END(CAR_END: DICT?["car_end"] as Any)
                        AP_VALUE.SET_CAR_INIT(CAR_INIT: DICT?["car_init"] as Any)
                        AP_VALUE.SET_CAR_MEMO(CAR_MEMO: DICT?["car_memo"] as Any)
                        AP_VALUE.SET_CAR_PHONE(CAR_PHONE: DICT?["car_phone"] as Any)
                        AP_VALUE.SET_CAR_STATUS(CAR_STATUS: DICT?["car_status"] as Any)
                        AP_VALUE.SET_DISABLED_CAR(DISABLED_CAR: DICT?["disabled_car"] as Any)
                        AP_VALUE.SET_DATE(DATE: DICT?["visit_date"] as Any)
                        AP_VALUE.SET_END(END: DICT?["visit_end"] as Any)
                        AP_VALUE.SET_MEMO(MEMO: DICT?["visit_memo"] as Any)
                        AP_VALUE.SET_MODIFY(MODIFY: DICT?["visit_modify"] as Any)
                        AP_VALUE.SET_NAME(NAME: DICT?["visit_name"] as Any)
                        AP_VALUE.SET_ORG_NUMBER(ORG_NUMBER: DICT?["org_number"] as Any)
                        AP_VALUE.SET_OUT_DATE(OUT_DATE: DICT?["out_date"] as Any)
                        AP_VALUE.SET_OUT_TIME(OUT_TIME: DICT?["out_time"] as Any)
                        AP_VALUE.SET_PHONE(PHONE: DICT?["visit_phone"] as Any)
                        AP_VALUE.SET_PLATE_INFO(PLATE_INFO: DICT?["plate_info"] as Any)
                        AP_VALUE.SET_PREG_CAR(PREG_CAR: DICT?["preg_car"] as Any)
                        AP_VALUE.SET_PUSH(PUSH: DICT?["visit_push"] as Any)
                        AP_VALUE.SET_REG_DATE(REG_DATE: DICT?["reg_date"] as Any)
                        AP_VALUE.SET_REG_TYPE(REG_TYPE: DICT?["reg_type"] as Any)
                        AP_VALUE.SET_RESON(RESON: DICT?["visit_reson"] as Any)
                        AP_VALUE.SET_SAFE_NUMBER(SAFE_NUMBER: DICT?["safe_number"] as Any)
                        AP_VALUE.SET_START(START: DICT?["visit_start"] as Any)
                        AP_VALUE.SET_STATUS(STATUS: DICT?["visit_status"] as Any)
                        AP_VALUE.SET_VISIT_IDX(VISIT_IDX: DICT?["visit_idx"] as Any)
                        // 데이터 추가
                        self.OBJ_PARKING.append(AP_VALUE)
                    }
                } else if self.OBJ_PARKING.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_PARKING.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
        }
    }
    
    func PUT_PARKING(NAME: String, AC_TYPE: String, IDX: String) {
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "idx": IDX
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/visit.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    if DICT["result"] as? String ?? "fail" == "success" {
                        self.S_NOTICE(":) 삭제 되었습니다")
                        self.GET_PARKING_L1(NAME: "방문주차(목록)", AC_TYPE: "list", LM_START: 0)
                        if let DEL = UIViewController.APPDELEGATE.TBC_2_DEL {
                            let TEMP_CAR = Int(UIViewController.APPDELEGATE.OBJ_PARKING.TEMP_CAR) ?? 0
                            DEL.PARKING_L1.text = "\(TEMP_CAR-1)"
                        }
                    } else {
                        self.S_NOTICE(":( 삭제 할 수 없습니다")
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
        }
    }
}
