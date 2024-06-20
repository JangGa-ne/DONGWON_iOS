//
//  VC_EXPENESE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/29.
//

import UIKit

class VC_EXPENESE_TC: UITableViewCell {
    
    @IBOutlet weak var MENU_V: UIMenuView!
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var TITLE_L1: UILabel!
    @IBOutlet weak var TITLE_L2: UILabel!
    
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var PAY_L1: UILabel!
    @IBOutlet weak var PAY_L2: UILabel!
    @IBOutlet weak var PAY_L3: UILabel!
    @IBOutlet weak var PAY_L4: UILabel!
    @IBOutlet weak var PAY_L5: UILabel!
    
    @IBOutlet weak var CUSTOM_SV: UIStackView!
}

/// 관리비(목록)
class VC_EXPENESE: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var MN_POSITION: Int = 0
    var OBJ_EXPENESE: [EXPENESE_L1] = []
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    @IBOutlet weak var DATE_L: UILabel!
    @IBOutlet weak var EDIT_B: UIButton!
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.VC_EXPENESE_DEL = self
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 70, right: 0)
        
        DATE_L.titleFont(size: 18); DATE_L.text = FM_CUSTOM("\(Date())", "yyyy년 MM월")
        EDIT_B.layer.cornerRadius = 15; EDIT_B.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_EXPENESE_L1(NAME: "관리비내역", AC_TYPE: "overview", TARGET_MONTH: FM_CUSTOM("\(Date())", "yyyyMM"))
        
        EDIT_B.addTarget(self, action: #selector(EDIT_B(_:)), for: .touchUpInside)
    }
    
    @objc func EDIT_B(_ sender: UIButton) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "VC_EXPENESE_1") as! VC_EXPENESE_1
        VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self
        VC.DATE = DATE_L.text!
        present(VC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_EXPENESE: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 2 { return 1 } else if OBJ_EXPENESE.count > 0 { TABLEVIEW.isScrollEnabled = true; return 2 } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else if indexPath.section == 1 {

            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_EXPENESE_TC1", for: indexPath) as! VC_EXPENESE_TC
            CELL.MENU_V.itemsWithText = true; CELL.MENU_V.fillEqually = true; CELL.MENU_V.bottomLineThumbView = true; CELL.MENU_V.bottomLineThumbViewHeight = 5
            CELL.MENU_V.padding = 0; CELL.MENU_V.textColor = .gray; CELL.MENU_V.selectedTextColor = .H_2B3F6B; CELL.MENU_V.thumbViewColor = .H_2B3F6B
            CELL.MENU_V.setSegmentedWith(items: ["관리비내역", "납부은행"]); CELL.MENU_V.titlesFont = .boldSystemFont(ofSize: 14)
            CELL.MENU_V.tag = CELL.MENU_V.selectedSegmentIndex; CELL.MENU_V.addTarget(self, action: #selector(MENU_V(_:)), for: .valueChanged)
            return CELL
        } else { NF.numberStyle = .decimal
            
            let DATA = OBJ_EXPENESE[0]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_EXPENESE_TC2", for: indexPath) as! VC_EXPENESE_TC
            
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
            
            if indexPath.item == 0 { CELL.TITLE_L1.isHidden = true; CELL.CUSTOM_V2.isHidden = false; CELL.CUSTOM_SV.isHidden = true
                
                CELL.TITLE_L2.text = "\(DATE_L.text!.replacingOccurrences(of: "년 ", with: "년\n")) 관리비 부과금액"
                CELL.PAY_L1.text = "\(DT_CHECK(NF.string(from: (Int(DATA.AMOUNT) ?? 0) as NSNumber) ?? ""))원"
                
                if DATA.BILL_COMPARE.count > 0 {
                    
                    let PREVIOUS_MONTH: Int = Int(DATA.LAST_AMOUNT) ?? 0
                    let PREVIOUS_COMPARE: Int = (Int(DATA.AMOUNT) ?? 0) - PREVIOUS_MONTH
                    let AVERAGE_MONTH: Int = (Int(DATA.BILL_COMPARE[0].APT_AMOUNT_COST) ?? 0) / (Int(DATA.BILL_COMPARE[0].APT_HOUSE_CNT) ?? 0)
                    let AVERAGE_COMPARE: Int = (Int(DATA.AMOUNT) ?? 0) - AVERAGE_MONTH
                    
                    CELL.PAY_L2.text = "\(DT_CHECK(NF.string(from: PREVIOUS_MONTH as NSNumber) ?? ""))원"
                    CELL.PAY_L3.text = "\(DT_CHECK(NF.string(from: PREVIOUS_COMPARE as NSNumber) ?? ""))원"; CELL.PAY_L3.textColor = UIColor().COMPARISON(VALUE: PREVIOUS_COMPARE)
                    CELL.PAY_L4.text = "\(DT_CHECK(NF.string(from: AVERAGE_MONTH as NSNumber) ?? ""))원"
                    CELL.PAY_L5.text = "\(DT_CHECK(NF.string(from: AVERAGE_COMPARE as NSNumber) ?? ""))원"; CELL.PAY_L5.textColor = UIColor().COMPARISON(VALUE: AVERAGE_COMPARE)
                }
            } else if indexPath.item == 1 { CELL.TITLE_L1.isHidden = false; CELL.CUSTOM_V2.isHidden = true; CELL.CUSTOM_SV.isHidden = false
                
                CELL.TITLE_L1.titleFont(size: 16); CELL.TITLE_L1.text = "상세내역"
                
                if CELL.CUSTOM_SV.arrangedSubviews.count > 0 { CELL.CUSTOM_SV.removeAllArrangedSubviews() }
                
                if DATA.BILL_DETAIL.count > 0 {
                    
                    let CUSTOM_V3 = UIView(); CUSTOM_V3.heightAnchor.constraint(equalToConstant: 1).isActive = true; CUSTOM_V3.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
                    CELL.CUSTOM_SV.addArrangedSubview(CUSTOM_V3)
                    
                    for DATA in DATA.BILL_DETAIL {
                        
                        let VIEW = UIView(); VIEW.heightAnchor.constraint(equalToConstant: 25).isActive = true; VIEW.backgroundColor = .clear
                        
                        let LABEL1 = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-150, height: 25))
                        LABEL1.textAlignment = .left; LABEL1.textColor = .black
                        LABEL1.font = .systemFont(ofSize: 14); LABEL1.text = DT_CHECK(DATA.BILL_NAME)
                        LABEL1.alpha = 0.7; VIEW.addSubview(LABEL1)
                        
                        let LABEL2 = UILabel(frame: CGRect(x: LABEL1.frame.width, y: 0, width: 80, height: 25))
                        LABEL2.textAlignment = .right; LABEL2.textColor = .black
                        LABEL2.font = .boldSystemFont(ofSize: 14); LABEL2.text = "\(DT_CHECK(NF.string(from: (Int(DATA.BILL_COST) ?? 0) as NSNumber) ?? ""))원"
                        LABEL2.alpha = 1.0; VIEW.addSubview(LABEL2)
                        
                        CELL.CUSTOM_SV.addArrangedSubview(VIEW)
                    }
                    
                    let CUSTOM_V4 = UIView(); CUSTOM_V4.heightAnchor.constraint(equalToConstant: 5).isActive = true; CUSTOM_V4.backgroundColor = .clear
                    CELL.CUSTOM_SV.addArrangedSubview(CUSTOM_V4)
                } else {
                    
                    CELL.CUSTOM_SV.isHidden = true
                }
            }
            
            return CELL
        }
    }
    
    @objc func MENU_V(_ sender: UIMenuView) {
        
        MN_POSITION = sender.selectedSegmentIndex; UIImpactFeedbackGenerator().impactOccurred(); TABLEVIEW.contentOffset = CGPoint(x: 0, y: -44)
        
        if sender.selectedSegmentIndex == 0 {
            GET_EXPENESE_L1(NAME: "관리비내역", AC_TYPE: "overview", TARGET_MONTH: DATE_L.text!)
        } else if sender.selectedSegmentIndex == 1 {
            TABLEVIEW.isScrollEnabled = false
            NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
            OBJ_EXPENESE.removeAll(); UIView.performWithoutAnimation { self.TABLEVIEW.reloadSections(IndexSet(integer: 2), with: .none) }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension VC_EXPENESE: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
