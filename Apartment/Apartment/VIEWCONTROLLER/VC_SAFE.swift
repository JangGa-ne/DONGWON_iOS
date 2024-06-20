//
//  VC_SAFE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/30.
//

import UIKit

class VC_SAFE_TC: UITableViewCell {
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var PROFILE_I: UIImageView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var NUMBER_L: UILabel!
}

/// 자녀안심(목록)
class VC_SAFE: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var OBJ_FAMILY: [FAMILY] = []
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    @IBOutlet weak var NEXT_B: UIButton!
    @IBOutlet weak var FAMILY_B: UIButton!
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.VC_SAFE_DEL = self
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_FAMILY_L(NAME: "자녀안심(목록)", AC_TYPE: "list")
        
        FAMILY_B.addTarget(self, action: #selector(FAMILY_B(_:)), for: .touchUpInside)
    }
    
    @objc func FAMILY_B(_ sender: UIButton) {
        
        if let _ = navigationController?.popViewController(animated: true) {
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_SETTING") as! VC_SETTING
            if let _ = navigationController?.pushViewController(VC, animated: true) {
                PRESENT_VC(IDENTIFIER: "VC_FAMILY", ANIMATED: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_SAFE: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 2 { return 1 } else if OBJ_FAMILY.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_FAMILY.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else if indexPath.section == 1 {
            
            return tableView.dequeueReusableCell(withIdentifier: "VC_SAFE_TC1", for: indexPath) as! VC_SAFE_TC
        } else {
            
            let DATA = OBJ_FAMILY[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SAFE_TC2", for: indexPath) as! VC_SAFE_TC
            
            CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
            
            SDWEBIMAGE(IV: CELL.PROFILE_I, IU: DATA.MB_PHOTO, PH: UIImage(named: "profile.png")!, RD: CELL.PROFILE_I.frame.width/2, CM: .scaleAspectFill)
            
            CELL.NAME_L.text = "\(DATA.BK_NAME)(\(DATA.BK_NICK))"
            CELL.NUMBER_L.text = NUMBER(DATA.BK_HP.count, DATA.BK_HP)
            
            return CELL
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_SAFE_1") as! VC_SAFE_1
            VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self
            VC.OBJ_FAMILY = OBJ_FAMILY; VC.POSITION = indexPath.item
            present(VC, animated: true, completion: nil)
        }
    }
}

extension VC_SAFE: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
