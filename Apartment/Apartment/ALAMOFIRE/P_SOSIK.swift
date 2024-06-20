//
//  P_SOSIK.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/08.
//

import UIKit
import Alamofire

/// 소식(목록)
extension VC_SOSIK {
    
    func GET_SOSIK_L2(NAME: String, AC_TYPE: String, LM_START: Int, MONTH: String) {
        
        if LM_START == 0 { OBJ_SOSIK.removeAll(); OBJ_CALENDAR.removeAll(); UIView.performWithoutAnimation { if !self.MENU.contains("일정") { self.TABLEVIEW.reloadSections(IndexSet(integer: 3), with: .none) } else { self.TABLEVIEW.reloadData() } }; if !self.MENU.contains("일정") { NODATA(RECT: view, MESSAGE: "데이터 없음") } }; if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        var P_URL2: String = ""
        var PARAMETERS: Parameters = [
            "board_type": BD_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? "",
            "building_id": UserDefaults.standard.string(forKey: "building_id") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "limit_start": LM_START
        ]
        
        if MENU.contains("일정") { PARAMETERS["target_month"] = MONTH }
        if MENU == "커뮤니티" { PARAMETERS["cc_code"] = UserDefaults.standard.string(forKey: "cc_code") ?? "" }
        if MENU == "나의게시글" { PARAMETERS["sender_id"] = UserDefaults.standard.string(forKey: "mb_id") ?? "" }
        if MENU != "민원·수리·신고" { P_URL2 = "/article/article.php"; PARAMETERS["action_type"] = "LIST" } else { P_URL2 = "/addon/fix_request.php"; PARAMETERS["action_type"] = "list" }
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+P_URL2, method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        let AP_VALUE = Apartment.SOSIK_L2()
                        
                        AP_VALUE.SET_MEDIA_CONTENT(MEDIA_CONTENT: self.GET_SOSIK_D2(ARRAY: DICT?["media_content"] as? [Any] ?? []))
                        AP_VALUE.SET_AP_COMMENT(AP_COMMENT: DICT?["ap_comment"] as Any)
                        AP_VALUE.SET_AP_CONTENT_TEXT(AP_CONTENT_TEXT: DICT?["ap_content_text"] as Any)
                        AP_VALUE.SET_AP_LIKE(AP_LIKE: DICT?["ap_like"] as Any)
                        AP_VALUE.SET_AP_MSG_GROUP(AP_MSG_GROUP: DICT?["ap_msg_group"] as Any)
                        AP_VALUE.SET_AP_REQUEST_TIME(AP_REQUEST_TIME: DICT?["ap_request_time"] as Any)
                        AP_VALUE.SET_AP_SEQ(AP_SEQ: DICT?["ap_seq"] as Any)
                        AP_VALUE.SET_AP_SUBJECT(AP_SUBJECT: DICT?["ap_subject"] as Any)
                        AP_VALUE.SET_AP_SUBJECT_TEXT(AP_SUBJECT_TEXT: DICT?["ap_subject_text"] as Any)
                        AP_VALUE.SET_BADGE_COLOR(BADGE_COLOR: DICT?["badge_color"] as Any)
                        AP_VALUE.SET_BOARD_NAME(BOARD_NAME: DICT?["board_name"] as Any)
                        AP_VALUE.SET_BOARD_TYPE(BOARD_TYPE: DICT?["board_type"] as Any)
                        AP_VALUE.SET_CC_CODE(CC_CODE: DICT?["cc_code"] as Any)
                        AP_VALUE.SET_CC_NAME(CC_NAME: DICT?["cc_name"] as Any)
                        AP_VALUE.SET_COMMENT_CNT(COMMENT_CNT: DICT?["comment_cnt"] as Any)
                        AP_VALUE.SET_LOGO_URL(LOGO_URL: DICT?["logo_url"] as Any)
                        AP_VALUE.SET_READ_CNT(READ_CNT: DICT?["read_cnt"] as Any)
                        AP_VALUE.SET_SENDER_NICK(SENDER_NICK: DICT?["sender_nick"] as Any)
                        
                        AP_VALUE.SET_AP_CODE(AP_CODE: DICT?["ap_code"] as Any)
                        AP_VALUE.SET_BK_NAME(BK_NAME: DICT?["bk_name"] as Any)
                        AP_VALUE.SET_BK_NICK(BK_NICK: DICT?["bk_nick"] as Any)
                        AP_VALUE.SET_BUILDING_ID(BUILDING_ID: DICT?["building_id"] as Any)
                        AP_VALUE.SET_CONTENT(CONTENT: DICT?["content"] as Any)
                        AP_VALUE.SET_HOME_CODE(HOME_CODE: DICT?["home_code"] as Any)
                        AP_VALUE.SET_HOUSE_NUMBER(HOUSE_NUMBER: DICT?["house_number"] as Any)
                        AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
                        AP_VALUE.SET_MB_ID(MB_ID: DICT?["mb_id"] as Any)
                        AP_VALUE.SET_ON_QUE(ON_QUE: DICT?["on_que"] as Any)
                        AP_VALUE.SET_ORG_IDX(ORG_IDX: DICT?["org_idx"] as Any)
                        AP_VALUE.SET_REQUEST_TIME(REQUEST_TIME: DICT?["request_time"] as Any)
                        AP_VALUE.SET_REQUEST_TYPE(REQUEST_TYPE: DICT?["request_type"] as Any)
                        AP_VALUE.SET_RESULT_BG_NAME(RESULT_BG_NAME: DICT?["result_bg_name"] as Any)
                        AP_VALUE.SET_RESULT_BG_NO(RESULT_BG_NO: DICT?["result_bg_no"] as Any)
                        AP_VALUE.SET_RESULT_CONTENT(RESULT_CONTENT: DICT?["result_content"] as Any)
                        AP_VALUE.SET_RESULT_MB_ID(RESULT_MB_ID: DICT?["result_mb_id"] as Any)
                        AP_VALUE.SET_RESULT_SUBJECT(RESULT_SUBJECT: DICT?["result_subject"] as Any)
                        AP_VALUE.SET_SUBJECT(SUBJECT: DICT?["subject"] as Any)
                        // 데이터 추가
                        self.OBJ_SOSIK.append(AP_VALUE); self.OBJ_CALENDAR.append(AP_VALUE)
                    }
                } else if self.OBJ_SOSIK.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            self.FETCHING_MORE = false; if self.OBJ_SOSIK.count > 0 { UIViewController.NODATA_L.removeFromSuperview() }
            UIView.performWithoutAnimation {
                if !self.MENU.contains("일정") { self.TABLEVIEW.reloadSections(IndexSet(integer: 3), with: .none) } else { self.OBJ_CALENDAR.reverse(); self.TABLEVIEW.reloadData() }
            }
        }
    }
    
    func GET_SOSIK_D2(ARRAY: [Any]) -> [SOSIK_D] {
        
        var OBJ_SOSIK: [SOSIK_D] = []
        
        for (_, DATA) in ARRAY.enumerated() {
            
            let DICT = DATA as? [String: Any]
            let AP_VALUE = Apartment.SOSIK_D()
            
            AP_VALUE.SET_AP_MSG_GROUP(AP_MSG_GROUP: DICT?["ap_msg_group"] as Any)
            AP_VALUE.SET_MEDIA_NAME(MEDIA_NAME: DICT?["media_name"] as Any)
            AP_VALUE.SET_MEDIA_THUMBS(MEDIA_THUMBS: DICT?["media_thumbs"] as Any)
            AP_VALUE.SET_MEDIA_TYPE(MEDIA_TYPE: DICT?["media_type"] as Any)
            AP_VALUE.SET_MEDIA_URL(MEDIA_URL: DICT?["media_url"] as Any)
            // 데이터 추가
            OBJ_SOSIK.append(AP_VALUE)
        }
        
        return OBJ_SOSIK
    }
}
