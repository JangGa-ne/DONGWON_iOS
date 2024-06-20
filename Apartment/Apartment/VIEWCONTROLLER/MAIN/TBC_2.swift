//
//  TBC_2.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/04.
//

import UIKit

class TBC_2: UIViewController {
    
    var ST_WHITE: Bool = false
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if !ST_WHITE { if #available(iOS 13.0, *) { return .darkContent } else { return .default } } else { return .lightContent }
    }
    
    @IBOutlet weak var BACKGROUND_I: UIImageView!
    @IBOutlet weak var BACKGROUND_I_HEIGHT: NSLayoutConstraint!
    @IBOutlet weak var NAVI_V: UIView!
    @IBOutlet weak var NAVI_L_BG: UILabel!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var NOTICE_I: UIImageView!
    @IBOutlet weak var NOTICE_B: UIButton!
    @IBOutlet weak var SETTING_I: UIImageView!
    @IBOutlet weak var SETTING_B: UIButton!
    
    @IBOutlet weak var SCROLLVIEW: UIScrollView!
    
    @IBOutlet weak var CUSTOM_V1_HEIGHT: NSLayoutConstraint!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var ADDR_L: UILabel!
    @IBOutlet weak var PROFILE_I: UIImageView!
    
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var WRITE_B: UIButton!
    @IBOutlet weak var VOTE_B: UIButton!
    @IBOutlet weak var COMPLAINTS_B: UIButton!
    
    @IBOutlet weak var CUSTOM_V3: UIView!
    @IBOutlet weak var DELIVERY_B: UIButton!
    
    @IBOutlet weak var CUSTOM_V4: UIView!
    @IBOutlet weak var ELEVATOR_B: UIButton!
    
    @IBOutlet weak var CUSTOM_V5: UIView!
    @IBOutlet weak var CHILD_B: UIButton!
    
    @IBOutlet weak var CUSTOM_V6: UIView!
    @IBOutlet weak var EXPENESE_B: UIButton!
    @IBOutlet weak var MONTH_L: UILabel!
    @IBOutlet weak var PAY_L: UILabel!
    
    @IBOutlet weak var CUSTOM_V7: UIView!
    @IBOutlet weak var PARKING_B: UIButton!
    @IBOutlet weak var PARKING_L1: UILabel!
    @IBOutlet weak var PARKING_L2: UILabel!
    
    @IBOutlet weak var CUSTOM_V8: UIView!
    @IBOutlet weak var EVCAR_B: UIButton!
    
    private var VIEWS1: [UIView] = []
    private var BTNS1: [UIButton] = []
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.TBC_2_DEL = self
        
        BACKGROUND_I_HEIGHT.constant = UIViewController.STATUS_Y + 300
        
