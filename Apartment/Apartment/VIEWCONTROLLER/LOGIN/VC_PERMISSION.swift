//
//  VC_PERMISSION.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/23.
//

import UIKit
import UserNotifications

class VC_PERMISSION: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var TITLE_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var SCROLLVIEW: UIScrollView!
    @IBOutlet weak var LOGIN_VC: UIButton!
    
    override func loadView() {
        super.loadView()
        
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; TITLE_L.titleFont(size: 30); LINE_V.alpha = 0.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCROLLVIEW.delegate = self
        
        LOGIN_VC.addTarget(self, action: #selector(LOGIN_VC(_:)), for: .touchUpInside)
    }
    
    @objc func LOGIN_VC(_ sender: UIButton) {
        
        // 위치
        UIViewController.APPDELEGATE.LOC_MANAGER.requestAlwaysAuthorization()
        
        PRESENT_VC(IDENTIFIER: "VC_AUTH", ANIMATED: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(false)
    }
}

extension VC_PERMISSION: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
