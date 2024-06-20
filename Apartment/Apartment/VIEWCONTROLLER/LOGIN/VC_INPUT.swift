//
//  VC_INPUT.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/01.
//

import UIKit

class VC_INPUT: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var OBJ_AUTH: [AUTH] = []
    var POSITION: Int = 0
    
    var AP_CODE: String = ""
    var BUILDING_ID: String = ""
    var HOUSE_NUMBER: String = ""
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    
    @IBOutlet weak var NICK_TF: UITextField!
    @IBOutlet weak var APT_B: UIButton!
    @IBOutlet weak var DONG_B: UIButton!
    @IBOutlet weak var HO_B: UIButton!
    
    @IBOutlet weak var DEMO_I: UIImageView!
    @IBOutlet weak var DEMO_L: UILabel!
    @IBOutlet weak var DEMO_B: UIButton!
    
    @IBOutlet weak var NEXT_B: UIButton!
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.VC_INPUT_DEL = self
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        
        NICK_TF.layer.cornerRadius = 7.5; NICK_TF.clipsToBounds = true
        NICK_TF.layer.borderWidth = 1; NICK_TF.layer.borderColor = UIColor.lightGray.cgColor
        NICK_TF.PADDING_LEFT(X: 10); PLACEHOLDER(TF: NICK_TF, PH: "닉네임을 입력해주세요.")
        APT_B.layer.cornerRadius = 7.5; APT_B.clipsToBounds = true
        APT_B.layer.borderWidth = 1; APT_B.layer.borderColor = UIColor.lightGray.cgColor
        DONG_B.layer.cornerRadius = 7.5; DONG_B.clipsToBounds = true
        DONG_B.layer.borderWidth = 1; DONG_B.layer.borderColor = UIColor.lightGray.cgColor
        HO_B.layer.cornerRadius = 7.5; HO_B.clipsToBounds = true
        HO_B.layer.borderWidth = 1; HO_B.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APT_B.tag = 0; APT_B.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
        DONG_B.tag = 1; DONG_B.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
        HO_B.tag = 1; HO_B.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
        DEMO_B.tag = 2; DEMO_B.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
        
        NEXT_B.addTarget(self, action: #selector(NEXT_B(_:)), for: .touchUpInside)
    }
    
    @objc func S_BUTTON(_ sender: UIButton) {
        
        view.endEditing(true)
        
        if sender.tag == 0 {
            PRESENT_VC(IDENTIFIER: "VC_SEARCH", ANIMATED: true)
        } else if sender.tag == 1 {
            ALERT(TITLE: "", BODY: ":( 아파트를 검색하여 동.호를 지정해 주세요.", STYLE: .alert)
        } else if sender.tag == 2 {
            
            if !sender.isSelected { sender.isSelected = true
                DEMO_I.image = UIImage(named: "check_on.png"); DEMO_L.alpha = 1.0
                AP_CODE = "K00000001"; BUILDING_ID = "1"; HOUSE_NUMBER = "407"
                APT_B.setTitle("   DEMO아파트", for: .normal); APT_B.setTitleColor(.black, for: .normal); APT_B.tag = 3
                DONG_B.setTitle("   999동", for: .normal); DONG_B.setTitleColor(.black, for: .normal)
                HO_B.setTitle("   999호", for: .normal); HO_B.setTitleColor(.black, for: .normal)
            } else { sender.isSelected = false
                DEMO_I.image = UIImage(named: "check_off.png"); DEMO_L.alpha = 0.7
                AP_CODE = ""; BUILDING_ID = ""; HOUSE_NUMBER = ""
                APT_B.setTitle("   아파트명을 입력해주세요.", for: .normal); APT_B.setTitleColor(.lightGray, for: .normal); APT_B.tag = 0
                DONG_B.setTitle("   동", for: .normal); DONG_B.setTitleColor(.lightGray, for: .normal)
                HO_B.setTitle("   호", for: .normal); HO_B.setTitleColor(.lightGray, for: .normal)
            }
        } else if sender.tag == 3 {
            ALERT(TITLE: "", BODY: ":( '체험단지 아파트로 시작하기'를 해제해 주세요.", STYLE: .alert)
        }
    }
    
    @objc func NEXT_B(_ sender: UIButton) {
        
        let DATA = OBJ_AUTH[POSITION]
        
        if NICK_TF.text! == "" || APT_B.titleLabel?.text! == "" || DONG_B.titleLabel?.text! == "" || HO_B.titleLabel?.text! == "" {
            ALERT(TITLE: nil, BODY: ":( 미입력된 항목이 있습니다.", STYLE: .actionSheet)
        } else if !DEMO_B.isSelected && (DATA.AP_CODE != AP_CODE || DATA.BUILDING_ID != BUILDING_ID || DATA.HOUSE_NUMBER != HOUSE_NUMBER) {
            ALERT(TITLE: "", BODY: ":( 미등록된 세대주 또는 세대원 입니다.\n관리사무소에 문의바랍니다.", STYLE: .alert)
        } else {
            PUT_INPUT(NAME: "정보입력(업데이트)", AC_TYPE: "update")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(false)
    }
}