        NOTICE_B.addTarget(self, action: #selector(NOTICE_B(_:)), for: .touchUpInside)
        SETTING_B.addTarget(self, action: #selector(SETTING_B(_:)), for: .touchUpInside)
        NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(0.0); NAVI_L_BG.titleFont(size: 18); NAVI_L.titleFont(size: 18)
        NAVI_L.alpha = 0.0; NOTICE_I.alpha = 0.0; SETTING_I.alpha = 0.0
        
        CUSTOM_V1_HEIGHT.constant = 220
        PROFILE_I.layer.borderWidth = 5; PROFILE_I.layer.borderColor = UIColor.white.cgColor
        PROFILE_I.layer.cornerRadius = PROFILE_I.frame.width/2; PROFILE_I.clipsToBounds = true
        PROFILE_I.image = UIImage(named: "profile.png")
        
        VIEWS1 = [CUSTOM_V2, CUSTOM_V3, CUSTOM_V4, CUSTOM_V5, CUSTOM_V6, CUSTOM_V7, CUSTOM_V8]
        BTNS1 = [WRITE_B, VOTE_B, COMPLAINTS_B, DELIVERY_B, ELEVATOR_B, CHILD_B, EXPENESE_B, PARKING_B, EVCAR_B]
        
        for BTN in BTNS1 { BTN.layer.cornerRadius = 7.5; BTN.clipsToBounds = true }
        
        for VIEW in VIEWS1 { VIEW.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCROLLVIEW.delegate = self
        
        for (_, DATA) in UIViewController.APPDELEGATE.OBJ_LOGIN.enumerated() {
            
            NAME_L.text = "\(DATA.BK_NAME)(\(DATA.BK_NICK))"
            ADDR_L.text = "\(DATA.AP_NAME.replacingOccurrences(of: "아파트", with: "")) \(DATA.BUILDING_ID)동 \(DATA.HOUSE_NUMBER)호"
            
            SDWEBIMAGE(IV: PROFILE_I, IU: DATA.MB_PHOTO, PH: UIImage(named: "profile.png"), RD: PROFILE_I.frame.width/2, CM: .scaleAspectFill)
        }
        
        for (I, BTN) in BTNS1.enumerated() { BTN.tag = I; BTN.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside) }
        
        let DATA2 = UIViewController.APPDELEGATE.OBJ_EXPENESE
        
        MONTH_L.text = FM_CUSTOM(DATA2.TARGET_MONTH, "YY년 MM월 청구요금")
        if DATA2.AMOUNT == "0" || DATA2.AMOUNT == "" {
            PAY_L.text = "관리비 내역이 없습니다."
        } else {
            PAY_L.text = "\(DT_CHECK(NF.string(from: (Int(DATA2.AMOUNT) ?? 0) as NSNumber) ?? ""))원"
        }
        
        let DATA3 = UIViewController.APPDELEGATE.OBJ_PARKING
        
        PARKING_L1.text = DATA3.TEMP_CAR
        PARKING_L2.text = DATA3.PERM_CAR
    }
    
    @objc func S_BUTTON(_ sender: UIButton) {
        
        if sender.tag == 0 {
            UIViewController.APPDELEGATE.MENU = "나의게시글"
            PRESENT_VC(IDENTIFIER: "VC_SOSIK", ANIMATED: true)
        } else if sender.tag == 1 {
            UIViewController.APPDELEGATE.MENU = "투표"
            PRESENT_VC(IDENTIFIER: "VC_SOSIK", ANIMATED: true)
        } else if sender.tag == 2 {
            UIViewController.APPDELEGATE.MENU = "민원·수리·신고"
            PRESENT_VC(IDENTIFIER: "VC_SOSIK", ANIMATED: true)
        } else if sender.tag == 3 {
            PRESENT_VC(IDENTIFIER: "VC_DELIVERY", ANIMATED: true)
        } else if sender.tag == 4 {
            PRESENT_VC(IDENTIFIER: "VC_ELEVATOR", ANIMATED: true)
        } else if sender.tag == 5 {
            PRESENT_VC(IDENTIFIER: "VC_SAFE", ANIMATED: true)
        } else if sender.tag == 6 {
            PRESENT_VC(IDENTIFIER: "VC_EXPENESE", ANIMATED: true)
        } else if sender.tag == 7 {
            PRESENT_VC(IDENTIFIER: "VC_PARKING", ANIMATED: true)
        } else if sender.tag == 8 {
            PRESENT_VC(IDENTIFIER: "VC_EVCAR", ANIMATED: true)
        }
    }
}

extension TBC_2: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        
        BACKGROUND_I_HEIGHT.constant = -OFFSET_Y + UIViewController.STATUS_Y + 300
        
        if OFFSET_Y <= 0 {
            ST_WHITE = false; setNeedsStatusBarAppearanceUpdate()
            NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(0.0)
            NAVI_L.alpha = 0.0; NOTICE_I.alpha = 0.0; SETTING_I.alpha = 0.0
        } else {
            ST_WHITE = true; setNeedsStatusBarAppearanceUpdate()
            NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(OFFSET_Y/300)
            NAVI_L.alpha = OFFSET_Y/300; NOTICE_I.alpha = OFFSET_Y/300; SETTING_I.alpha = OFFSET_Y/300
        }
    }
}
