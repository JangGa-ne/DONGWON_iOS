//
//  VC_DELIVERY.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/29.
//

import UIKit

class VC_DELIVERY_TC: UITableViewCell {
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var STATE_V: UIView!
    @IBOutlet weak var DATE_L: UILabel!
    @IBOutlet weak var DAY_L: UILabel!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var WAYBILL_L: UILabel!
    @IBOutlet weak var COMPANY_L: UILabel!
    @IBOutlet weak var STATE_L: UILabel!
}

/// 배송조회(목록)
class VC_DELIVERY: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var FETCHING_MORE: Bool = false
    var PAGE_NUMBER: Int = 0
    var ITEM_COUNT: Int = 20
    
    var MN_POSITION: Int = 0
    var OBJ_DELIVERY: [DELIVERY_L1] = []
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    @IBOutlet weak var EDIT_B: UIButton!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.VC_DELIVERY_DEL = self
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 50, right: 0)
        
        EDIT_B.layer.cornerRadius = 15; EDIT_B.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_DELIVERY_L1(NAME: "배송조회(목록/디테일)", AC_TYPE: "process", LM_START: 0)
        
        EDIT_B.addTarget(self, action: #selector(EDIT_B(_:)), for: .touchUpInside)
    }
    
    @objc func EDIT_B(_ sender: UIButton) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "VC_DELIVERY_1") as! VC_DELIVERY_1
        VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self
        present(VC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_DELIVERY: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 } else if OBJ_DELIVERY.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_DELIVERY.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else {
            
            let DATA = OBJ_DELIVERY[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_DELIVERY_TC1", for: indexPath) as! VC_DELIVERY_TC
            
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
            CELL.STATE_V.layer.cornerRadius = 5; CELL.STATE_V.clipsToBounds = true
            
            if DATA.PAR_DETAIL.count > 0 { CELL.STATE_V.backgroundColor = .H_4E177C } else { CELL.STATE_V.backgroundColor = .gray }
            CELL.DATE_L.text = FM_CUSTOM(DATA.REG_DATE, "MM.yy"); CELL.DAY_L.text = FM_CUSTOM(DATA.REG_DATE, "E요일")
            if DATA.ITEM_NAME == "" { CELL.NAME_L.alpha = 0.3; CELL.NAME_L.text = "상품명이 없습니다." } else { CELL.NAME_L.alpha = 1.0; CELL.NAME_L.text = DATA.ITEM_NAME }
            CELL.WAYBILL_L.text = DT_CHECK(DATA.IN_VOICE_NO)
            CELL.COMPANY_L.text = DT_CHECK(DATA.COMPANY_NAME)
            
            if DATA.TOTAL_LEVEL == "1" {
                CELL.STATE_L.text = "집화처리"
            } else if DATA.TOTAL_LEVEL == "2" {
                CELL.STATE_L.text = "이동중"
            } else if DATA.TOTAL_LEVEL == "3" {
                CELL.STATE_L.text = "배송중"
            } else if DATA.TOTAL_LEVEL == "4" {
                CELL.STATE_L.text = "배송시작"
            } else if DATA.TOTAL_LEVEL == "5" {
                CELL.STATE_L.text = "배송완료"
            } else {
                CELL.STATE_L.text = "배송정보없음"
            }
            
            return CELL
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            let DATA = OBJ_DELIVERY[indexPath.item]
            if DATA.PAR_DETAIL.count > 0 {
                
            } else {
                S_NOTICE(":( 배송정보가 없어요")
            }
        }
    }
}

extension VC_DELIVERY: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        
//        let END_SCROLL = scrollView.contentOffset.y + scrollView.frame.size.height
//        if MN_POSITION == 0 && OBJ_DELIVERY.count > 3 && !FETCHING_MORE {
//            if END_SCROLL >= scrollView.contentSize.height { FETCHING_MORE = true; PAGE_NUMBER = PAGE_NUMBER + 1
//                GET_DELIVERY_L1(NAME: "배송조회(목록/디테일)", AC_TYPE: "process", LM_START: PAGE_NUMBER * ITEM_COUNT)
//            }
//        }
//    }
}
