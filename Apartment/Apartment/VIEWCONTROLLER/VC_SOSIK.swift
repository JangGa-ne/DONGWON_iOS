//
//  VC_SOSIK.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/08.
//

import UIKit
import CVCalendar

/// 소식(목록)
class VC_SOSIK: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var AC_TYPE: String = ""
    var BD_TYPE: String = ""
    
    let MENU: String = UIViewController.APPDELEGATE.MENU
    var OBJ_SOSIK: [SOSIK_L2] = []
    var OBJ_CALENDAR: [SOSIK_L2] = []
    
    var FETCHING_MORE: Bool = false
    var PAGE_NUMBER: Int = 0
    var ITEM_COUNT: Int = 20
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var DETAIL_B: UIButton!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.VC_SOSIK_DEL = self
        
        if MENU == "마을일정" { NAVI_L.text = MENU; BD_TYPE = "LS"; DETAIL_B.isHidden = true }
        if MENU == "투표" { NAVI_L.text = MENU; BD_TYPE = "SV"; DETAIL_B.isHidden = true }
        if MENU == "마을소식" { NAVI_L.text = MENU; BD_TYPE = "LN"; DETAIL_B.isHidden = true }
        if MENU == "학교소식" { NAVI_L.text = MENU; BD_TYPE = "SC"; DETAIL_B.isHidden = false; DETAIL_B.setTitle("학교설정", for: .normal); DETAIL_B.tag = 0 }
        if MENU == "민원·수리·신고" { NAVI_L.text = MENU; BD_TYPE = ""; DETAIL_B.isHidden = false; DETAIL_B.setTitle("작성하기", for: .normal); DETAIL_B.tag = 1 }
        if MENU == "아파트알림장" { NAVI_L.text = MENU; BD_TYPE = "N"; DETAIL_B.isHidden = true }
        if MENU == "커뮤니티" { NAVI_L.text = MENU; BD_TYPE = "C"; DETAIL_B.isHidden = false; DETAIL_B.setTitle("그룹설정", for: .normal); DETAIL_B.tag = 2 }
        if MENU == "우리마을전단지" { NAVI_L.text = MENU; BD_TYPE = "AD"; DETAIL_B.isHidden = true }
        if MENU == "아파트일정" { NAVI_L.text = MENU; BD_TYPE = "S"; DETAIL_B.isHidden = true }
        if MENU == "나의게시글" { NAVI_L.text = MENU; BD_TYPE = "MY"; DETAIL_B.isHidden = true }
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DETAIL_B.addTarget(self, action: #selector(DETAIL_B(_:)), for: .touchUpInside)
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        if MENU != "커뮤니티" { GET_SOSIK_L2(NAME: "\(NAVI_L.text!)(목록)", AC_TYPE: "", LM_START: 0, MONTH: "") }
    }
    
    @objc func DETAIL_B(_ sender: UIButton) {
        if sender.tag == 0 {
            
        } else if sender.tag == 1 {
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_WRITE") as! VC_WRITE
            VC.BD_TYPE = "F"; VC.BD_NAME = "하자"
            navigationController?.pushViewController(VC, animated: true)
        } else if sender.tag == 2 {
            PRESENT_VC(IDENTIFIER: "VC_COMMUNITY", ANIMATED: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true); if MENU == "커뮤니티" && OBJ_SOSIK.count == 0 { GET_SOSIK_L2(NAME: "\(NAVI_L.text!)(목록)", AC_TYPE: "", LM_START: 0, MONTH: "") }
    }
}

