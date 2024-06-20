//
//  P_COMMUNITY_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/17.
//

import UIKit
import Alamofire

/// 그룹설정(디테일)
extension VC_COMMUNITY_1 {
    
    func GET_SOSIK_L2(NAME: String, AC_TYPE: String, LM_START: Int) {
        
        if LM_START == 0 { OBJ_SOSIK.removeAll(); UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) } }; if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "board_type": "C",
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "building_id": UserDefaults.standard.string(forKey: "building_id") ?? "",
            "cc_code": OBJ_COMMUNITY[POSITION].CC_CODE,
            "limit_start": LM_START
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/article/article.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
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
                        // 데이터 추가
                        self.OBJ_SOSIK.append(AP_VALUE)
                    }
                } else if self.OBJ_SOSIK.count > 0 {
                    self.ALERT(TITLE: nil, BODY: (":( 더이상 불러올 데이터가 없습니다"), STYLE: .actionSheet)
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            self.FETCHING_MORE = false
            UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
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
