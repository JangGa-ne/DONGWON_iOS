//
//  TBC_0.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/04.
//

import UIKit
import FirebaseMessaging

class TBC_0_CC: UICollectionViewCell {
    
    @IBOutlet weak var MENU_I: UIImageView!
    @IBOutlet weak var MENU_L: UILabel!
}

class TBC_0: UIViewController {
    
    var ST_WHITE: Bool = false
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if !ST_WHITE { if #available(iOS 13.0, *) { return .darkContent } else { return .default } } else { return .lightContent }
    }
    
    var OBJ_MAINMENU: [ALLMENU_L] = []
    
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
    @IBOutlet weak var LOGO_I: UIImageView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var ADDR_L: UILabel!
    @IBOutlet weak var TEMP_L: UILabel!
    
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var COLLECTIONVIEW: UICollectionView!
    @IBOutlet weak var COLLECTIONVIEW_HEIGHT: NSLayoutConstraint!
    
    @IBOutlet weak var CUSTOM_V3: UIView!
    @IBOutlet weak var CUSTOM_SV1: UIStackView!
    @IBOutlet weak var MORE_B1: UIButton!
    
    @IBOutlet weak var CUSTOM_V4: UIView!
    @IBOutlet weak var CUSTOM_SV2: UIStackView!
    @IBOutlet weak var MORE_B2: UIButton!
    
    @IBOutlet weak var CUSTOM_V5: UIView!
    @IBOutlet weak var CUSTOM_SV3: UIStackView!
    @IBOutlet weak var MORE_B3: UIButton!
    
    @IBOutlet weak var CUSTOM_V6: UIView!
    @IBOutlet weak var CUSTOM_SV4: UIStackView!
    @IBOutlet weak var MORE_B4: UIButton!
    
    private var VIEWS1: [UIView] = []
    private var VIEWS2: [UIView] = []
    private var BTNS1: [UIButton] = []
    private var STACKS1: [UIStackView] = []
    
