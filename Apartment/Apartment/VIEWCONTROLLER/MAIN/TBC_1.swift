//
//  TBC_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/04.
//

import UIKit

class TBC_1: UIViewController {
    
    let TRANSITION: S_ANIMATION = S_ANIMATION()
    
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
    
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var RESERVE_B1: UIButton!
    @IBOutlet weak var RESERVE_B2: UIButton!
    @IBOutlet weak var RESERVE_B3: UIButton!
    
    @IBOutlet weak var CUSTOM_V3: UIView!
    @IBOutlet weak var FACILITY_B: UIButton!
    @IBOutlet weak var CONTACT_B: UIButton!
    
    @IBOutlet weak var CUSTOM_V4: UIView!
    @IBOutlet weak var CCTV_B: UIButton!
    
    @IBOutlet weak var CUSTOM_V5: UIView!
    @IBOutlet weak var MEDICAL_B: UIButton!
    
    @IBOutlet weak var CUSTOM_V6: UIView!
    @IBOutlet weak var LEAFLET_B: UIButton!
    
    private var VIEWS1: [UIView] = []
    private var BTNS1: [UIButton] = []
    
    override func loadView() {
        super.loadView()
        
        BACKGROUND_I_HEIGHT.constant = UIViewController.STATUS_Y + 300
        
        NOTICE_B.addTarget(self, action: #selector(NOTICE_B(_:)), for: .touchUpInside)
        SETTING_B.addTarget(self, action: #selector(SETTING_B(_:)), for: .touchUpInside)
        NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(0.0); NAVI_L_BG.titleFont(size: 18); NAVI_L.titleFont(size: 18)
        NAVI_L.alpha = 0.0; NOTICE_I.alpha = 0.0; SETTING_I.alpha = 0.0
        
        CUSTOM_V1_HEIGHT.constant = 220
        
        VIEWS1 = [CUSTOM_V2, CUSTOM_V3, CUSTOM_V4, CUSTOM_V5, CUSTOM_V6]
        BTNS1 = [RESERVE_B1, RESERVE_B2, RESERVE_B3, FACILITY_B, CONTACT_B, CCTV_B, MEDICAL_B, LEAFLET_B]
        
        for VIEW in VIEWS1 { VIEW.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15) }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCROLLVIEW.delegate = self
        
        for (I, BTN) in BTNS1.enumerated() { BTN.tag = I; BTN.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside) }
    }
    
    @objc func S_BUTTON(_ sender: UIButton) {
        
        if sender.tag == 0 {
            PRESENT_VC(IDENTIFIER: "VC_RESERVE", ANIMATED: true)
        } else if sender.tag == 1 {
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_CARD") as! VC_CARD
            VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self
            present(VC, animated: true, completion: nil)
        } else if sender.tag == 2 {
            
        } else if sender.tag == 3 {
            PRESENT_VC(IDENTIFIER: "VC_RESTAURANT", ANIMATED: true)
        } else if sender.tag == 4 {
            PRESENT_VC(IDENTIFIER: "VC_CONTACT", ANIMATED: true)
        } else if sender.tag == 5 {
            PRESENT_VC(IDENTIFIER: "VC_CCTV", ANIMATED: true)
        } else if sender.tag == 6 {
            PRESENT_VC(IDENTIFIER: "VC_MEDICAL", ANIMATED: true)
        } else if sender.tag == 7 {
            UIViewController.APPDELEGATE.MENU = "우리마을전단지"
            PRESENT_VC(IDENTIFIER: "VC_SOSIK", ANIMATED: true)
        }
    }
}

extension TBC_1: UIScrollViewDelegate {
    
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
