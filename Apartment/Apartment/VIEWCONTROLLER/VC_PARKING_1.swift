//
//  VC_PARKING_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/30.
//

import UIKit

class VC_PARKING_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var TITLE: String = ""
    var DATE: String = ""
    
    @IBAction func BACK_B(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var TITLE_L: UILabel!
    @IBOutlet weak var EDIT_B: UIButton!
    @IBOutlet weak var PICKERVIEW: UIDatePicker!
    
    override func loadView() {
        super.loadView()
        
        if DEVICE_RATIO() { CUSTOM_V1.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15) }
        TITLE_L.titleFont(size: 18); TITLE_L.text = TITLE
        EDIT_B.layer.cornerRadius = 15; EDIT_B.clipsToBounds = true
        
        PICKERVIEW.setValue(UIColor.black, forKey: "textColor"); PICKERVIEW.setValue(false, forKeyPath: "highlightsToday")
        PICKERVIEW.minimumDate = Date()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EDIT_B.addTarget(self, action: #selector(EDIT_B(_:)), for: .touchUpInside)
        PICKERVIEW.addTarget(self, action: #selector(PICKERVIEW(_:)), for: .valueChanged)
    }
    
    @objc func EDIT_B(_ sender: UIButton) {
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "VC_PARKING_2") as! VC_PARKING_2
        VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self; VC.TITLE = TITLE; VC.DATE = DATE
        present(VC, animated: true, completion: nil)
    }
        
    @objc func PICKERVIEW(_ sender: UIDatePicker) {
        DF.dateFormat = "yyyy-MM-dd"; DATE = DF.string(from: sender.date)
    }
}
