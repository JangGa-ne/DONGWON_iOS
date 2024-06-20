//
//  VC_CARD.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/12.
//

import UIKit

/// 출입증
class VC_CARD: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBAction func BACK_B(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    @IBOutlet weak var CUSTOM_V1: UIVisualEffectView!
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var CODEVIEW: UICodeView!
    @IBOutlet weak var TITLE_L: UILabel!
    @IBOutlet weak var NAME_L1: UILabel!
    @IBOutlet weak var NAME_L2: UILabel!
    
    override func loadView() {
        super.loadView()
        
        CUSTOM_V1.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 15)
        CUSTOM_V2.layer.cornerRadius = 7.5; CUSTOM_V2.clipsToBounds = true
        CUSTOM_V2.layer.borderWidth = 4; CUSTOM_V2.layer.borderColor = UIColor.H_4E177C.cgColor
        TITLE_L.titleFont(size: 30)
        
        let HOME_CODE = UserDefaults.standard.string(forKey: "home_code") ?? ""
        
        if let IMAGE = CODEVIEW.setSegmentedWith(code: HOME_CODE, type: .QR, size: CODEVIEW.frame.size) {
            CODEVIEW.thumbView.image = IMAGE
        } else {
            CODEVIEW.thumbView.image = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIViewController.APPDELEGATE.OBJ_LOGIN.count > 0 {
            
            let DATA = UIViewController.APPDELEGATE.OBJ_LOGIN[0]
            
            NAME_L1.text = DT_CHECK(DATA.BK_NAME)
            NAME_L2.text = "\(DATA.AP_NAME.replacingOccurrences(of: "아파트", with: "")) \(DATA.BUILDING_ID)동 \(DATA.HOUSE_NUMBER)호"
        } else {
            S_NOTICE(":( 사용할 수 없음"); dismiss(animated: true, completion: nil)
        }
    }
}
