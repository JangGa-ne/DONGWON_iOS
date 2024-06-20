//
//  VC_COMMUNITY_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/08.
//

import UIKit

class VC_COMMUNITY_1_TC: UITableViewCell {
    
    @IBOutlet weak var TITLE_L: UILabel!
    @IBOutlet weak var JOIN_B: UIButton!
    
    @IBOutlet weak var PROFILE_I: UIImageView!
    @IBOutlet weak var CUSTOM_V1: UIView!
}

/// 그룹설정(디테일)
class VC_COMMUNITY_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var OBJ_COMMUNITY: [COMMUNITY] = []
    var POSITION: Int = 0
    var OBJ_SOSIK: [SOSIK_L2] = []
    
    var FETCHING_MORE: Bool = false
    var PAGE_NUMBER: Int = 0
    var ITEM_COUNT: Int = 20
    
    @IBOutlet weak var BACKGROUND_I: UIImageView!
    @IBOutlet weak var BACKGROUND_I_HEIGHT: NSLayoutConstraint!
    @IBOutlet weak var NAVI_V: UIView!
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.VC_COMMUNITY_1_DEL = self
        
        BACKGROUND_I_HEIGHT.constant = UIViewController.STATUS_Y + 300
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.text = OBJ_COMMUNITY[POSITION].CC_NAME; NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SDWEBIMAGE(IV: BACKGROUND_I, IU: OBJ_COMMUNITY[POSITION].CC_IMG, PH: UIImage(named: "home_bg.png"), RD: 0, CM: .scaleAspectFill)
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_SOSIK_L2(NAME: "\(NAVI_L.text!)(목록)", AC_TYPE: "LIST", LM_START: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true); TABLEVIEW.reloadData()
    }
}

