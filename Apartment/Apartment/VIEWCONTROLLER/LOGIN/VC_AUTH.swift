//
//  VC_AUTH.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/24.
//

import UIKit

class VC_AUTH: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var OBJ_AUTH: [AUTH] = []
    var SIGNCHECK: Bool = false
    
    @IBOutlet weak var TITLE_L: UILabel!
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var NUMBER_TF1: UITextField!
    @IBOutlet weak var NUMBER_V1: UIView!
    @IBOutlet weak var NUMBER_B1: UIButton!
    @IBOutlet weak var NUMBER_TF2: UITextField!
    @IBOutlet weak var NUMBER_V2: UIView!
    @IBOutlet weak var NUMBER_B2: UIButton!
    @IBOutlet weak var CUSTOM_V1_1: UIView!
    @IBOutlet weak var SIGN_B1: UIButton!
    @IBOutlet weak var CUSTOM_V1_2: UIStackView!
    @IBOutlet weak var SIGN_B2: UIButton!
    
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var AGREE_I1: UIImageView!
    @IBOutlet weak var AGREE_L1: UILabel!
    @IBOutlet weak var AGREE_B1: UIButton!
    @IBOutlet weak var AGREE_I2: UIImageView!
    @IBOutlet weak var AGREE_L2: UILabel!
    @IBOutlet weak var AGREE_B2: UIButton!
    @IBOutlet weak var AGREE_I3: UIImageView!
    @IBOutlet weak var AGREE_L3: UILabel!
    @IBOutlet weak var AGREE_B3: UIButton!
    
    @IBOutlet weak var NEXT_B: UIButton!
    
    override func loadView() {
        super.loadView()
        
        CUSTOM_V1.layer.cornerRadius = 15; CUSTOM_V1.clipsToBounds = true
        
        PLACEHOLDER(TF: NUMBER_TF1, PH: "전화번호를 입력하세요."); NUMBER_V1.isHidden = true
        PLACEHOLDER(TF: NUMBER_TF2, PH: "인증번호를 입력하세요."); NUMBER_V2.isHidden = true
        
        CUSTOM_V1_1.isHidden = false; CUSTOM_V1_2.isHidden = true
        
        CUSTOM_V2.layer.cornerRadius = 15; CUSTOM_V2.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NUMBER_TF1.tag = 13
        NUMBER_TF1.addTarget(self, action: #selector(MAX_TEXT(_:)), for: .editingChanged)
        NUMBER_TF1.addTarget(self, action: #selector(S_TEXT(_:)), for: .editingChanged)
        NUMBER_B1.tag = 0; NUMBER_B1.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
        NUMBER_TF2.tag = 6
        NUMBER_TF2.addTarget(self, action: #selector(MAX_TEXT(_:)), for: .editingChanged)
        NUMBER_TF2.addTarget(self, action: #selector(S_TEXT(_:)), for: .editingChanged)
        NUMBER_B2.tag = 1; NUMBER_B2.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
        
        SIGN_B1.tag = 2; SIGN_B1.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
        SIGN_B2.tag = 0; SIGN_B2.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
        
        let AGREES: [UIButton] = [AGREE_B1, AGREE_B2, AGREE_B3]
        for i in 0 ..< AGREES.count { AGREES[i].tag = i+3; AGREES[i].addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside) }
        
        NEXT_B.tag = 6; NEXT_B.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
    }
    
    @objc func S_TEXT(_ sender: UITextField) {
        
        SIGNCHECK = false; guard let TEXT = sender.text else { return }
        
        if sender == NUMBER_TF1 {
            
            sender.text = NUMBER(sender.text!.replacingOccurrences(of: "-", with: "").count, sender.text!.replacingOccurrences(of: "-", with: ""))
            NUMBER_TF2.text?.removeAll(); NUMBER_V2.isHidden = true; CUSTOM_V1_1.isHidden = false; CUSTOM_V1_2.isHidden = true
            
            if TEXT.count > 0 { NUMBER_V1.isHidden = false } else { NUMBER_V1.isHidden = true }
        } else if sender == NUMBER_TF2 {
            if TEXT.count > 0 { NUMBER_V1.isHidden = true; NUMBER_V2.isHidden = false } else { NUMBER_V1.isHidden = false; NUMBER_V2.isHidden = true }
        }
    }
    
    @objc func S_BUTTON(_ sender: UIButton) {
        
        if sender.tag == 0 {            // 인증번호(요청,재발급)
            
            if NUMBER_TF1.text!.count < NUMBER_TF1.tag {
                ALERT(TITLE: "", BODY: ":( 전화번호 형식이 맞지 않습니다.", STYLE: .alert)
            } else {
                PUT_AUTH(NAME: "본인인증(요청)", AC_TYPE: "request")
            }
        } else if sender.tag == 1 {     // 인증번호(확인)
            
            if NUMBER_TF2.text!.count < NUMBER_TF2.tag {
                ALERT(TITLE: "", BODY: ":( 인증번호 형식이 맞지 않습니다.", STYLE: .alert)
            } else {
                PUT_AUTH(NAME: "본인인증(확인)", AC_TYPE: "check")
            }
        } else if sender.tag == 2 {     // 무제
            ALERT(TITLE: "", BODY: ":| 웹페이지에서 가입하세요", STYLE: .alert)
        } else if sender.tag == 3 {     // 약관동의(전체)
            
            if !sender.isSelected { AGREE_B1.isSelected = true; AGREE_B2.isSelected = true; AGREE_B3.isSelected = true
                AGREE_I1.image = UIImage(named: "check_on.png"); AGREE_L1.alpha = 1.0
                AGREE_I2.image = UIImage(named: "check_on.png"); AGREE_L2.alpha = 1.0
                AGREE_I3.image = UIImage(named: "check_on.png"); AGREE_L3.alpha = 1.0
            } else { AGREE_B1.isSelected = false; AGREE_B2.isSelected = false; AGREE_B3.isSelected = false
                AGREE_I1.image = UIImage(named: "check_off.png"); AGREE_L1.alpha = 0.7
                AGREE_I2.image = UIImage(named: "check_off.png"); AGREE_L2.alpha = 0.7
                AGREE_I3.image = UIImage(named: "check_off.png"); AGREE_L3.alpha = 0.7
            }
        } else if sender.tag == 4 {     // 약관동의(1)
            
            if !sender.isSelected { sender.isSelected = true
                UIViewController.APPDELEGATE.AGREE_TITLE = "개인정보 처리방침"; PRESENT_VC(IDENTIFIER: "VC_AGREEMENT", ANIMATED: true)
                if AGREE_B3.isSelected { AGREE_I1.image = UIImage(named: "check_on.png"); AGREE_L1.alpha = 1.0 }
                AGREE_I2.image = UIImage(named: "check_on.png"); AGREE_L2.alpha = 1.0
            } else { sender.isSelected = false
                AGREE_I1.image = UIImage(named: "check_off.png"); AGREE_L1.alpha = 0.7
                AGREE_I2.image = UIImage(named: "check_off.png"); AGREE_L2.alpha = 0.7
            }
        } else if sender.tag == 5 {     // 약관동의(2)
            
            if !sender.isSelected { sender.isSelected = true
                UIViewController.APPDELEGATE.AGREE_TITLE = "서비스 이용약관"; PRESENT_VC(IDENTIFIER: "VC_AGREEMENT", ANIMATED: true)
                if AGREE_B2.isSelected { AGREE_I1.image = UIImage(named: "check_on.png"); AGREE_L1.alpha = 1.0 }
                AGREE_I3.image = UIImage(named: "check_on.png"); AGREE_L3.alpha = 1.0
            } else { sender.isSelected = false
                AGREE_I1.image = UIImage(named: "check_off.png"); AGREE_L1.alpha = 0.7
                AGREE_I3.image = UIImage(named: "check_off.png"); AGREE_L3.alpha = 0.7
            }
        } else if sender.tag == 6 {     // 로그인
            if !SIGNCHECK {
                ALERT(TITLE: nil, BODY: ":( 본인인증을 하지 않았습니다.", STYLE: .actionSheet)
            } else if !(AGREE_B2.isSelected && AGREE_B3.isSelected) {
                ALERT(TITLE: nil, BODY: ":( 이용약관 미동의 항목이 있습니다.", STYLE: .actionSheet)
            } else {
//                let VC = storyboard?.instantiateViewController(withIdentifier: "VC_INPUT") as! VC_INPUT
//                VC.OBJ_AUTH = OBJ_AUTH; VC.POSITION = 0
//                navigationController?.pushViewController(VC, animated: true)\
                if OBJ_AUTH.count > 0 {
                    UserDefaults.standard.setValue(OBJ_AUTH[0].BK_NAME, forKey: "bk_name")
                    UserDefaults.standard.setValue(OBJ_AUTH[0].BK_NICK, forKey: "bk_nick")
                    UserDefaults.standard.setValue(OBJ_AUTH[0].AP_CODE, forKey: "ap_code")
                    UserDefaults.standard.setValue(OBJ_AUTH[0].AP_NAME.replacingOccurrences(of: "아파트", with: ""), forKey: "ap_name")
                    UserDefaults.standard.setValue(OBJ_AUTH[0].BUILDING_ID, forKey: "building_id")
                    UserDefaults.standard.setValue(OBJ_AUTH[0].HOUSE_NUMBER, forKey: "house_number")
                    UserDefaults.standard.setValue(OBJ_AUTH[0].HOME_CODE, forKey: "home_code")
                } else {
                    UserDefaults.standard.setValue("체험판(이름)", forKey: "bk_name")
                    UserDefaults.standard.setValue("체험판(iOS)", forKey: "bk_nick")
                    UserDefaults.standard.setValue("K00000001", forKey: "ap_code")
                    UserDefaults.standard.setValue("체험판(아파트)", forKey: "ap_name")
                    UserDefaults.standard.setValue("1", forKey: "building_id")
                    UserDefaults.standard.setValue("407", forKey: "house_number")
                    UserDefaults.standard.setValue("K000000011407", forKey: "home_code")
                }
                self.PRESENT_VC(IDENTIFIER: "VC_LOADING", ANIMATED: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(false)
    }
}
