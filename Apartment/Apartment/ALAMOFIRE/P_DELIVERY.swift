//
//  P_DELIVERY.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/29.
//

import UIKit
import Alamofire

/// 배송조회(목록)
extension VC_DELIVERY {
    
    /// 배송조회
    func GET_DELIVERY_L1(NAME: String, AC_TYPE: String, LM_START: Int) {
        
        if LM_START == 0 { OBJ_DELIVERY.removeAll(); TABLEVIEW.reloadData(); NODATA(RECT: view, MESSAGE: "데이터 없음") }; if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "limit_start": LM_START
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/parcel.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.DELIVERY_L1()
                        
                        if DICT?["invoiceNo"] as? String ?? "" != "" {
                            
                            AP_VALUE.SET_AUTO_DATETIME(AUTO_DATETIME: DICT?["auto_datetime"] as Any)
                            AP_VALUE.SET_COMPANY_CODE(COMPANY_CODE: DICT?["company_code"] as Any)
                            AP_VALUE.SET_COMPANY_NAME(COMPANY_NAME: DICT?["company_name"] as Any)
                            AP_VALUE.SET_COMPANY_PHONE(COMPANY_PHONE: DICT?["company_phone"] as Any)
                            AP_VALUE.SET_COMPLETE_YN(COMPLETE_YN: DICT?["completeYN"] as Any)
                            AP_VALUE.SET_DETAIL(DETAIL: DICT?["detail"] as Any)
                            AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT?["home_code"] as Any)
                            AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                            AP_VALUE.SET_IN_VOICE_NO(IN_VOICE_NO: DICT?["invoiceNo"] as Any)
                            AP_VALUE.SET_ITEM_IMAGE(ITEM_IMAGE: DICT?["itemImage"] as Any)
                            AP_VALUE.SET_ITEM_NAME(ITEM_NAME: DICT?["itemName"] as Any)
                            AP_VALUE.SET_MB_ID(MB_ID: DICT?["mb_id"] as Any)
                            AP_VALUE.SET_PAR_DETAIL(PAR_DETAIL: self.GET_DELIVERY_D1(ARRAY: DICT?["par_detail"] as? [Any] ?? []))
                            AP_VALUE.SET_RECEIVER_ADDR(RECEIVER_ADDR: DICT?["receiverAddr"] as Any)
                            AP_VALUE.SET_RECEIVER_NAME(RECEIVER_NAME: DICT?["receiverName"] as Any)
                            AP_VALUE.SET_RECIPIENT(RECIPIENT: DICT?["recipient"] as Any)
                            AP_VALUE.SET_REG_DATE(REG_DATE: DICT?["reg_date"] as Any)
                            AP_VALUE.SET_RELOAD(RELOAD: DICT?["reload"] as Any)
                            AP_VALUE.SET_SENDER_NAME(SENDER_NAME: DICT?["senderName"] as Any)
                            AP_VALUE.SET_TOTAL_LEVEL(TOTAL_LEVEL: DICT?["total_level"] as Any)
                            // 데이터 추가
                            self.OBJ_DELIVERY.append(AP_VALUE)
                        }
                    }
                } else if self.OBJ_DELIVERY.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            self.FETCHING_MORE = false
            if self.OBJ_DELIVERY.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.TABLEVIEW.reloadData()
        }
    }
    
    func GET_DELIVERY_D1(ARRAY: [Any]) -> [DELIVERY_D1] {
        
        var OBJ_DELIVERY: [DELIVERY_D1] = []
        
        for (_, DATA) in ARRAY.enumerated() {
            
            let DICT = DATA as? [String: Any]
            let AP_VALUE = Apartment.DELIVERY_D1()
            
            AP_VALUE.SET_COMPLETE_YN(COMPLETE_YN: DICT?["completeYN"] as Any)
            AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
            AP_VALUE.SET_IN_VOICE_NO(IN_VOICE_NO: DICT?["invoiceNo"] as Any)
            AP_VALUE.SET_KIND(KIND: DICT?["kind"] as Any)
            AP_VALUE.SET_LEVEL(LEVEL: DICT?["level"] as Any)
            AP_VALUE.SET_MAN_NAME(MAN_NAME: DICT?["manName"] as Any)
            AP_VALUE.SET_MAN_PIC(MAN_PIC: DICT?["manPic"] as Any)
            AP_VALUE.SET_TEL_NO1(TEL_NO1: DICT?["telno"] as Any)
            AP_VALUE.SET_TEL_NO2(TEL_NO2: DICT?["telno2"] as Any)
            AP_VALUE.SET_TIME_STRING(TIME_STRING: DICT?["timeString"] as Any)
            AP_VALUE.SET_WHERE_NOW(WHERE_NOW: DICT?["where_now"] as Any)
            // 데이터 추가
            OBJ_DELIVERY.append(AP_VALUE)
        }
        
        return OBJ_DELIVERY
    }
}