extension VC_COMMUNITY_1: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if OBJ_COMMUNITY[POSITION].JOIN { return 1 } else { return 0 }
        } else if OBJ_SOSIK.count > 0 {
            TABLEVIEW.isScrollEnabled = true; return OBJ_SOSIK.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_COMMUNITY_1_TC1", for: indexPath) as! VC_COMMUNITY_1_TC
            CELL.TITLE_L.titleFont(size: 20); CELL.TITLE_L.text = NAVI_L.text!
            if !(OBJ_COMMUNITY[POSITION].JOIN) {
                CELL.JOIN_B.backgroundColor = .H_2B3F6B; CELL.JOIN_B.setTitle("그룹 가입", for: .normal)
            } else {
                CELL.JOIN_B.backgroundColor = .systemRed; CELL.JOIN_B.setTitle("그룹 탈퇴", for: .normal)
            }
            CELL.JOIN_B.layer.cornerRadius = 5; CELL.JOIN_B.clipsToBounds = true
            CELL.JOIN_B.tag = POSITION; CELL.JOIN_B.addTarget(self, action: #selector(JOIN_B(_:)), for: .touchUpInside)
            return CELL
        } else if indexPath.section == 1 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_COMMUNITY_1_TC2", for: indexPath) as! VC_COMMUNITY_1_TC
            
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
            
            for (_, DATA) in UIViewController.APPDELEGATE.OBJ_LOGIN.enumerated() {
                SDWEBIMAGE(IV: CELL.PROFILE_I, IU: DATA.MB_PHOTO, PH: UIImage(named: "profile.png"), RD: CELL.PROFILE_I.frame.width/2, CM: .scaleAspectFill)
            }
            
            return CELL
        } else {
            
            let DATA = OBJ_SOSIK[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC", for: indexPath) as! VC_SOSIK_TC
            
            CELL.CUSTOM_V1.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
            
            var MEDIA: [String] = []; var FILE: [String] = []
            if DATA.MEDIA_CONTENT.count > 0 {
                for DATA in DATA.MEDIA_CONTENT {
                    if !(DATA.MEDIA_TYPE == "F" || DATA.MEDIA_TYPE == "f") { MEDIA.append(DATA.MEDIA_TYPE) } else { FILE.append(DATA.MEDIA_TYPE) }
                }
            }
            if MEDIA.count > 0 {
                CELL.CUSTOM_V2.isHidden = false; CELL.LINE_V.isHidden = false
                CELL.PROTOCOL = self; CELL.DETAIL = false; CELL.BD_TYPE = "C"; CELL.AP_SEQ = DATA.AP_SEQ; CELL.AP_MSG_GROUP = DATA.AP_MSG_GROUP
                var OBJ_MEDIA: [SOSIK_D] = []; var OBJ_FILE: [SOSIK_D] = []
                for (_, DATA2) in DATA.MEDIA_CONTENT.enumerated() {
                    if !(DATA2.MEDIA_TYPE == "F" || DATA2.MEDIA_TYPE == "f") { OBJ_MEDIA.append(DATA2) } else { OBJ_FILE.append(DATA2) }
                }; CELL.OBJ_MEDIA = OBJ_MEDIA; CELL.OBJ_FILE = OBJ_FILE ; CELL.viewDidLoad()
            } else {
                CELL.CUSTOM_V2.isHidden = true; CELL.LINE_V.isHidden = true
            }
            
            CELL.TYPE_L.isHidden = true
            CELL.TYPE_L.layer.cornerRadius = 10; CELL.TYPE_L.clipsToBounds = true
            CELL.TYPE_L.backgroundColor = UIColor(hex: DATA.BADGE_COLOR, alpha: 0.3); CELL.TYPE_L.textColor = UIColor(hex: DATA.BADGE_COLOR, alpha: 1.0)
            CELL.TYPE_L.text = DT_CHECK(DATA.CC_NAME.replacingOccurrences(of: " ", with: ""))
            CELL.TYPE_L_WIDTH.constant = CGFloat(CELL.TYPE_L.text!.count*10+10)
            if DATA.SENDER_NICK != "" {
                CELL.NAME_L.text = "\(DATA.SENDER_NICK) · \(FM_CUSTOM(DATA.AP_REQUEST_TIME, "yy/MM/dd HH:mm"))"
            } else {
                CELL.NAME_L.text = FM_CUSTOM(DATA.AP_REQUEST_TIME, "yy/MM/dd HH:mm")
            }
            CELL.COUNT_L.isHidden = false; CELL.COUNT_L.text = "조회 : \(DATA.READ_CNT) / 댓글 : \(DATA.COMMENT_CNT)"
            
            CELL.SUBJECT_L.text = DT_CHECK(ENCODE(DATA.AP_SUBJECT_TEXT))
            CELL.CONTENTS_L.text = DT_CHECK(ENCODE(DATA.AP_CONTENT_TEXT))
            
            return CELL
        }
    }
    
    @objc func JOIN_B(_ sender: UIButton) {
        
        let DATA = OBJ_COMMUNITY[sender.tag]
        
        if !(DATA.JOIN) {
            PUT_COMMUNITY(NAME: "그룹설정(가입)", AC_TYPE: "register", CC_CODE: DATA.CC_CODE, CC_NAME: DATA.CC_NAME, POSITION: sender.tag)
        } else {
            PUT_COMMUNITY(NAME: "그룹설정(탈퇴)", AC_TYPE: "out", CC_CODE: DATA.CC_CODE, CC_NAME: DATA.CC_NAME, POSITION: sender.tag)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_WRITE") as! VC_WRITE
            VC.BD_TYPE = "C"; VC.BD_NAME = NAVI_L.text!; VC.CC_CODE = OBJ_SOSIK[indexPath.item].CC_CODE
            navigationController?.pushViewController(VC, animated: true)
        } else if indexPath.section == 2 {
            
            if OBJ_COMMUNITY[POSITION].JOIN {
                let DATA = OBJ_SOSIK[indexPath.item]
                let VC = storyboard?.instantiateViewController(withIdentifier: "VC_SOSIK_1") as! VC_SOSIK_1
                VC.BD_TYPE = "C"; VC.AP_SEQ = DATA.AP_SEQ; VC.AP_MSG_GROUP = DATA.AP_MSG_GROUP; VC.POSITION = indexPath.item
                navigationController?.pushViewController(VC, animated: true)
            } else {
                S_NOTICE(":( 게시글을 보려면 가입하세요")
            }
        }
    }
}

extension VC_COMMUNITY_1: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        
        BACKGROUND_I_HEIGHT.constant = -OFFSET_Y + UIViewController.STATUS_Y + 300
        
        if OFFSET_Y <= 0 {
            NAVI_V.backgroundColor = .H_E1E1EB.withAlphaComponent(0.0); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        } else {
            NAVI_V.backgroundColor = .H_E1E1EB.withAlphaComponent(OFFSET_Y/300); NAVI_L.alpha = OFFSET_Y/300; LINE_V.alpha = 0.1
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let END_SCROLL = scrollView.contentOffset.y + scrollView.frame.size.height
        if OBJ_COMMUNITY[POSITION].JOIN && OBJ_SOSIK.count > 3 && !FETCHING_MORE {
            if END_SCROLL >= scrollView.contentSize.height { FETCHING_MORE = true; PAGE_NUMBER = PAGE_NUMBER + 1
                GET_SOSIK_L2(NAME: "\(NAVI_L.text!)(목록)", AC_TYPE: "", LM_START: PAGE_NUMBER * ITEM_COUNT)
            }
        }
    }
}

