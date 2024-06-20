//
//  VC_EVCAR.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/28.
//

import UIKit

class VC_EVCAR_TC: UITableViewCell {
    
    @IBOutlet weak var MENU_V: UIMenuView!
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var EVCAR_L1: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    @IBOutlet weak var EVCAR_L2: UILabel!
    @IBOutlet weak var EVCAR_L3: UILabel!
    @IBOutlet weak var EVCAR_L4: UILabel!
    @IBOutlet weak var EVCAR_L5: UILabel!
    @IBOutlet weak var EVCAR_L6: UILabel!
}

/// EV자동차(목록)
class VC_EVCAR: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var MN_POSITION: Int = 0
    var OBJ_EVCAR: [EVCAR_L] = []
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 20, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_EVCAR_L(NAME: "충전기(목록)", AC_TYPE: "list")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_EVCAR: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 2 { return 1 } else if OBJ_EVCAR.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_EVCAR.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else if indexPath.section == 1 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_EVCAR_TC1", for: indexPath) as! VC_EVCAR_TC
            CELL.MENU_V.itemsWithText = true; CELL.MENU_V.fillEqually = true; CELL.MENU_V.bottomLineThumbView = true; CELL.MENU_V.bottomLineThumbViewHeight = 5
            CELL.MENU_V.padding = 0; CELL.MENU_V.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1); CELL.MENU_V.selectedTextColor = .H_2B3F6B; CELL.MENU_V.thumbViewColor = .H_2B3F6B
            CELL.MENU_V.setSegmentedWith(items: ["충전기", "충전내역"]); CELL.MENU_V.titlesFont = .boldSystemFont(ofSize: 14)
            CELL.MENU_V.tag = CELL.MENU_V.selectedSegmentIndex; CELL.MENU_V.addTarget(self, action: #selector(MENU_V(_:)), for: .valueChanged)
            return CELL
        } else {
            
            let DATA = OBJ_EVCAR[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_EVCAR_TC2", for: indexPath) as! VC_EVCAR_TC
            
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true; CELL.EVCAR_L1.titleFont(size: 18)
            
            if MN_POSITION == 0 { CELL.EVCAR_L1.isHidden = true; CELL.LINE_V.isHidden = true; CELL.EVCAR_L4.isHidden = true; CELL.EVCAR_L5.isHidden = true; CELL.EVCAR_L6.isHidden = true
                CELL.EVCAR_L2.text = "충전기명 : \(DT_CHECK(DATA.CHARGER_NAME))"
                if DATA.PLATE_INFO == "" { CELL.EVCAR_L3.text = "기기상태 : 사용가능" } else { CELL.EVCAR_L3.text = "기기상태 : 사용불가" }
//                CELL.EVCAR_L2.text = "충전기명 : \(DT_CHECK(DATA.CHARGER_NAME))"
//                CELL.EVCAR_L3.text = "충전차량 : \(DT_CHECK(DATA.PLATE_INFO))"
//                CELL.EVCAR_L4.text = "충전시작 : \(FM_CUSTOM(DATA.CHARGER_START, "yy.MM.dd (E) a hh:mm"))"
//                CELL.EVCAR_L5.text = "완충예정 : \(FM_CUSTOM(DATA.CHARGER_END, "yy.MM.dd (E) a hh:mm"))"
            } else if MN_POSITION == 1 { CELL.EVCAR_L1.isHidden = false; CELL.LINE_V.isHidden = false; CELL.EVCAR_L4.isHidden = false; CELL.EVCAR_L5.isHidden = false; CELL.EVCAR_L6.isHidden = false
                CELL.EVCAR_L1.text = DT_CHECK(DATA.CHARGER_NAME)
                CELL.EVCAR_L2.text = "충전상태 : "
                CELL.EVCAR_L3.text = "충전시작 : \(FM_CUSTOM(DATA.CHARGER_START, "yy.MM.dd (E) a hh:mm"))"
                CELL.EVCAR_L4.text = "완충예정 : \(FM_CUSTOM(DATA.CHARGER_END, "yy.MM.dd (E) a hh:mm"))"
                CELL.EVCAR_L5.text = "충전잔량 : "
                CELL.EVCAR_L6.text = "충전금액 : "
            }
            
            return CELL
        }
    }
    
    @objc func MENU_V(_ sender: UIMenuView) {
        
        MN_POSITION = sender.selectedSegmentIndex; UIImpactFeedbackGenerator().impactOccurred(); TABLEVIEW.contentOffset = CGPoint(x: 0, y: -44)
        
        if sender.selectedSegmentIndex == 0 {
            GET_EVCAR_L(NAME: "충전기(목록)", AC_TYPE: "list")
        } else if sender.selectedSegmentIndex == 1 {
            GET_EVCAR_L(NAME: "충전내역(목록)", AC_TYPE: "history")
        }
    }
}

extension VC_EVCAR: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
