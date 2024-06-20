//
//  P_EXPENESE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/29.
//

import UIKit
import Alamofire

/// 관리비(목록)
extension VC_EXPENESE {
    
    func GET_EXPENESE_L1(NAME: String, AC_TYPE: String, TARGET_MONTH: String) {
        
        // 데이터 삭제
        OBJ_EXPENESE.removeAll(); UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "target_month": TARGET_MONTH.replacingOccurrences(of: "년", with: "").replacingOccurrences(of: "월", with: "").replacingOccurrences(of: " ", with: "")
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/bill/bill_info.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.EXPENESE_L1()
                        
                        AP_VALUE.SET_AMOUNT(AMOUNT: DICT?["amount"] as Any)
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                        AP_VALUE.SET_AP_NAME(AP_NAME: DICT?["ap_name"] as Any)
                        AP_VALUE.SET_BILL_COMPARE(BILL_COMPARE: self.GET_EXPENESE_D1(DICT: DICT?["bill_compare"] as? [String: Any] ?? [:]))
                        AP_VALUE.SET_BILL_DETAIL(BILL_DETAIL: self.GET_EXPENESE_D2(ARRAY: DICT?["bill_detail"] as? [Any] ?? []))
                        AP_VALUE.SET_BILL_PAID(BILL_PAID: DICT?["bill_paid"] as Any)
                        AP_VALUE.SET_BUILDING_ID(BUILDING_ID: DICT?["building_id"] as Any)
                        AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT?["home_code"] as Any)
                        AP_VALUE.SET_HOUSE_NUMBER(HOUSE_NUMBER: DICT?["house_number"] as Any)
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_IN_OUT(IN_OUT: DICT?["in_out"] as Any)
                        AP_VALUE.SET_LAST_AMOUNT(LAST_AMOUNT: DICT?["last_amount"] as Any)
                        AP_VALUE.SET_LAST_IN_OUT(LAST_IN_OUT: DICT?["last_in_out"] as Any)
                        AP_VALUE.SET_LAST_UPDATE(LAST_UPDATE: DICT?["last_update"] as Any)
                        AP_VALUE.SET_TARGET_MONTH(TARGET_MONTH: DICT?["target_month"] as Any)
                        // 데이터 추가
                        self.OBJ_EXPENESE.append(AP_VALUE)
                    }
                } else if self.OBJ_EXPENESE.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_EXPENESE.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
        }
    }
    
    func GET_EXPENESE_D1(DICT: [String: Any]) -> [EXPENESE_D1] {
        
        var OBJ_EXPENESE: [EXPENESE_D1] = []
        
        let AP_VALUE = Apartment.EXPENESE_D1()
        
        AP_VALUE.SET_APT_AMOUNT_COST(APT_AMOUNT_COST: DICT["apt_amount_cost"] as Any)
        AP_VALUE.SET_APT_HOUSE_CNT(APT_HOUSE_CNT: DICT["apt_house_cnt"] as Any)
        AP_VALUE.SET_DONG_AMOUNT_COST(DONG_AMOUNT_COST: DICT["dong_amount_cost"] as Any)
        AP_VALUE.SET_DONG_HOUSE_CNT(DONG_HOUSE_CNT: DICT["dong_house_cnt"] as Any)
        // 데이터 추가
        OBJ_EXPENESE.append(AP_VALUE)
        
        return OBJ_EXPENESE
    }
    
    func GET_EXPENESE_D2(ARRAY: [Any]) -> [EXPENESE_D2] {
        
        var OBJ_EXPENESE: [EXPENESE_D2] = []
        
        for (_, DATA) in ARRAY.enumerated() {
            
            let DICT = DATA as? [String: Any]
            let AP_VALUE = Apartment.EXPENESE_D2()
            
            AP_VALUE.SET_BILL_COST(BILL_COST: DICT?["bill_cost"] as Any)
            AP_VALUE.SET_BILL_NAME(BILL_NAME: DICT?["bill_name"] as Any)
            AP_VALUE.SET_TARGET_MONTH(TARGET_MONTH: DICT?["target_month"] as Any)
            // 데이터 추가
            OBJ_EXPENESE.append(AP_VALUE)
        }
        
        return OBJ_EXPENESE
    }
}
