//
//  P_RESTAURANT.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/27.
//

import UIKit
import Alamofire

extension VC_RESTAURANT {
    
    func GET_RESTAURANT_L(NAME: String, AC_TYPE: String) {
        
        // 데이터 삭제
        OBJ_RESTAURANT.removeAll(); COLLECTIONVIEW.reloadData()
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? "",
            "display": "S"
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/store/category.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    if let ARRAY = DICT["category"] as? Array<Any> {
                        
                        for (_, DATA) in ARRAY.enumerated() {
                            
                            let DICT = DATA as? [String: Any]
                            let AP_VALUE = Apartment.RESTAURANT_C()
                            
                            AP_VALUE.SET_CATE_CODE(CATE_CODE: DICT?["cate_code"] as Any)
                            AP_VALUE.SET_CATE_DEPATH(CATE_DEPATH: DICT?["cate_depath"] as Any)
                            AP_VALUE.SET_CATE_EXPLAIN(CATE_EXPLAIN: DICT?["cate_explain"] as Any)
                            AP_VALUE.SET_CATE_NAME(CATE_NAME: DICT?["cate_name"] as Any)
                            AP_VALUE.SET_CATE_ICON(CATE_ICON: DICT?["cate_icon"] as Any)
                            AP_VALUE.SET_DISPLAY(DISPLAY: DICT?["display"] as Any)
                            AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                            AP_VALUE.SET_UPPER_CATE(UPPER_CATE: DICT?["upper_cate"] as Any)
                            // 데이터 추가
                            self.OBJ_RESTAURANT.append(AP_VALUE)
                        }
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            if self.OBJ_RESTAURANT.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.COLLECTIONVIEW.reloadData()
        }
    }
}
