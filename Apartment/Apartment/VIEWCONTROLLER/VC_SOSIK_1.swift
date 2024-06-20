//
//  VC_SOSIK_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/09.
//

import UIKit

/// 소식(디테일)
class VC_SOSIK_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var BD_TYPE: String = ""
    var AP_SEQ: String = ""
    var AP_MSG_GROUP: String = ""
    var POSITION: Int = 0
    
    var OBJ_SOSIK: [SOSIK_DL] = []
    var OBJ_MEDIA: [SOSIK_D] = []
    var OBJ_FILE: [SOSIK_D] = []
    var OBJ_COMMENT: [COMMENT_L] = []
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var EDIT_B: UIButton!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    @IBOutlet weak var COMMENT_TF: UITextField!
    @IBOutlet weak var COMMENT_B: UIButton!
    
    override func loadView() {
        super.loadView()
        
        S_KEYBOARD()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 20, right: 0)
        
        COMMENT_TF.backgroundColor = UIColor(white: 1.0, alpha: 0.1); PLACEHOLDER(TF: COMMENT_TF, PH: "댓글입력")
        COMMENT_TF.PADDING_LEFT(X: 15); COMMENT_TF.PADDING_RIGHT(X: 15)
        COMMENT_TF.layer.cornerRadius = 15; COMMENT_TF.clipsToBounds = true
        COMMENT_TF.layer.borderWidth = 1; COMMENT_TF.layer.borderColor = UIColor(white: 1.0, alpha: 0.5).cgColor
        COMMENT_B.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let BVC = UIViewController.APPDELEGATE.VC_SOSIK_DEL {
            BVC.OBJ_SOSIK[self.POSITION].READ_CNT += 1; BVC.TABLEVIEW.reloadRows(at: [IndexPath(item: self.POSITION, section: 3)], with: .none)
        }
        if let BVC = UIViewController.APPDELEGATE.VC_COMMUNITY_1_DEL {
            BVC.OBJ_SOSIK[self.POSITION].READ_CNT += 1; BVC.TABLEVIEW.reloadRows(at: [IndexPath(item: self.POSITION, section: 3)], with: .none)
        }
        
        EDIT_B.addTarget(self, action: #selector(EDIT_B(_:)), for: .touchUpInside)
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self
        
        GET_SOSIK_D1(NAME: "소식(디테일)", AC_TYPE: "", BD_TYPE: BD_TYPE)
        
        COMMENT_TF.addTarget(self, action: #selector(COMMENT_TF(_:)), for: .editingChanged)
        COMMENT_B.addTarget(self, action: #selector(COMMENT_B(_:)), for: .touchUpInside)
    }
    
    @objc func EDIT_B(_ sender: UIButton) {
        
        let ALERT = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ALERT.addAction(UIAlertAction(title: "신고", style: .destructive, handler: { _ in
            let ALERT2 = UIAlertController(title: "이 게시물을 신고하는 이유", message: "지식 재산권 침해를 신고하는 경우를 제외하고 회원님의 신고는 익명으로 처리됩니다. 누군가 위급한 상황에 있다고 생각된다면 즉시 현지 응급 서비스 기관에 연락하시기 바랍니다.", preferredStyle: .actionSheet)
            ALERT2.addAction(UIAlertAction(title: "스팸", style: .destructive, handler: { _ in
                self.S_NOTICE(":| 대응 준비중")
            }))
            ALERT2.addAction(UIAlertAction(title: "나체 이미지 또는 성적 행위", style: .destructive, handler: { _ in
                self.S_NOTICE(":| 대응 준비중")
            }))
            ALERT2.addAction(UIAlertAction(title: "마음에 들지 않습니다", style: .destructive, handler: { _ in
                self.S_NOTICE(":| 대응 준비중")
            }))
            ALERT2.addAction(UIAlertAction(title: "사기 또는 거짓", style: .destructive, handler: { _ in
                self.S_NOTICE(":| 대응 준비중")
            }))
            ALERT2.addAction(UIAlertAction(title: "혐오 발언 또는 상징", style: .destructive, handler: { _ in
                self.S_NOTICE(":| 대응 준비중")
            }))
            ALERT2.addAction(UIAlertAction(title: "거짓 정보", style: .destructive, handler: { _ in
                self.S_NOTICE(":| 대응 준비중")
            }))
            ALERT2.addAction(UIAlertAction(title: "따돌림 또는 괴롭힘", style: .destructive, handler: { _ in
                self.S_NOTICE(":| 대응 준비중")
            }))
            ALERT2.addAction(UIAlertAction(title: "취소", style: .cancel))
            self.present(ALERT2, animated: true, completion: nil)
        }))
        ALERT.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(ALERT, animated: true, completion: nil)
    }
    
    @objc func COMMENT_TF(_ sender: UITextField) {
        if sender.text?.count ?? 0 == 0 { COMMENT_B.isHidden = true } else { COMMENT_B.isHidden = false }
    }
    
    @objc func COMMENT_B(_ sender: UIButton) {
        
        if COMMENT_TF.text! == "" {
            S_NOTICE(":( 댓글을 입력해주세요")
        } else {
            PUT_COMMENT(NAME: "댓글(등록)", AC_TYPE: "insert")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_SOSIK_1: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if OBJ_SOSIK.count > 0 { return 5 } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 || section == 4 {
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TCT") as! VC_SOSIK_TC
            CELL.TITLE_L.titleFont(size: 18); if section == 3 { CELL.TITLE_L.text = "첨부파일" } else if section == 4 { CELL.TITLE_L.text = "댓글" }
            return CELL
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 {
            if OBJ_FILE.count > 0 { return 44 } else { return 0 }
        } else if section == 4 {
            if OBJ_COMMENT.count > 0 { return 44 } else { return 0 }
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if OBJ_SOSIK.count > 0 { return 1 } else { return 0 }
        } else if section == 1 {
            if OBJ_MEDIA.count > 0 { return 1 } else { return 0 }
        } else if section == 2 {
            return 1
        } else if section == 3 {
            if OBJ_FILE.count > 0 { return OBJ_FILE.count } else { return 0 }
        } else {
            if OBJ_COMMENT.count > 0 { return OBJ_COMMENT.count } else { return 0 }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let DATA = OBJ_SOSIK[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC1", for: indexPath) as! VC_SOSIK_TC
            
            if (BD_TYPE != "C" && DATA.BOARD_NAME == "") || (BD_TYPE == "C" && DATA.CC_NAME == "") { CELL.TYPE_L.isHidden = true } else { CELL.TYPE_L.isHidden = false }
            CELL.TYPE_L.layer.cornerRadius = 10; CELL.TYPE_L.clipsToBounds = true
            CELL.TYPE_L.backgroundColor = UIColor(hex: DATA.BADGE_COLOR, alpha: 0.3); CELL.TYPE_L.textColor = UIColor(hex: DATA.BADGE_COLOR, alpha: 1.0)
            if BD_TYPE != "C" { CELL.TYPE_L.text = DT_CHECK(DATA.BOARD_NAME.replacingOccurrences(of: " ", with: "")) } else { CELL.TYPE_L.text = DT_CHECK(DATA.CC_NAME) }
            CELL.TYPE_L_WIDTH.constant = CGFloat(CELL.TYPE_L.text!.count*10+10)
            if DATA.SENDER_NICK != "" {
                CELL.NAME_L.text = "\(DATA.SENDER_NICK) · \(FM_CUSTOM(DATA.AP_REQUEST_TIME, "yy/MM/dd HH:mm"))"
            } else {
                CELL.NAME_L.text = FM_CUSTOM(DATA.AP_REQUEST_TIME, "yy/MM/dd HH:mm")
            }
            
            CELL.SUBJECT_L.text = DT_CHECK(ENCODE(DATA.AP_SUBJECT))
            
            return CELL
        } else if indexPath.section == 1 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC2", for: indexPath) as! VC_SOSIK_TC
            CELL.PROTOCOL = self; CELL.DETAIL = true; CELL.BD_TYPE = BD_TYPE; CELL.OBJ_MEDIA = OBJ_MEDIA; CELL.OBJ_FILE = OBJ_FILE; CELL.viewDidLoad()
            if OBJ_MEDIA.count <= 1 { CELL.PAGE_L.isHidden = true } else { CELL.PAGE_L.isHidden = false; CELL.PAGE_L.text = "1/\(OBJ_MEDIA.count)" }
            return CELL
        } else if indexPath.section == 2 {
            
            let DATA = OBJ_SOSIK[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC3", for: indexPath) as! VC_SOSIK_TC
            
            CELL.CONTENTS_TV.isEditable = false; CELL.CONTENTS_TV.dataDetectorTypes = .link
            if DATA.ARTICLE_TYPE == "text" {
                CELL.CONTENTS_TV.text = ENCODE(DATA.AP_CONTENT).replacingOccurrences(of: "<BR>", with: "\n").replacingOccurrences(of: "<br>", with: "\n")
            } else {
                CELL.CONTENTS_TV.attributedText = HTML_STRING_DETAIL(ENCODE(DATA.AP_CONTENT), view.frame.size.width - 30)
            }
            
            return CELL
        } else if indexPath.section == 3 {
            
            let DATA = OBJ_FILE[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC4", for: indexPath) as! VC_SOSIK_TC
            
            CELL.CUSTOM_V1.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
            CELL.FILE_L.text = DT_CHECK(DATA.MEDIA_NAME)
            
            return CELL
        } else {
            
            let DATA = OBJ_COMMENT[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SOSIK_TC5", for: indexPath) as! VC_SOSIK_TC
            
            CELL.CUSTOM_V2.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
            CELL.NICK_L.text = DT_CHECK(DATA.BK_NICK)
            CELL.COMMENT_L.text = DT_CHECK(DATA.COMMENT)
            CELL.DATETIME_L.text = FM_CUSTOM(DATA.REG_DATE, "yy.MM.dd HH:mm")
            
            return CELL
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        view.endEditing(true); if COMMENT_TF.text?.count ?? 0 == 0 { COMMENT_B.isHidden = true } else { COMMENT_B.isHidden = false }
        
        if indexPath.section == 3 {
            FILE(DOWN: OBJ_FILE[indexPath.item].MEDIA_URL, WEB: OBJ_FILE[indexPath.item].MEDIA_URL, NAME: OBJ_FILE[indexPath.item].MEDIA_NAME)
        }
    }
}

extension VC_SOSIK_1: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { LINE_V.alpha = 0.1 } else { LINE_V.alpha = 0.0 }
    }
}
