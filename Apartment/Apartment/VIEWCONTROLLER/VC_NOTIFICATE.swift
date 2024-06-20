//
//  VC_NOTIFICATE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/23.
//

import UIKit
import FirebaseMessaging

class VC_NOTIFICATE_TC: UITableViewCell {
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    @IBOutlet weak var NOTI_S: UISwitch!
}

class VC_NOTIFICATE: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
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
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_NOTIFICATE: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 } else { return 4 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_NOTIFICATE_TC", for: indexPath) as! VC_NOTIFICATE_TC
            
            if indexPath.item == 0 {
                CELL.CUSTOM_V1.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15); CELL.LINE_V.isHidden = false
            } else if indexPath.item == 3 {
                CELL.CUSTOM_V1.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 15); CELL.LINE_V.isHidden = true
            } else {
                CELL.CUSTOM_V1.layer.cornerRadius = 0; CELL.LINE_V.isHidden = false
            }
            
            CELL.NAME_L.text = ["편의기능", "동네소식", "스마트홈", "관리기능"][indexPath.item]
            
            CELL.NOTI_S.isOn = true
//            CELL.NOTI_S.isOn = UserDefaults.standard.bool(forKey: "push_\(indexPath.item)")
//            CELL.NOTI_S.tag = indexPath.item; CELL.NOTI_S.addTarget(self, action: #selector(NOTI_S(_:)), for: .valueChanged)
            
            return CELL
        }
    }
    
    @objc func NOTI_S(_ sender: UISwitch) {
        UserDefaults.standard.setValue(sender.isOn, forKey: "push_\(sender.tag)")
    }
}

extension VC_NOTIFICATE: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
