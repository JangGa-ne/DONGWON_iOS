//
//  VC_PROFILE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/09.
//

import UIKit

class VC_PROFILE: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func BACK_B(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var PROFILE_I: UIImageView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var ADDR_L: UILabel!
    
    @IBOutlet weak var EDIT_B: UIButton!
    
    override func loadView() {
        super.loadView()
        
        CUSTOM_V1.layer.cornerRadius = 15; CUSTOM_V1.clipsToBounds = true
        PROFILE_I.layer.borderWidth = 5; PROFILE_I.layer.borderColor = UIColor.white.cgColor
        PROFILE_I.layer.cornerRadius = PROFILE_I.frame.width/2; PROFILE_I.clipsToBounds = true
        PROFILE_I.image = UIImage(named: "profile.png")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (_, DATA) in UIViewController.APPDELEGATE.OBJ_LOGIN.enumerated() {
            
            SDWEBIMAGE(IV: PROFILE_I, IU: DATA.MB_PHOTO, PH: UIImage(named: "profile.png"), RD: PROFILE_I.frame.width/2, CM: .scaleAspectFill)
            
            NAME_L.text = "\(DATA.BK_NAME)(\(DATA.BK_NICK))"
            ADDR_L.text = "\(DATA.AP_NAME.replacingOccurrences(of: "아파트", with: "")) \(DATA.BUILDING_ID)동 \(DATA.HOUSE_NUMBER)호"
        }
        
        EDIT_B.addTarget(self, action: #selector(EDIT_B(_:)), for: .touchUpInside)
    }
    
    @objc func EDIT_B(_ sender: UIButton) {
        
        
    }
}
