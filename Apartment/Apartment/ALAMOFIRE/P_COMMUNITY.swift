//
//  P_COMMUNITY.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/16.
//

import UIKit
import Alamofire

/// 그룹설정(목록)
extension VC_COMMUNITY {
    
    func GET_COMMNUNITY_L(NAME: String, AC_TYPE: String, LM_START: Int) {
        
        OBJ_COMMUNITY_L1.removeAll(); if LM_START == 0 { OBJ_COMMUNITY_L2.removeAll(); self.TABLEVIEW.reloadData(); NODATA(RECT: view, MESSAGE: "데이터 없음") }; if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? "",
            "limit_start": LM_START
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/circle/circle.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    let ARRAY1 = DICT["SignList"] as? Array<Any> ?? []
                    let ARRAY2 = DICT["NoSignList"] as? Array<Any> ?? []
                    
                    for (I, DATA) in (ARRAY1+ARRAY2).enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.COMMUNITY()
                        
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                        AP_VALUE.SET_BK_NAME(BK_NAME: DICT?["bk_name"] as Any)
                        AP_VALUE.SET_BK_NICK(BK_NICK: DICT?["bk_nick"] as Any)
                        AP_VALUE.SET_BUILDING_ID(BUILDING_ID: DICT?["building_id"] as Any)
                        AP_VALUE.SET_CC_CODE(CC_CODE: DICT?["cc_code"] as Any)
                        AP_VALUE.SET_CC_COUNT_IN(CC_COUNT_IN: DICT?["cc_count_in"] as Any)
                        AP_VALUE.SET_CC_EXPLAIN(CC_EXPLAIN: DICT?["cc_explain"] as Any)
                        AP_VALUE.SET_CC_IMG(CC_IMG: DICT?["cc_img"] as Any)
                        AP_VALUE.SET_CC_NAME(CC_NAME: DICT?["cc_name"] as Any)
                        AP_VALUE.SET_CC_STATUS(CC_STATUS: DICT?["cc_status"] as Any)
                        AP_VALUE.SET_DATETIME(DATETIME: DICT?["datetime"] as Any)
                        AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT?["home_code"] as Any)
                        AP_VALUE.SET_HOUSE_NUMBER(HOUSE_NUMBER: DICT?["house_number"] as Any)
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_MB_ID(MB_ID: DICT?["mb_id"] as Any)
                        // 데이터 추가
                        if I < ARRAY1.count { AP_VALUE.SET_JOIN(JOIN: true)
                            self.OBJ_COMMUNITY_L1.append(AP_VALUE)
                        } else if I < ARRAY1.count+ARRAY2.count { AP_VALUE.SET_JOIN(JOIN: false)
                            self.OBJ_COMMUNITY_L2.append(AP_VALUE)
                        }
                    }
                } else if self.OBJ_COMMUNITY_L2.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            self.FETCHING_MORE = false
            if self.OBJ_COMMUNITY_L1.count > 0 || self.OBJ_COMMUNITY_L2.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            self.TABLEVIEW.reloadData()
        }
    }
}

extension UIViewController {
    
    func PUT_COMMUNITY(NAME: String, AC_TYPE: String, CC_CODE: String, CC_NAME: String, POSITION: Int) {
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "building_id": UserDefaults.standard.string(forKey: "building_id") ?? "",
            "house_number": UserDefaults.standard.string(forKey: "house_number") ?? "",
            "cc_code": CC_CODE,
            "cc_name": CC_NAME,
            "bk_name": UserDefaults.standard.string(forKey: "bk_nick") ?? "",
            "bk_nick": UserDefaults.standard.string(forKey: "bk_nick") ?? ""
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/circle/circle.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    if DICT["result"] as? String ?? "fail" == "success" {
                        if let DEL1 = UIViewController.APPDELEGATE.VC_COMMUNITY_DEL {
//                            if AC_TYPE == "register" {
//                                if DEL1.OBJ_COMMUNITY_L2.count > 0 { DEL1.OBJ_COMMUNITY_L2[POSITION].JOIN = true }
//                            }; DEL1.TABLEVIEW.reloadData()
                            DEL1.GET_COMMNUNITY_L(NAME: "그룹설정(목록)", AC_TYPE: "list", LM_START: 0)
                        }
                        if let DEL2 = UIViewController.APPDELEGATE.VC_COMMUNITY_1_DEL {
                            if AC_TYPE == "register" {
                                if DEL2.OBJ_COMMUNITY.count > 0 { DEL2.OBJ_COMMUNITY[POSITION].JOIN = true }
                            } else if AC_TYPE == "out" {
                                if DEL2.OBJ_COMMUNITY.count > 0 { DEL2.OBJ_COMMUNITY[POSITION].JOIN = false }
                            }; DEL2.TABLEVIEW.reloadData()
                        }
                    } else {
                        self.S_NOTICE(":( 그룹탈퇴를 할 수 없습니다")
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
        }
    }
}
