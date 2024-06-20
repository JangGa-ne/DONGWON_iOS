//
//  VC_ELEVATOR_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/21.
//

import UIKit

/// E/V호출(요청)
class VC_ELEVATOR_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBAction func BACK_B(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    var TITLE: String = ""
    var FLOOR: [String] = []
    var POSITION: Int = 0
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var TITLE_L: UILabel!
    @IBOutlet weak var EDIT_B: UIButton!
    @IBOutlet weak var PICKERVIEW: UIPickerView!
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var EVUP_B: UIButton!
    @IBOutlet weak var CUSTOM_V3: UIView!
    @IBOutlet weak var EVDOWN_B: UIButton!
    
    override func loadView() {
        super.loadView()
        
        if DEVICE_RATIO() { CUSTOM_V1.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15) }
        
        TITLE_L.titleFont(size: 18); TITLE_L.text = TITLE
        EDIT_B.layer.cornerRadius = 15; EDIT_B.clipsToBounds = true
        
        PICKERVIEW.setValue(UIColor.black, forKey: "textColor")
        
        CUSTOM_V2.layer.cornerRadius = CUSTOM_V2.frame.width / 2
        EVUP_B.tag = 0; EVUP_B.addTarget(self, action: #selector(EV_CALL(_:)), for: .touchUpInside)
        CUSTOM_V3.layer.cornerRadius = CUSTOM_V3.frame.width / 2
        EVDOWN_B.tag = 1; EVDOWN_B.addTarget(self, action: #selector(EV_CALL(_:)), for: .touchUpInside)
    }
    
    @objc func EV_CALL(_ sender: UIButton) {
        
        UIImpactFeedbackGenerator().impactOccurred()
        
        if sender.tag == 0 {
            PUT_EVCALL(NAME: "EV호출(요청)", AC_TYPE: "call")
        } else if sender.tag == 1 {
            PUT_EVCALL(NAME: "EV호출(요청)", AC_TYPE: "call")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PICKERVIEW.delegate = self; PICKERVIEW.dataSource = self
    }
}

extension VC_ELEVATOR_1: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return FLOOR.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(FLOOR[row])층"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        POSITION = row
    }
}

