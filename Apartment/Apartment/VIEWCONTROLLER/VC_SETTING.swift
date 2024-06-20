//
//  VC_SETTING.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/16.
//

import UIKit
import FirebaseMessaging

class VC_SETTING_TC: UITableViewCell {
    
    @IBOutlet weak var TITLE_L: UILabel!
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var ICON_I: UIImageView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
}

/// 환경설정(목록)
class VC_SETTING: UIViewController {
    
    let TRANSITION: S_ANIMATION = S_ANIMATION()
    
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
        if #available(iOS 15.0, *) { TABLEVIEW.sectionHeaderTopPadding = 0 }
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

extension VC_SETTING: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section != 0 {
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SETTING_TCT") as! VC_SETTING_TC
            CELL.TITLE_L.titleFont(size: 18); CELL.TITLE_L.text = ["USER", "SERVICE"][section-1]
            return CELL
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 } else { return 54 }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 } else if section == 1 { return 4 } else { return 3 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else {
            
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_SETTING_TC", for: indexPath) as! VC_SETTING_TC
            
            if indexPath.item == 0 {
                CELL.CUSTOM_V1.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15); CELL.LINE_V.isHidden = false
            } else if (indexPath.section == 1 && indexPath.item == 3) || (indexPath.section == 2 && indexPath.item == 2) {
                CELL.CUSTOM_V1.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 15); CELL.LINE_V.isHidden = true
            } else {
                CELL.CUSTOM_V1.layer.cornerRadius = 0; CELL.LINE_V.isHidden = false
            }
            
            if indexPath.section == 1 {
                CELL.ICON_I.image = UIImage(named: ["my_1.png", "my_3.png", "my_4.png", "my_5.png"][indexPath.item])
                CELL.NAME_L.text = ["프로필 정보", "가족관리", "알림설정", "로그아웃"][indexPath.item]
            } else if indexPath.section == 2 {
                CELL.ICON_I.image = UIImage(named: ["service_1.png", "service_2.png", "service_4.png"][indexPath.item])
                CELL.NAME_L.text = ["서비스 이용약관", "개인정보 처리방침", "버전정보"][indexPath.item]
            }
            
            return CELL
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            if indexPath.item == 0 {
                
                let VC = storyboard?.instantiateViewController(withIdentifier: "VC_PROFILE") as! VC_PROFILE
                VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self
                present(VC, animated: true, completion: nil)
            } else if indexPath.item == 1 {
                PRESENT_VC(IDENTIFIER: "VC_FAMILY", ANIMATED: true)
            } else if indexPath.item == 2 {
                PRESENT_VC(IDENTIFIER: "VC_NOTIFICATE", ANIMATED: true)
            } else if indexPath.item == 3 {
                
                let ALERT = UIAlertController(title: "", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
                ALERT.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { _ in
                    
                    for DATA in UIViewController.APPDELEGATE.OBJ_LOGIN {
                        
                        Messaging.messaging().unsubscribe(fromTopic: "CENTER")
                        Messaging.messaging().unsubscribe(fromTopic: DATA.MB_ID)
                        Messaging.messaging().unsubscribe(fromTopic: DATA.AP_CODE)
                        Messaging.messaging().unsubscribe(fromTopic: DATA.AP_CODE+DATA.BUILDING_ID)
                        Messaging.messaging().unsubscribe(fromTopic: DATA.HOME_CODE)
                        Messaging.messaging().unsubscribe(fromTopic: DATA.SC_CITY)
                        Messaging.messaging().unsubscribe(fromTopic: DATA.SD_CODE)
                    }
                    
                    UserDefaults.standard.removeObject(forKey: "mb_id")
                    UserDefaults.standard.removeObject(forKey: "ap_code")
                    UserDefaults.standard.removeObject(forKey: "building_id")
                    UserDefaults.standard.removeObject(forKey: "house_number")
                    UserDefaults.standard.removeObject(forKey: "home_code")
                    UserDefaults.standard.removeObject(forKey: "bk_nick")
                    
                    self.PRESENT_VC(IDENTIFIER: "VC_LOADING", ANIMATED: true)
                }))
                ALERT.addAction(UIAlertAction(title: "취소", style: .cancel))
                present(ALERT, animated: true, completion: nil)
            }
        } else if indexPath.section == 2 {
            
            if indexPath.item == 0 {
                UIViewController.APPDELEGATE.AGREE_TITLE = "서비스 이용약관"; PRESENT_VC(IDENTIFIER: "VC_AGREEMENT", ANIMATED: true)
            } else if indexPath.item == 1 {
                UIViewController.APPDELEGATE.AGREE_TITLE = "개인정보 처리방침"; PRESENT_VC(IDENTIFIER: "VC_AGREEMENT", ANIMATED: true)
            } else if indexPath.item == 2 {
                S_NOTICE(":| 앱 버전(\(UIViewController.APPDELEGATE.SW_VERSION))")
            }
        }
    }
}

extension VC_SETTING: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
