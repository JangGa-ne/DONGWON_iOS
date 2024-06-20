//
//  P_DELIVERY_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/22.
//

import UIKit
import Alamofire

/// 배송조회(등록)
extension VC_DELIVERY_1 {
    
    func GET_DELIVERY_L2(NAME: String, AC_TYPE: String) {
        
        NODATA(RECT: COLLECTIONVIEW, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/parcel.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY1 = response.result.value as? Array<Any> {
                        
                    for (_, DATA) in ARRAY1.enumerated() {
                        
                        let ARRAY2 = DATA as? Array<Any> ?? []
                        
                        for (_, DATA) in ARRAY2.enumerated() {
                        
                            let DICT = DATA as? [String: Any]
                            let AP_VALUE = Apartment.DELIVERY_L2()
                            
                            AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                            AP_VALUE.SET_POST_COMPANY(POST_COMPANY: DICT?["post_company"] as Any)
                            AP_VALUE.SET_COMPANY_CODE(COMPANY_CODE: DICT?["company_code"] as Any)
                            AP_VALUE.SET_COMPANY_PHONE(COMPANY_PHONE: DICT?["company_phone"] as Any)
                            AP_VALUE.SET_PARSING_URL(PARSING_URL: DICT?["parsing_url"] as Any)
                            AP_VALUE.SET_PARSING_NAME(PARSING_NAME: DICT?["parsing_name"] as Any)
                            // 데이터 추가
                            self.OBJ_DELIVERY.append(AP_VALUE)
                        }
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_DELIVERY.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.COLLECTIONVIEW.reloadData()
        }
    }
    
    func PUT_DELIVERY(NAME: String, AC_TYPE: String) {
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "company_code": OBJ_DELIVERY[POSITION].COMPANY_CODE,
            "post_company": OBJ_DELIVERY[POSITION].POST_COMPANY,
            "invoiceNo": NUMBER_TF.text!
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/addon/parcel.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    let RESULT = DICT["result"] as? String ?? "fail"
                    
                    if RESULT == "success" { self.S_NOTICE(":) 배송정보가 등록되었습니다")
                        if let BVC = UIViewController.APPDELEGATE.VC_DELIVERY_DEL {
                            BVC.GET_DELIVERY_L1(NAME: "배송조회(목록/디테일)", AC_TYPE: "process", LM_START: 0)
                        }; self.dismiss(animated: true, completion: nil)
                    } else if RESULT == "duplicate" {
                        self.S_NOTICE(":( 이미 등록된 배송정보 입니다")
                    } else {
                        self.S_NOTICE(":( 배송정보를 등록할 수 없습니다")
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
        }
    }
}