    override func loadView() {
        super.loadView()
        
        for DATA in UIViewController.APPDELEGATE.OBJ_LOGIN {
            
            Messaging.messaging().subscribe(toTopic: "CENTER")
            Messaging.messaging().subscribe(toTopic: DATA.MB_ID)
            Messaging.messaging().subscribe(toTopic: DATA.AP_CODE)
            Messaging.messaging().subscribe(toTopic: DATA.AP_CODE+DATA.BUILDING_ID)
            Messaging.messaging().subscribe(toTopic: DATA.HOME_CODE)
            Messaging.messaging().subscribe(toTopic: DATA.SC_CITY)
            Messaging.messaging().subscribe(toTopic: DATA.SD_CODE)
        }
        
        BACKGROUND_I_HEIGHT.constant = UIViewController.STATUS_Y + 300
        
        NOTICE_B.addTarget(self, action: #selector(NOTICE_B(_:)), for: .touchUpInside)
        SETTING_B.addTarget(self, action: #selector(SETTING_B(_:)), for: .touchUpInside)
        NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(0.0); NAVI_L_BG.titleFont(size: 18); NAVI_L.titleFont(size: 18)
        NAVI_L.alpha = 0.0; NOTICE_I.alpha = 0.0; SETTING_I.alpha = 0.0
        
        CUSTOM_V1_HEIGHT.constant = 220
        
        VIEWS1 = [CUSTOM_V2, CUSTOM_V3, CUSTOM_V4, CUSTOM_V5, CUSTOM_V6]
        VIEWS2 = [UIView(), UIView(), UIView(), UIView()]
        BTNS1 = [MORE_B1, MORE_B2, MORE_B3, MORE_B4]
        STACKS1 = [CUSTOM_SV1, CUSTOM_SV2, CUSTOM_SV3, CUSTOM_SV4]
        
        for VIEW in VIEWS1 { VIEW.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15) }
        for BTN in BTNS1 { BTN.layer.cornerRadius = 10; BTN.clipsToBounds = true; BTN.layer.borderColor = UIColor.darkGray.cgColor; BTN.layer.borderWidth = 1 }
        for (I, VIEW) in VIEWS2.enumerated() { VIEW.backgroundColor = .clear; STACKS1[I].addArrangedSubview(VIEW) }
        
        let LAYOUT = UICollectionViewFlowLayout()
        LAYOUT.minimumInteritemSpacing = 10; LAYOUT.minimumLineSpacing = 10; LAYOUT.scrollDirection = .vertical
        COLLECTIONVIEW.setCollectionViewLayout(LAYOUT, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCROLLVIEW.delegate = self
        
        LOGO_I.image = UIViewController.APPDELEGATE.APP_ICON
        NAME_L.text = UIViewController.APPDELEGATE.APP_NAME
        
        for (_, DATA) in UIViewController.APPDELEGATE.OBJ_WEATHER.enumerated() {
            NAME_L.text = DT_CHECK(DATA.AP_NAME.replacingOccurrences(of: "아파트", with: ""))
            ADDR_L.text = DT_CHECK(DATA.AP_ADDR)
        }
        
        COLLECTIONVIEW.delegate = self; COLLECTIONVIEW.dataSource = self; COLLECTIONVIEW.isScrollEnabled = false
        
        for (I, DATA) in UIViewController.APPDELEGATE.OBJ_ALLMENU.enumerated() {
            if DATA.DISPLAY_MAIN == "Y" { OBJ_MAINMENU.append(UIViewController.APPDELEGATE.OBJ_ALLMENU[I]) }
        }; COLLECTIONVIEW.reloadData()
        
        for (I, BTN) in BTNS1.enumerated() { BTN.tag = I; BTN.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside) }
        
        for (I, DATA) in UIViewController.APPDELEGATE.OBJ_SOSIK1.enumerated() {
            
            let STACK_H = UIStackView(); STACK_H.axis = .horizontal; STACK_H.spacing = 5
            
            let TYPE_L = UILabel(); TYPE_L.heightAnchor.constraint(equalToConstant: 20).isActive = true
            if (DATA.ARRAY_CNT != 2 && DATA.BOARD_NAME == "") || (DATA.ARRAY_CNT == 2 && DATA.CC_NAME == "") { TYPE_L.isHidden = true } else { TYPE_L.isHidden = false }
            TYPE_L.layer.cornerRadius = 10; TYPE_L.clipsToBounds = true
            TYPE_L.textAlignment = .center; TYPE_L.font = .boldSystemFont(ofSize: 10)
            if DATA.ARRAY_CNT == 0 {
                TYPE_L.backgroundColor = .H_4895CF.withAlphaComponent(0.3); TYPE_L.textColor = .H_4895CF.withAlphaComponent(1.0)
            } else if DATA.ARRAY_CNT == 1 {
                TYPE_L.backgroundColor = .H_FFAC0F.withAlphaComponent(0.3); TYPE_L.textColor = .H_FFAC0F.withAlphaComponent(1.0)
            } else if DATA.ARRAY_CNT == 2 {
                TYPE_L.backgroundColor = .H_61C0A7.withAlphaComponent(0.3); TYPE_L.textColor = .H_61C0A7.withAlphaComponent(1.0)
            } else if DATA.ARRAY_CNT == 3 {
                TYPE_L.backgroundColor = .H_FC7667.withAlphaComponent(0.3); TYPE_L.textColor = .H_FC7667.withAlphaComponent(1.0)
            }
            if DATA.ARRAY_CNT == 0 || DATA.ARRAY_CNT == 3 {
                TYPE_L.text = DT_CHECK(DATA.BOARD_NAME.replacingOccurrences(of: " ", with: ""))
            } else if DATA.ARRAY_CNT == 1 {
                TYPE_L.text = DT_CHECK(DATA.AP_SUBJECT)
            } else if DATA.ARRAY_CNT == 2 {
                TYPE_L.text = DT_CHECK(DATA.CC_NAME)
            }
            TYPE_L.widthAnchor.constraint(equalToConstant: CGFloat(TYPE_L.text!.count*10+10)).isActive = true
            STACK_H.addArrangedSubview(TYPE_L)
            
            let SOSIK_B = UIButton(); SOSIK_B.heightAnchor.constraint(equalToConstant: 20).isActive = true
            SOSIK_B.titleLabel?.font = .systemFont(ofSize: 14); SOSIK_B.contentHorizontalAlignment = .left; SOSIK_B.alpha = 0.7
            SOSIK_B.setTitleColor(.black, for: .normal); SOSIK_B.setTitle(DT_CHECK("· \(ENCODE(DATA.AP_SUBJECT_TEXT))"), for: .normal)
            if DATA.ARRAY_CNT == 1 { SOSIK_B.setTitle(DT_CHECK("· \(ENCODE(DATA.AP_SUBJECT))"), for: .normal) }
            SOSIK_B.tag = 10+I; SOSIK_B.addTarget(self, action: #selector(S_BUTTON(_:)), for: .touchUpInside)
            STACK_H.addArrangedSubview(SOSIK_B)
            
            if DATA.ARRAY_CNT == 0 {
                STACKS1[0].spacing = 5; CUSTOM_SV1.addArrangedSubview(STACK_H)
            } else if DATA.ARRAY_CNT == 1 {
                STACKS1[1].spacing = 5; CUSTOM_SV2.addArrangedSubview(STACK_H)
            } else if DATA.ARRAY_CNT == 2 {
                STACKS1[2].spacing = 5; CUSTOM_SV3.addArrangedSubview(STACK_H)
            } else if DATA.ARRAY_CNT == 3 {
                STACKS1[3].spacing = 5; CUSTOM_SV4.addArrangedSubview(STACK_H)
            }
        }
    }
    
    @objc func S_BUTTON(_ sender: UIButton) {
        
        if sender.tag < 10 {
            
            if sender.tag == 0 {
                UIViewController.APPDELEGATE.MENU = "아파트알림장"
            } else if sender.tag == 1 {
                UIViewController.APPDELEGATE.MENU = "아파트일정"
            } else if sender.tag == 2 {
                UIViewController.APPDELEGATE.MENU = "커뮤니티"
            } else if sender.tag == 3 {
                UIViewController.APPDELEGATE.MENU = "마을소식"
            }
            
            PRESENT_VC(IDENTIFIER: "VC_SOSIK", ANIMATED: true)
        } else {
            
            let DATA = UIViewController.APPDELEGATE.OBJ_SOSIK1[sender.tag-10]
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_SOSIK_1") as! VC_SOSIK_1
            VC.BD_TYPE = DATA.BOARD_TYPE; VC.AP_SEQ = DATA.AP_SEQ; VC.AP_MSG_GROUP = DATA.AP_MSG_GROUP
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        COLLECTIONVIEW.reloadData()
        
        UIViewController.APPDELEGATE.VC_SOSIK_DEL = nil
        UIViewController.APPDELEGATE.VC_COMMUNITY_1_DEL = nil
    }
}

extension TBC_0: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if OBJ_MAINMENU.count >= 8 {
            return 8
        } else if OBJ_MAINMENU.count > 0 && OBJ_MAINMENU.count <= 8 {
            return OBJ_MAINMENU.count
        } else {
            NODATA(RECT: COLLECTIONVIEW, MESSAGE: "메뉴 준비중..."); return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let DATA = OBJ_MAINMENU[indexPath.item]
        let CELL = collectionView.dequeueReusableCell(withReuseIdentifier: "TBC_0_CC", for: indexPath) as! TBC_0_CC
        
        SDWEBIMAGE(IV: CELL.MENU_I, IU: DATA.ICON_IMG, PH: UIImage(named: "profile.png"), RD: CELL.MENU_I.frame.width/2, CM: .scaleAspectFit)
        CELL.MENU_L.text = DT_CHECK(DATA.FUNCTION_NAME.replacingOccurrences(of: " ", with: ""))
        
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let DATA = OBJ_MAINMENU[indexPath.item]
        for (KEY, VALUE) in UIViewController.APPDELEGATE.MENUS {
            if VALUE != "VC_AA" && KEY == DATA.FUNCTION_NAME.replacingOccurrences(of: " ", with: "") {
                UIViewController.APPDELEGATE.MENU = KEY; PRESENT_VC(IDENTIFIER: VALUE, ANIMATED: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        COLLECTIONVIEW_HEIGHT.constant = (collectionView.frame.width/4-10+25)*2+10
        return CGSize(width: collectionView.frame.width/4-10, height: collectionView.frame.width/4-10+25)
    }
}

extension TBC_0: UIScrollViewDelegate {
    
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
