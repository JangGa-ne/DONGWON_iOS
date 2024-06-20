//
//  VC_CONTACT.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/01.
//

import UIKit

class VC_CONTACT_TC: UITableViewCell {
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var NUMBER_L: UILabel!
    @IBOutlet weak var ADDR_L: UILabel!
    @IBOutlet weak var CUSTOM_V2: UIView!
}

/// 동네연락처(목록)
class VC_CONTACT: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var OBJ_CONTACT: [CONTACT_L] = []
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_CONTACT_L(NAME: "동네연락처(목록)", AC_TYPE: "list")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_CONTACT: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 1 { return 1 } else if OBJ_CONTACT.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_CONTACT.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else {
            
            let DATA = OBJ_CONTACT[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_CONTACT_TC1", for: indexPath) as! VC_CONTACT_TC
            
            CELL.CUSTOM_V1.layer.borderWidth = 1; CELL.CUSTOM_V1.layer.borderColor = UIColor.lightGray.cgColor
            CELL.CUSTOM_V1.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
            
            CELL.NAME_L.text = DT_CHECK(DATA.PH_NAME)
            CELL.NUMBER_L.text = DT_CHECK(NUMBER(DATA.PH_PHONE1.count, DATA.PH_PHONE1))
            CELL.ADDR_L.text = DT_CHECK(DATA.PH_ADDR)
            
            CELL.CUSTOM_V2.roundCorners(corners: [.layerMaxXMaxYCorner], radius: 15)
            
            return CELL
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if OBJ_CONTACT[indexPath.item].PH_PHONE1 != "" { UIApplication.shared.open(URL(string: "tel://" + OBJ_CONTACT[indexPath.item].PH_PHONE1)!) }
        }
    }
}

extension VC_CONTACT: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
