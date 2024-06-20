//
//  VC_PARKING.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/28.
//

import UIKit

class VC_PARKING_TC: UITableViewCell {
    
    @IBOutlet weak var MENU_V: UIMenuView!
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var PARKING_L1: UILabel!
    @IBOutlet weak var PARKING_L2: UILabel!
    @IBOutlet weak var PARKING_L3: UILabel!
    @IBOutlet weak var PARKING_L4: UILabel!
    @IBOutlet weak var CANCEL_B: UIButton!
}

/// 주차등록(목록)
class VC_PARKING: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var FETCHING_MORE: Bool = false
    var PAGE_NUMBER: Int = 0
    var ITEM_COUNT: Int = 20
    
    var MN_POSITION: Int = 0
    var OBJ_PARKING: [PARKING_L] = []
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var DETAIL_B: UIButton!
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
        
        DETAIL_B.addTarget(self, action: #selector(DETAIL_B(_:)), for: .touchUpInside)
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_PARKING_L1(NAME: "방문주차(목록)", AC_TYPE: "list", LM_START: 0)
    }
    
    @objc func DETAIL_B(_ sender: UIButton) {
        
        let ALERT = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        ALERT.addAction(UIAlertAction(title: "방문주차", style: .default, handler: { _ in
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "VC_PARKING_1") as! VC_PARKING_1
            VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self; VC.TITLE = "방문주차"
            self.present(VC, animated: true, completion: nil)
        }))
        ALERT.addAction(UIAlertAction(title: "세대주차", style: .default, handler: { _ in
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "VC_PARKING_2") as! VC_PARKING_2
            VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self; VC.TITLE = "세대주차"
            self.present(VC, animated: true, completion: nil)
        }))
        ALERT.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(ALERT, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_PARKING: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 2 { return 1 } else if OBJ_PARKING.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_PARKING.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else if indexPath.section == 1 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_PARKING_TC1", for: indexPath) as! VC_PARKING_TC
            CELL.MENU_V.itemsWithText = true; CELL.MENU_V.fillEqually = true; CELL.MENU_V.bottomLineThumbView = true; CELL.MENU_V.bottomLineThumbViewHeight = 5
            CELL.MENU_V.padding = 0; CELL.MENU_V.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1); CELL.MENU_V.selectedTextColor = .H_2B3F6B; CELL.MENU_V.thumbViewColor = .H_2B3F6B
            CELL.MENU_V.setSegmentedWith(items: ["방문주차", "세대주차", "차량출입"]); CELL.MENU_V.titlesFont = .boldSystemFont(ofSize: 14)
            CELL.MENU_V.tag = CELL.MENU_V.selectedSegmentIndex; CELL.MENU_V.addTarget(self, action: #selector(MENU_V(_:)), for: .valueChanged)
            return CELL
        } else {
            
            let DATA = OBJ_PARKING[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_PARKING_TC2", for: indexPath) as! VC_PARKING_TC
            
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
            
            if MN_POSITION == 0 { CELL.PARKING_L3.isHidden = false; CELL.PARKING_L4.isHidden = false; CELL.CANCEL_B.isHidden = false
                CELL.PARKING_L1.text = "차량번호 : \(DT_CHECK(DATA.CAR_INIT+DATA.CAR_CHAR+DATA.CAR_END))"
                CELL.PARKING_L2.text = "등록일자 : \(FM_CUSTOM(DATA.INPUT_DATETIME, "yy.MM.dd (E)"))"
                CELL.PARKING_L3.text = "방문일자 : \(FM_CUSTOM(DATA.DATE, "yy.MM.dd (E)"))"
                CELL.PARKING_L4.text = "주차시간 : \(FM_CUSTOM(DATA.START, "a hh:mm")) ~ \(FM_CUSTOM(DATA.END, "a hh:mm"))"
                CELL.CANCEL_B.tag = indexPath.item; CELL.CANCEL_B.addTarget(self, action: #selector(CANCEL_B(_:)), for: .touchUpInside)
            } else if MN_POSITION == 1 { CELL.PARKING_L3.isHidden = true; CELL.PARKING_L4.isHidden = true; CELL.CANCEL_B.isHidden = true
                CELL.PARKING_L1.text = "차량번호 : \(DT_CHECK(DATA.CAR_INIT+DATA.CAR_CHAR+DATA.CAR_END))"
                CELL.PARKING_L2.text = "등록일자 : \(FM_CUSTOM(DATA.REG_DATE, "yy.MM.dd (E)"))"
            } else if MN_POSITION == 2 { CELL.PARKING_L3.isHidden = false; CELL.PARKING_L4.isHidden = true; CELL.CANCEL_B.isHidden = true
                CELL.PARKING_L1.text = "차량번호 : \(DT_CHECK(DATA.PLATE_INFO))"
                CELL.PARKING_L2.text = "입차시간 : \(FM_CUSTOM("\(DATA.IN_DATE) \(DATA.IN_TIME)", "yy.MM.dd (E) a hh:mm"))"
                CELL.PARKING_L3.text = "출차시간 : \(FM_CUSTOM("\(DATA.OUT_DATE) \(DATA.OUT_TIME)", "yy.MM.dd (E) a hh:mm"))"
            }
            
            CELL.CANCEL_B.layer.cornerRadius = 7.5; CELL.CANCEL_B.clipsToBounds = true
            
            return CELL
        }
    }
    
    @objc func MENU_V(_ sender: UIMenuView) {
        
        MN_POSITION = sender.selectedSegmentIndex; UIImpactFeedbackGenerator().impactOccurred(); TABLEVIEW.contentOffset = CGPoint(x: 0, y: -44)
        
        if sender.selectedSegmentIndex == 0 {
            GET_PARKING_L1(NAME: "방문주차(목록)", AC_TYPE: "list", LM_START: 0)
        } else if sender.selectedSegmentIndex == 1 {
            GET_PARKING_L2(NAME: "세대주차(목록)", AC_TYPE: "list")
        } else if sender.selectedSegmentIndex == 2{
            GET_PARKING_L2(NAME: "차량출입(목록)", AC_TYPE: "in_out")
        }
    }
    
    @objc func CANCEL_B(_ sender: UIButton) {
        PUT_PARKING(NAME: "방문주차(삭제)", AC_TYPE: "delete", IDX: OBJ_PARKING[sender.tag].IDX)
    }
}

extension VC_PARKING: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let END_SCROLL = scrollView.contentOffset.y + scrollView.frame.size.height
        if MN_POSITION == 0 && OBJ_PARKING.count > 3 && !FETCHING_MORE {
            if END_SCROLL >= scrollView.contentSize.height { FETCHING_MORE = true; PAGE_NUMBER = PAGE_NUMBER + 1
                GET_PARKING_L1(NAME: "방문주차(목록)", AC_TYPE: "list", LM_START: PAGE_NUMBER * ITEM_COUNT)
            }
        }
    }
}
