//
//  VC_SEARCH.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/02.
//

import UIKit

class VC_SEARCH_TC: UITableViewCell {
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var ADDR_L: UILabel!
    @IBOutlet weak var CHOICE_B: UIButton!
}

class VC_SEARCH: UIViewController {
    
    var isBack: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var OBJ_SEARCH_L: [SEARCH_L] = []
    var POSITION: Int = 0
    
    var ROW1: Int = 0
    var ROW2: Int = 0
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.VC_SEARCH_DEL = self
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_SEARCH_L(NAME: "아파트검색(목록)", AC_TYPE: "list")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
        
        DispatchQueue.main.async {
            
            if self.isBack {
                
                let DATA = self.OBJ_SEARCH_L[self.POSITION]
                
                if let BVC = UIViewController.APPDELEGATE.VC_INPUT_DEL {
                    BVC.AP_CODE = DATA.AP_CODE; BVC.BUILDING_ID = DATA.DON_HO_INFO[self.ROW1].BUILDING_ID; BVC.HOUSE_NUMBER = DATA.DON_HO_INFO[self.ROW1].HOUSE_INFO[self.ROW2]
                    BVC.APT_B.setTitle("   \(DATA.AP_NAME.replacingOccurrences(of: "아파트", with: ""))", for: .normal); BVC.APT_B.setTitleColor(.black, for: .normal)
                    BVC.DONG_B.setTitle("   \(DATA.DON_HO_INFO[self.ROW1].BUILDING_ID)동", for: .normal); BVC.DONG_B.setTitleColor(.black, for: .normal)
                    BVC.HO_B.setTitle("   \(DATA.DON_HO_INFO[self.ROW1].HOUSE_INFO[self.ROW2])호", for: .normal); BVC.HO_B.setTitleColor(.black, for: .normal)
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension VC_SEARCH: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 } else if OBJ_SEARCH_L.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_SEARCH_L.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else {
            
            let DATA = OBJ_SEARCH_L[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SEARCH_TC", for: indexPath) as! VC_SEARCH_TC
            
            CELL.CUSTOM_V1.layer.borderWidth = 1; CELL.CUSTOM_V1.layer.borderColor = UIColor.lightGray.cgColor
            CELL.CUSTOM_V1.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
            
            CELL.NAME_L.text = DT_CHECK(DATA.AP_NAME.replacingOccurrences(of: "아파트 ", with: ""))
            CELL.ADDR_L.text = DT_CHECK(DATA.K_APT_ADDR)
            
            CELL.CHOICE_B.layer.cornerRadius = 7.5; CELL.CHOICE_B.clipsToBounds = true
            CELL.CHOICE_B.layer.borderColor = UIColor.H_4E177C.cgColor; CELL.CHOICE_B.layer.borderWidth = 2
            CELL.CHOICE_B.tag = indexPath.item; CELL.CHOICE_B.addTarget(self, action: #selector(CHOICE_B(_:)), for: .touchUpInside)
            
            return CELL
        }
    }
    
    @objc func CHOICE_B(_ sender: UIButton) {
        
        if OBJ_SEARCH_L[sender.tag].DON_HO_INFO.count > 0 {
            
            POSITION = sender.tag
            
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_DONGHO") as! VC_DONGHO
            VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self
            VC.OBJ_SEARCH_D = OBJ_SEARCH_L[sender.tag].DON_HO_INFO
            present(VC, animated: true, completion: nil)
        } else {
            ALERT(TITLE: "", BODY: ":( 선택하신 아파트의 동.호 정보가 없습니다.", STYLE: .alert)
        }
    }
}

extension VC_SEARCH: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
