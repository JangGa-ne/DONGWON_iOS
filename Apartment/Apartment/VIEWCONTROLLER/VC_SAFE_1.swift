//
//  VC_SAFE_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/22.
//

import UIKit

class VC_SAFE_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBAction func BACK_B(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    var OBJ_FAMILY: [FAMILY] = []
    var POSITION: Int = 0
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var TITLE_L: UILabel!
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var CUSTOM_V3: UIView!
    @IBOutlet weak var CUSTOM_V4: UIView!
    @IBOutlet weak var CUSTOM_V5: UIView!
    
    override func loadView() {
        super.loadView()
        
        if DEVICE_RATIO() { CUSTOM_V1.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15) }
        TITLE_L.titleFont(size: 18)
        
        CUSTOM_V2.layer.cornerRadius = 15; CUSTOM_V2.clipsToBounds = true
        CUSTOM_V5.layer.cornerRadius = 7.5; CUSTOM_V5.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CUSTOM_V3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CUSTOM_V3(_:))))
        CUSTOM_V4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CUSTOM_V4(_:))))
    }
    
    @objc func CUSTOM_V3(_ sender: UITapGestureRecognizer) {
        
        dismiss(animated: true) {
            if let BVC = UIViewController.APPDELEGATE.VC_SAFE_DEL {
                let VC = BVC.storyboard?.instantiateViewController(withIdentifier: "VC_LOCATE") as! VC_LOCATE
                VC.TITLE = "최근위치"; VC.OBJ_FAMILY = self.OBJ_FAMILY; VC.POSITION = self.POSITION
                BVC.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
    
    @objc func CUSTOM_V4(_ sender: UITapGestureRecognizer) {
        
        dismiss(animated: true) {
            if let BVC = UIViewController.APPDELEGATE.VC_SAFE_DEL {
                let VC = BVC.storyboard?.instantiateViewController(withIdentifier: "VC_LOCATE") as! VC_LOCATE
                VC.TITLE = "이동경로"; VC.OBJ_FAMILY = self.OBJ_FAMILY; VC.POSITION = self.POSITION
                BVC.navigationController?.pushViewController(VC, animated: true)
            }
        }
    }
}
