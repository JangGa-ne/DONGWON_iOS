//
//  P_SOSIK_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/11.
//

import UIKit
import Alamofire

/// 소식(디테일)
extension VC_SOSIK_1 {
    
    func GET_SOSIK_D1(NAME: String, AC_TYPE: String, BD_TYPE: String) {
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "board_type": BD_TYPE,
            "ap_seq": AP_SEQ,
            "ap_msg_group": AP_MSG_GROUP
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/article/article_detail.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let ARRAY = response.result.value as? Array<Any> {
                    
                    for (_, DATA) in ARRAY.enumerated() {
                        
                        let DICT = DATA as? [String: Any]
                        
                        self.GET_SOSIK_DL(ARRAY: DICT?["article"] as? [Any] ?? [])
                        self.GET_SOSIK_D(ARRAY: DICT?["media_content"] as? [Any] ?? [])
                        self.GET_COMMENT(ARRAY: DICT?["comment"] as? [Any] ?? [])
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
            
            self.TABLEVIEW.reloadData()
        }
    }
    
    func GET_SOSIK_DL(ARRAY: [Any]) {
        
        for (_, DATA) in ARRAY.enumerated() {
            
            let DICT = DATA as? [String: Any]
            let AP_VALUE = Apartment.SOSIK_DL()
            
            if DICT?["ap_seq"] as? String ?? "" == "" && DICT?["ap_msg_group"] as? String ?? "" == "" {
                
                let ALERT = UIAlertController(title: "", message: ":( 내용이 삭제되었거나,\n관리자에 의해 확인할 수 없는 소식입니다.", preferredStyle: .alert)
                ALERT.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(ALERT, animated: true, completion: nil)
            }
            
            AP_VALUE.SET_AP_COMMENT(AP_COMMENT: DICT?["ap_comment"] as Any)
            AP_VALUE.SET_AP_CONTENT(AP_CONTENT: DICT?["ap_content"] as Any)
            AP_VALUE.SET_AP_CONTENT_TEXT(AP_CONTENT_TEXT: DICT?["ap_content_text"] as Any)
            AP_VALUE.SET_AP_CONTENT_TEXT_2(AP_CONTENT_TEXT_2: DICT?["ap_content_text2"] as Any)
            AP_VALUE.SET_AP_LIKE(AP_LIKE: DICT?["ap_like"] as Any)
            AP_VALUE.SET_AP_MSG_GROUP(AP_MSG_GROUP: DICT?["ap_msg_group"] as Any)
            AP_VALUE.SET_AP_REQUEST_TIME(AP_REQUEST_TIME: DICT?["ap_request_time"] as Any)
            AP_VALUE.SET_AP_SEQ(AP_SEQ: DICT?["ap_seq"] as Any)
            AP_VALUE.SET_AP_SUBJECT(AP_SUBJECT: DICT?["ap_subject"] as Any)
            AP_VALUE.SET_AP_SUBJECT_TEXT(AP_SUBJECT_TEXT: DICT?["ap_subject_text"] as Any)
            AP_VALUE.SET_ARTICLE_TYPE(ARTICLE_TYPE: DICT?["article_type"] as Any)
            AP_VALUE.SET_BADGE_COLOR(BADGE_COLOR: DICT?["badge_color"] as Any)
            AP_VALUE.SET_BOARD_NAME(BOARD_NAME: DICT?["board_name"] as Any)
            AP_VALUE.SET_BOARD_TYPE(BOARD_TYPE: DICT?["board_type"] as Any)
            AP_VALUE.SET_CC_NAME(CC_NAME: DICT?["cc_name"] as Any)
            AP_VALUE.SET_LOGO_URL(LOGO_URL: DICT?["logo_url"] as Any)
            AP_VALUE.SET_SENDER_NICK(SENDER_NICK: DICT?["sender_nick"] as Any)
            // 데이터 추가
            OBJ_SOSIK.append(AP_VALUE)
        }
    }
    
    func GET_SOSIK_D(ARRAY: [Any]) {
        
        for (_, DATA) in ARRAY.enumerated() {
            
            let DICT = DATA as? [String: Any]
            let AP_VALUE = Apartment.SOSIK_D()
            
            AP_VALUE.SET_AP_MSG_GROUP(AP_MSG_GROUP: DICT?["ap_msg_group"] as Any)
            AP_VALUE.SET_MEDIA_NAME(MEDIA_NAME: DICT?["media_name"] as Any)
            AP_VALUE.SET_MEDIA_THUMBS(MEDIA_THUMBS: DICT?["media_thumbs"] as Any)
            AP_VALUE.SET_MEDIA_TYPE(MEDIA_TYPE: DICT?["media_type"] as Any)
            AP_VALUE.SET_MEDIA_URL(MEDIA_URL: DICT?["media_url"] as Any)
            // 데이터 추가
            let MEDIA_TYPE = DICT?["media_type"] as? String ?? ""
            if !(MEDIA_TYPE == "F" || MEDIA_TYPE == "f") { OBJ_MEDIA.append(AP_VALUE) } else { OBJ_FILE.append(AP_VALUE) }
        }
    }
    
    func GET_COMMENT(ARRAY: [Any]) {
        
        for (_, DATA) in ARRAY.enumerated() {
            
            let DICT = DATA as? [String: Any]
            let AP_VALUE = Apartment.COMMENT_L()
            
            AP_VALUE.SET_CO_DEPTH(CO_DEPTH: DICT?["co_depth"] as Any)
            AP_VALUE.SET_COMMENT(COMMENT: DICT?["comment"] as Any)
            AP_VALUE.SET_IDX(IDX: DICT?["idx"] as Any)
            AP_VALUE.SET_BK_NICK(BK_NICK: DICT?["bk_nick"] as Any)
            AP_VALUE.SET_REG_DATE(REG_DATE: DICT?["reg_date"] as Any)
            AP_VALUE.SET_UPPER_IDX(UPPER_IDX: DICT?["upper_idx"] as Any)
            // 데이터 추가
            OBJ_COMMENT.append(AP_VALUE)
        }
    }
    
    func PUT_COMMENT(NAME: String, AC_TYPE: String) {
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "bk_nick": UserDefaults.standard.string(forKey: "bk_nick") ?? "",
            "ap_msg_group": AP_MSG_GROUP,
            "co_depth": "1",  // 1: 댓글, 2: 댓글의댓글
            "upper_idx": "0", // 2: 댓글의댓글에만 사용
            "comment": COMMENT_TF.text!
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/article/comment.php", method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    if DICT["result"] as? String ?? "fail" == "success" {
                        
                        if let BVC = UIViewController.APPDELEGATE.VC_SOSIK_DEL {
                            BVC.OBJ_SOSIK[self.POSITION].COMMENT_CNT += 1; BVC.TABLEVIEW.reloadRows(at: [IndexPath(item: self.POSITION, section: 3)], with: .fade)
                        }
                        
                        let AP_VALUE = Apartment.COMMENT_L()
                        
                        AP_VALUE.SET_COMMENT(COMMENT: self.COMMENT_TF.text!)
                        AP_VALUE.SET_BK_NICK(BK_NICK: UserDefaults.standard.string(forKey: "bk_nick") ?? "")
                        AP_VALUE.SET_REG_DATE(REG_DATE: "\(Date())")
                        // 데이터 추가
                        self.OBJ_COMMENT.insert(AP_VALUE, at: 0)
                        
                        self.COMMENT_TF.text?.removeAll(); self.COMMENT_B.isHidden = true
                        self.TABLEVIEW.reloadData(); self.TABLEVIEW.scrollToRow(at: IndexPath(row: 0, section: 4), at: .bottom, animated: true)
                    } else {
                        self.S_NOTICE(":( 댓글 업로드 실패")
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
        }
    }
}
