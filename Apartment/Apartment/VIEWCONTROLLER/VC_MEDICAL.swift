//
//  VC_MEDICAL.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/01.
//

import UIKit

class VC_MEDICAL_TC: UITableViewCell {
    
    @IBOutlet weak var MENU_V: UIMenuView!
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var NUMBER_L: UILabel!
    @IBOutlet weak var ADDR_L: UILabel!
    @IBOutlet weak var CUSTOM_V2: UIView!
}

/// 병원/약국(목록)
class VC_MEDICAL: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var FETCHING_MORE: Bool = false
    var PAGE_NUMBER: Int = 0
    var ITEM_COUNT: Int = 20
    
    var MN_POSITION: Int = 0
    var OBJ_MEDICAL: [MEDICAL_L] = []
    
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
        
        GET_MEDICAL_L(NAME: "병원(목록)", AC_TYPE: "list", LM_START: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_MEDICAL: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 2 { return 1 } else if OBJ_MEDICAL.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_MEDICAL.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else if indexPath.section == 1 {

            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_MEDICAL_TC1", for: indexPath) as! VC_MEDICAL_TC
            CELL.MENU_V.itemsWithText = true; CELL.MENU_V.fillEqually = true; CELL.MENU_V.bottomLineThumbView = true; CELL.MENU_V.bottomLineThumbViewHeight = 5
            CELL.MENU_V.padding = 0; CELL.MENU_V.textColor = .gray; CELL.MENU_V.selectedTextColor = .H_2B3F6B; CELL.MENU_V.thumbViewColor = .H_2B3F6B
            CELL.MENU_V.setSegmentedWith(items: ["병원", "약국"]); CELL.MENU_V.titlesFont = .boldSystemFont(ofSize: 14)
            CELL.MENU_V.tag = CELL.MENU_V.selectedSegmentIndex; CELL.MENU_V.addTarget(self, action: #selector(MENU_V(_:)), for: .valueChanged)
            return CELL
        } else {
            
            let DATA = OBJ_MEDICAL[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_MEDICAL_TC2", for: indexPath) as! VC_MEDICAL_TC
            
            CELL.CUSTOM_V1.layer.borderWidth = 1; CELL.CUSTOM_V1.layer.borderColor = UIColor.lightGray.cgColor
            CELL.CUSTOM_V1.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
            
            CELL.NAME_L.text = DT_CHECK(DATA.HOS_NAME)
            CELL.NUMBER_L.text = DT_CHECK(NUMBER(DATA.TEL_NO.count, DATA.TEL_NO))
            CELL.ADDR_L.text = DT_CHECK(DATA.ADDR)
            
            CELL.CUSTOM_V2.roundCorners(corners: [.layerMaxXMaxYCorner], radius: 15)
            
            return CELL
        }
    }
    
    @objc func MENU_V(_ sender: UIMenuView) {
        
        MN_POSITION = sender.selectedSegmentIndex; UIImpactFeedbackGenerator().impactOccurred(); TABLEVIEW.contentOffset = CGPoint(x: 0, y: -44)
        
        if sender.selectedSegmentIndex == 0 {
            GET_MEDICAL_L(NAME: "병원(목록)", AC_TYPE: "list", LM_START: 0)
        } else if sender.selectedSegmentIndex == 1 {
            GET_MEDICAL_L(NAME: "약국(목록)", AC_TYPE: "list", LM_START: 0)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            
            let ALERT = UIAlertController(title: nil, message: OBJ_MEDICAL[indexPath.item].HOS_NAME, preferredStyle: .actionSheet)
            
            ALERT.addAction(UIAlertAction(title: "전화", style: .default, handler: { _ in
                UIApplication.shared.open(URL(string: "tel://" + self.OBJ_MEDICAL[indexPath.item].TEL_NO)!)
            }))
            ALERT.addAction(UIAlertAction(title: "지도", style: .default, handler: { _ in
                let VC = self.storyboard?.instantiateViewController(withIdentifier: "VC_MEDICAL_1") as! VC_MEDICAL_1
                VC.OBJ_MEDICAL = self.OBJ_MEDICAL; VC.POSITION = indexPath.item
                self.navigationController?.pushViewController(VC, animated: true)
            }))
            ALERT.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            
            present(ALERT, animated: true, completion: nil)
        }
    }
}

extension VC_MEDICAL: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let END_SCROLL = scrollView.contentOffset.y + scrollView.frame.size.height
        if OBJ_MEDICAL.count > 3 && !FETCHING_MORE {
            if END_SCROLL >= scrollView.contentSize.height { FETCHING_MORE = true; PAGE_NUMBER = PAGE_NUMBER + 1
                GET_MEDICAL_L(NAME: "병원/약국(목록)", AC_TYPE: "list", LM_START: PAGE_NUMBER * ITEM_COUNT)
            }
        }
    }
}

