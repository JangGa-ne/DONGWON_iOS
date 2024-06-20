//
//  VC_CATEGORY.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/02.
//

import UIKit

class VC_CATEGORY: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func BACK_B(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    var TYPES: [String] = []
    var ROW: Int = 0
    
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
        
        if let BVC = UIViewController.APPDELEGATE.VC_WRITE_DEL {
            BVC.TYPE_B.setTitle("   \(TYPES[ROW])", for: .normal)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension VC_CATEGORY: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TYPES.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        TYPES[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ROW = row
    }
}
