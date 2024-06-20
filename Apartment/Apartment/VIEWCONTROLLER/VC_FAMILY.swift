//
//  VC_FAMILY.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/21.
//

import UIKit

class VC_FAMILY_TC: UITableViewCell {
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var PROFILE_I: UIImageView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var NUMBER_L: UILabel!
    @IBOutlet weak var DELETE_B: UIButton!
}

class VC_FAMILY: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var TITLE: String = ""
    var OBJ_FAMILY: [FAMILY] = []
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var EDIT_B: UIButton!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        TITLE = "\(UserDefaults.standard.string(forKey: "building_id") ?? "")동 \(UserDefaults.standard.string(forKey: "house_number") ?? "")호"
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.text = TITLE; NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_FAMILY_L(NAME: "가족등록(목록)", AC_TYPE: "list")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_FAMILY: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 } else if OBJ_FAMILY.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_FAMILY.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30); CELL.TITLE_L.text = TITLE
            return CELL
        } else {
            
            let DATA = OBJ_FAMILY[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_FAMILY_TC", for: indexPath) as! VC_FAMILY_TC
            
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
            
            SDWEBIMAGE(IV: CELL.PROFILE_I, IU: DATA.MB_PHOTO, PH: UIImage(named: "profile.png")!, RD: CELL.PROFILE_I.frame.width/2, CM: .scaleAspectFill)
            
            CELL.NAME_L.text = "\(DATA.BK_NAME)(\(DATA.BK_NICK))"
            CELL.NUMBER_L.text = NUMBER(DATA.BK_HP.count, DATA.BK_HP)
            
//            if DATA.BK_HP == UserDefaults.standard.string(forKey: "mb_id") ?? "" { CELL.DELETE_B.isHidden = true } else { CELL.DELETE_B.isHidden = false }
            CELL.DELETE_B.layer.cornerRadius = 7.5; CELL.DELETE_B.clipsToBounds = true
            CELL.DELETE_B.addTarget(self, action: #selector(DELETE_B(_:)), for: .touchUpInside)
            
            return CELL
        }
    }
    
    @objc func DELETE_B(_ sender: UIButton) {
        
        
    }
}

extension VC_FAMILY: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
