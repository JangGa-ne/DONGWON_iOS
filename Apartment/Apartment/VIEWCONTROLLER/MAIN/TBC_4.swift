//
//  TBC_4.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/07.
//

import UIKit

class TBC_4_TC: UITableViewCell {
    
    @IBOutlet weak var TITLE_L: UILabel!
    
    @IBOutlet weak var CUSTOM_V: UIView!
    @IBOutlet weak var ICON_I: UIImageView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var EXPLAN_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
}

class TBC_4: UIViewController {
    
    var ST_WHITE: Bool = false
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if !ST_WHITE { if #available(iOS 13.0, *) { return .darkContent } else { return .default } } else { return .lightContent }
    }
    
    var OBJ_MENU1: [ALLMENU_L] = []
    var OBJ_MENU2: [ALLMENU_L] = []
    var OBJ_MENU3: [ALLMENU_L] = []
    var OBJ_MENU4: [ALLMENU_L] = []
    
    @IBOutlet weak var NAVI_V: UIView!
    @IBOutlet weak var NAVI_L_BG: UILabel!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var NOTICE_I: UIImageView!
    @IBOutlet weak var NOTICE_B: UIButton!
    @IBOutlet weak var SETTING_I: UIImageView!
    @IBOutlet weak var SETTING_B: UIButton!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        NOTICE_B.addTarget(self, action: #selector(NOTICE_B(_:)), for: .touchUpInside)
        SETTING_B.addTarget(self, action: #selector(SETTING_B(_:)), for: .touchUpInside)
        NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(0.0); NAVI_L_BG.titleFont(size: 18); NAVI_L.titleFont(size: 18)
        NAVI_L.alpha = 0.0; NOTICE_I.alpha = 0.0; SETTING_I.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 20, right: 0)
        if #available(iOS 15.0, *) { TABLEVIEW.sectionHeaderTopPadding = 0 }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        for (I, DATA) in UIViewController.APPDELEGATE.OBJ_ALLMENU.enumerated() {
            if DATA.CATEGORY_TYPE == "1" { OBJ_MENU1.append(UIViewController.APPDELEGATE.OBJ_ALLMENU[I]) }
            if DATA.CATEGORY_TYPE == "2" { OBJ_MENU2.append(UIViewController.APPDELEGATE.OBJ_ALLMENU[I]) }
            if DATA.CATEGORY_TYPE == "3" { OBJ_MENU3.append(UIViewController.APPDELEGATE.OBJ_ALLMENU[I]) }
            if DATA.CATEGORY_TYPE == "4" { OBJ_MENU4.append(UIViewController.APPDELEGATE.OBJ_ALLMENU[I]) }
        }; TABLEVIEW.reloadData()
    }
}

extension TBC_4: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 } else { TABLEVIEW.isScrollEnabled = true; return [OBJ_MENU1, OBJ_MENU2, OBJ_MENU3, OBJ_MENU4][section-1].count }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 0 {
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TBC_4_TCT") as! TBC_4_TC
            CELL.TITLE_L.titleFont(size: 18); CELL.TITLE_L.text = ["편의기능", "동네소식", "스마트홈", "관리기능"][section-1]
            return CELL
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 } else { return 54 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else {
            
            let DATA = [OBJ_MENU1, OBJ_MENU2, OBJ_MENU3, OBJ_MENU4][indexPath.section-1][indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TBC_4_TC", for: indexPath) as! TBC_4_TC
            
            if indexPath.item == 0 {
                CELL.CUSTOM_V.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15); CELL.LINE_V.isHidden = false
            } else if indexPath.item == [OBJ_MENU1, OBJ_MENU2, OBJ_MENU3, OBJ_MENU4][indexPath.section-1].count-1 {
                CELL.CUSTOM_V.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 15); CELL.LINE_V.isHidden = true
            } else {
                CELL.CUSTOM_V.layer.cornerRadius = 0; CELL.LINE_V.isHidden = false
            }
            
            SDWEBIMAGE(IV: CELL.ICON_I, IU: DATA.ICON_IMG, PH: UIImage(named: "profile.png"), RD: CELL.ICON_I.frame.width/2, CM: .scaleAspectFill)
            CELL.NAME_L.text = DT_CHECK(DATA.FUNCTION_NAME.replacingOccurrences(of: " ", with: ""))
            CELL.EXPLAN_L.text = DT_CHECK(DATA.FUNCTION_EXPLAIN)
            
            return CELL
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            
            let DATA = [OBJ_MENU1, OBJ_MENU2, OBJ_MENU3, OBJ_MENU4][indexPath.section-1][indexPath.item]
            for (KEY, VALUE) in UIViewController.APPDELEGATE.MENUS {
                if VALUE != "VC_AA" && KEY == DATA.FUNCTION_NAME.replacingOccurrences(of: " ", with: "") { UIViewController.APPDELEGATE.MENU = KEY; PRESENT_VC(IDENTIFIER: VALUE, ANIMATED: true) }
            }
        }
    }
}

extension TBC_4: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        
        if OFFSET_Y <= 0 {
            ST_WHITE = false; setNeedsStatusBarAppearanceUpdate()
            NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(0.0)
            NAVI_L.alpha = 0.0; NOTICE_I.alpha = 0.0; SETTING_I.alpha = 0.0
        } else {
            ST_WHITE = true; setNeedsStatusBarAppearanceUpdate()
            NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(OFFSET_Y/44)
            NAVI_L.alpha = OFFSET_Y/44; NOTICE_I.alpha = OFFSET_Y/44; SETTING_I.alpha = OFFSET_Y/44
        }
    }
}