extension VC_SOSIK: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 0 //if BD_TYPE == "N" { return 1 } else { return 0 }
        } else if section == 2 {
            if BD_TYPE == "N" || BD_TYPE == "MY" { return 1 } else { return 0 }
        } else if section == 3 {
            if !MENU.contains("일정") && OBJ_SOSIK.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_SOSIK.count } else { return 0 }
        } else if section == 4 {
            if MENU.contains("일정") { return 1 } else { return 0 }
        } else {
            if MENU.contains("일정") && OBJ_CALENDAR.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_CALENDAR.count } else { return 0 }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30); CELL.TITLE_L.text = NAVI_L.text!
            return CELL
        } else if indexPath.section == 1 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC1", for: indexPath) as! VC_SOSIK_TC
            CELL.TITLE_L.text = "전체보기"
            return CELL
        } else if indexPath.section == 2 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC2", for: indexPath) as! VC_SOSIK_TC
            
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
            
            for (_, DATA) in UIViewController.APPDELEGATE.OBJ_LOGIN.enumerated() {
                SDWEBIMAGE(IV: CELL.PROFILE_I, IU: DATA.MB_PHOTO, PH: UIImage(named: "profile.png"), RD: CELL.PROFILE_I.frame.width/2, CM: .scaleAspectFill)
            }
            
            return CELL
        } else if indexPath.section == 3 {
            
            let DATA = OBJ_SOSIK[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC3", for: indexPath) as! VC_SOSIK_TC
            
            CELL.CUSTOM_V1.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
            
            if MENU != "민원·수리·신고" {
                
                var MEDIA: [String] = []; var FILE: [String] = []
                if DATA.MEDIA_CONTENT.count > 0 {
                    for DATA in DATA.MEDIA_CONTENT {
                        if !(DATA.MEDIA_TYPE == "F" || DATA.MEDIA_TYPE == "f") { MEDIA.append(DATA.MEDIA_TYPE) } else { FILE.append(DATA.MEDIA_TYPE) }
                    }
                }
                if MEDIA.count > 0 {
                    CELL.CUSTOM_V2.isHidden = false; CELL.LINE_V.isHidden = false
                    CELL.PROTOCOL = self; CELL.DETAIL = false; CELL.BD_TYPE = BD_TYPE; CELL.AP_SEQ = DATA.AP_SEQ; CELL.AP_MSG_GROUP = DATA.AP_MSG_GROUP
                    var OBJ_MEDIA: [SOSIK_D] = []; var OBJ_FILE: [SOSIK_D] = []
                    for (_, DATA2) in DATA.MEDIA_CONTENT.enumerated() {
                        if !(DATA2.MEDIA_TYPE == "F" || DATA2.MEDIA_TYPE == "f") { OBJ_MEDIA.append(DATA2) } else { OBJ_FILE.append(DATA2) }
                    }; CELL.OBJ_MEDIA = OBJ_MEDIA; CELL.OBJ_FILE = OBJ_FILE; CELL.viewDidLoad()
                    if MEDIA.count <= 1 { CELL.PAGE_L.isHidden = true } else { CELL.PAGE_L.isHidden = false; CELL.PAGE_L.text = "1/\(MEDIA.count)" }
                } else {
                    CELL.CUSTOM_V2.isHidden = true; CELL.LINE_V.isHidden = true
                }
                
                if (MENU != "커뮤니티" && DATA.BOARD_NAME == "") || (MENU == "커뮤니티" && DATA.CC_NAME == "") { CELL.TYPE_L.isHidden = true } else { CELL.TYPE_L.isHidden = false }
                CELL.TYPE_L.layer.cornerRadius = 10; CELL.TYPE_L.clipsToBounds = true
                CELL.TYPE_L.backgroundColor = UIColor(hex: DATA.BADGE_COLOR, alpha: 0.3); CELL.TYPE_L.textColor = UIColor(hex: DATA.BADGE_COLOR, alpha: 1.0)
                if MENU != "커뮤니티" { CELL.TYPE_L.text = DT_CHECK(DATA.BOARD_NAME.replacingOccurrences(of: " ", with: "")) } else { CELL.TYPE_L.text = DT_CHECK(DATA.CC_NAME) }
                CELL.TYPE_L_WIDTH.constant = CGFloat(CELL.TYPE_L.text!.count*10+10)
                if DATA.SENDER_NICK != "" {
                    CELL.NAME_L.text = "\(DATA.SENDER_NICK) · \(FM_CUSTOM(DATA.AP_REQUEST_TIME, "yy/MM/dd HH:mm"))"
                } else {
                    CELL.NAME_L.text = FM_CUSTOM(DATA.AP_REQUEST_TIME, "yy/MM/dd HH:mm")
                }
                CELL.COUNT_L.isHidden = false; CELL.COUNT_L.text = "조회 : \(DATA.READ_CNT) / 댓글 : \(DATA.COMMENT_CNT)"
                
                CELL.SUBJECT_L.text = DT_CHECK(ENCODE(DATA.AP_SUBJECT_TEXT))
                CELL.CONTENTS_L.text = DT_CHECK(ENCODE(DATA.AP_CONTENT_TEXT))
            } else {
                
                CELL.CUSTOM_V2.isHidden = true; CELL.LINE_V.isHidden = true
                
                CELL.TYPE_L.layer.cornerRadius = 10; CELL.TYPE_L.clipsToBounds = true
                if DATA.REQUEST_TYPE == "A" {
                    CELL.TYPE_L.backgroundColor = .H_FFAC0F.withAlphaComponent(0.3)
                    CELL.TYPE_L.textColor = .H_FFAC0F; CELL.TYPE_L.text = "민원"
                } else if DATA.REQUEST_TYPE == "F" {
                    CELL.TYPE_L.backgroundColor = .H_61C0A7.withAlphaComponent(0.3)
                    CELL.TYPE_L.textColor = .H_61C0A7; CELL.TYPE_L.text = "하자"
                }
                CELL.TYPE_L_WIDTH.constant = CGFloat(CELL.TYPE_L.text!.count*10+10)
                if DATA.BK_NICK != "" {
                    CELL.NAME_L.text = "\(DATA.BK_NICK) · \(FM_CUSTOM(DATA.REQUEST_TIME, "yy/MM/dd HH:mm"))"
                } else {
                    CELL.NAME_L.text = FM_CUSTOM(DATA.REQUEST_TIME, "yy/MM/dd HH:mm")
                }
                CELL.COUNT_L.isHidden = true
                
                CELL.SUBJECT_L.text = DT_CHECK(DATA.SUBJECT)
                CELL.CONTENTS_L.text = DT_CHECK(ENCODE(DATA.CONTENT))
            }
            
            return CELL
        } else if indexPath.section == 4 {
                
            let CELL = tableView.dequeueReusableCell(withIdentifier: "S_CALENDAR", for: indexPath) as! S_CALENDAR
            
            CELL.PROTOCOL = self; CELL.OBJ_SOSIK = OBJ_SOSIK
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
            CELL.CALENDARVIEW.commitCalendarViewUpdate()
            CELL.CALENDARVIEW.delegate = CELL
            CELL.CALENDARVIEW.contentController.refreshPresentedMonth()
            
            return CELL
        } else {
            
            let DATA = OBJ_CALENDAR[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC4", for: indexPath) as! VC_SOSIK_TC
            
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
            CELL.DAYS_V.backgroundColor = FM_COLOR(DATA.AP_REQUEST_TIME)
            CELL.DATETIME_L.text = FM_CUSTOM(DATA.AP_REQUEST_TIME, "MM월dd일")
            CELL.SUBJECT_L.text = DT_CHECK(ENCODE(DATA.AP_SUBJECT_TEXT))
            CELL.CONTENTS_L.text = DT_CHECK(ENCODE(DATA.AP_CONTENT_TEXT))
            
            return CELL
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_WRITE") as! VC_WRITE
            VC.BD_TYPE = BD_TYPE; VC.BD_NAME = MENU
            navigationController?.pushViewController(VC, animated: true)
        } else if indexPath.section == 3 {
            
            let DATA = OBJ_SOSIK[indexPath.item]
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_SOSIK_1") as! VC_SOSIK_1
            VC.BD_TYPE = BD_TYPE; VC.AP_SEQ = DATA.AP_SEQ; VC.AP_MSG_GROUP = DATA.AP_MSG_GROUP; VC.POSITION = indexPath.item
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}

extension VC_SOSIK: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let END_SCROLL = scrollView.contentOffset.y + scrollView.frame.size.height
        if !MENU.contains("일정") && OBJ_SOSIK.count > 3 && !FETCHING_MORE {
            if END_SCROLL >= scrollView.contentSize.height { FETCHING_MORE = true; PAGE_NUMBER = PAGE_NUMBER + 1
                GET_SOSIK_L2(NAME: "\(NAVI_L.text!)(목록)", AC_TYPE: "", LM_START: PAGE_NUMBER * ITEM_COUNT, MONTH: "")
            }
        }
    }
}

