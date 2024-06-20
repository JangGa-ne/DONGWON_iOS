//
//  VC_LOADING.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/23.
//

import UIKit

class VC_LOADING: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var ONOFF: Bool = false
    var UPDATE: Bool = false
    var PUSH: Bool = false
    
    var BD_KEY: String = ""
    var BD_TYPE: String = ""
    var FC_TYPE: String = ""
    var FC_NAME: String = ""
    var AP_SEQ: String = ""
    var AP_MSG_GROUP: String = ""
    
    @IBOutlet weak var ICON_IMG: UIImageView!
    @IBOutlet weak var TITLE_L1: UILabel!
    @IBOutlet weak var TITLE_L2: UILabel!
    
    override func loadView() {
        super.loadView()
        
        ICON_IMG.image = UIViewController.APPDELEGATE.APP_ICON
        TITLE_L1.titleFont(size: 24); TITLE_L1.text = UserDefaults.standard.string(forKey: "ap_name") ?? "비스타 동원"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let MB_ID: String = UserDefaults.standard.string(forKey: "mb_id") ?? ""
        let HOME_CODE: String = UserDefaults.standard.string(forKey: "home_code") ?? ""
        
        if !UPDATE && (MB_ID != "") && (HOME_CODE != "") {
//            GET_SWCHECK_DATA(NAME: "SW버전확인", AC_TYPE: "")
            GET_LOGIN(NAME: "로딩(로그인)", AC_TYPE: "login")
        } else if UPDATE && (MB_ID != "") && (HOME_CODE != "") {
            GET_LOGIN(NAME: "로딩(로그인)", AC_TYPE: "login")
        } else {
            PRESENT_VC(IDENTIFIER: "VC_PERMISSION", ANIMATED: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(false)
    }
}
