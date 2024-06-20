//
//  VC_DONGHO.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/02.
//

import UIKit

class VC_DONGHO: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func BACK_B(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    
    var OBJ_SEARCH_D: [SEARCH_D] = []
    var ROW1: Int = 0
    var ROW2: Int = 0
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var EDIT_B: UIButton!
    @IBOutlet weak var PICKERVIEW: UIPickerView!
    
    override func loadView() {
        super.loadView()
        
        if DEVICE_RATIO() { CUSTOM_V1.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15) }
        
        EDIT_B.layer.cornerRadius = 15; EDIT_B.clipsToBounds = true
        
        PICKERVIEW.setValue(UIColor.black, forKey: "textColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PICKERVIEW.delegate = self; PICKERVIEW.dataSource = self
        
        EDIT_B.addTarget(self, action: #selector(EDIT_B(_:)), for: .touchUpInside)
    }
    
    @objc func EDIT_B(_ sender: UIButton) {
        
        if let BVC = UIViewController.APPDELEGATE.VC_SEARCH_DEL {
            BVC.isBack = true; BVC.viewWillAppear(true); BVC.ROW1 = ROW1; BVC.ROW2 = ROW2
        }
        dismiss(animated: true, completion: nil)
    }
}

extension VC_DONGHO: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 { return OBJ_SEARCH_D.count } else { return OBJ_SEARCH_D[ROW1].HOUSE_INFO.count }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 { return "\(OBJ_SEARCH_D[row].BUILDING_ID)동" } else { return "\(OBJ_SEARCH_D[ROW1].HOUSE_INFO[row])호" }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 { ROW1 = row; PICKERVIEW.reloadAllComponents() } else { ROW2 = row }
    }
}
