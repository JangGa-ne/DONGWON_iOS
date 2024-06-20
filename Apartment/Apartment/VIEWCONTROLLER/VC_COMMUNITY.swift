//
//  VC_COMMUNITY.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/16.
//

import UIKit

/// 그룹설정(목록)
class VC_COMMUNITY: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var OBJ_COMMUNITY_L1: [COMMUNITY] = []
    var OBJ_COMMUNITY_L2: [COMMUNITY] = []
    
    var FETCHING_MORE: Bool = false
    var PAGE_NUMBER: Int = 0
    var ITEM_COUNT: Int = 20
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.VC_COMMUNITY_DEL = self
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        if #available(iOS 15.0, *) { TABLEVIEW.sectionHeaderTopPadding = 0 }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIViewController.APPDELEGATE.VC_COMMUNITY_1_DEL = nil
        
        BACK_GESTURE(true); GET_COMMNUNITY_L(NAME: "그룹설정(목록)", AC_TYPE: "list", LM_START: 0)
    }
}

extension VC_COMMUNITY: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 0 {
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_COMMUNITY_TCT") as! VC_COMMUNITY_TC
            CELL.TITLE_L.titleFont(size: 18); CELL.TITLE_L.text = ["가입", "미가입"][section-1]
            return CELL
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 } else if section == 1 && OBJ_COMMUNITY_L1.count == 0 { return 0 } else { return 50 }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if OBJ_COMMUNITY_L1.count > 0 { return 1 } else { return 0 }
        } else {
            if OBJ_COMMUNITY_L2.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_COMMUNITY_L2.count } else { return 0 }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else if indexPath.section == 1 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_COMMUNITY_TC1", for: indexPath) as! VC_COMMUNITY_TC
            CELL.PROTOCOL = self; CELL.OBJ_COMMUNITY_L1 = OBJ_COMMUNITY_L1; CELL.viewDidLoad()
            return CELL
        } else {
            
            let DATA = OBJ_COMMUNITY_L2[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_COMMUNITY_TC2", for: indexPath) as! VC_COMMUNITY_TC
            
            CELL.CUSTOM_V1.layer.borderWidth = 1; CELL.CUSTOM_V1.layer.borderColor = UIColor.lightGray.cgColor
            CELL.CUSTOM_V1.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
            
            CELL.THUMB_I.layer.cornerRadius = 7.5; CELL.THUMB_I.clipsToBounds = true
            SDWEBIMAGE(IV: CELL.THUMB_I, IU: DATA.CC_IMG, PH: UIImage(named: "main_bg.png"), RD: 7.5, CM: .scaleAspectFill)

            CELL.TITLE_L.text = DT_CHECK(DATA.CC_NAME)
            CELL.COUNT_L.text = "멤버 \(DATA.CC_COUNT_IN)명"
            
            CELL.JOIN_B.layer.cornerRadius = 7.5; CELL.JOIN_B.clipsToBounds = true
            if !(DATA.JOIN) { CELL.JOIN_B.setTitle("가입하기", for: .normal) } else { CELL.JOIN_B.setTitle("보기", for: .normal) }
            CELL.JOIN_B.tag = indexPath.item; CELL.JOIN_B.addTarget(self, action: #selector(JOIN_B(_:)), for: .touchUpInside)
            
            return CELL
        }
    }
    
    @objc func JOIN_B(_ sender: UIButton) {
        
        let DATA = OBJ_COMMUNITY_L2[sender.tag]
        
        if !(DATA.JOIN) {
            PUT_COMMUNITY(NAME: "그룹설정(가입)", AC_TYPE: "register", CC_CODE: DATA.CC_CODE, CC_NAME: DATA.CC_NAME, POSITION: sender.tag)
        } else {
            
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_COMMUNITY_1") as! VC_COMMUNITY_1
            VC.OBJ_COMMUNITY = OBJ_COMMUNITY_L2; VC.POSITION = sender.tag
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_COMMUNITY_1") as! VC_COMMUNITY_1
            VC.OBJ_COMMUNITY = OBJ_COMMUNITY_L2; VC.POSITION = indexPath.item
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}

extension VC_COMMUNITY: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let END_SCROLL = scrollView.contentOffset.y + scrollView.frame.size.height
        if OBJ_COMMUNITY_L2.count > 0 && !FETCHING_MORE {
            if END_SCROLL >= scrollView.contentSize.height { FETCHING_MORE = true; PAGE_NUMBER = PAGE_NUMBER + 1
                GET_COMMNUNITY_L(NAME: "그룹설정(목록)", AC_TYPE: "list", LM_START: PAGE_NUMBER * ITEM_COUNT)
            }
        }
    }
}
