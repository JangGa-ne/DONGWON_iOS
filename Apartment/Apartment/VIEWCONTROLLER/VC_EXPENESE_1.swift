//
//  VC_EXPENESE_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/30.
//

import UIKit

/// 관리비(디테일)
class VC_EXPENESE_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func BACK_B(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    var DATE: String = ""
    
    let YEARS: [String] = ["2026년", "2025년", "2024년", "2023년", "2022년", "2021년", "2020년", "2019년"]
    var ROW1: Int = 0
    let MONTHS: [String] = ["01월", "02월", "03월", "04월", "05월", "06월", "07월", "08월", "09월", "10월", "11월", "12월"]
    var ROW2: Int = 0
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var DATE_L: UILabel!
    @IBOutlet weak var EDIT_B: UIButton!
    @IBOutlet weak var PICKERVIEW: UIPickerView!
    
    override func loadView() {
        super.loadView()
        
        if DEVICE_RATIO() { CUSTOM_V1.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15) }
        
        DATE_L.titleFont(size: 18); DATE_L.text = DATE
        EDIT_B.layer.cornerRadius = 15; EDIT_B.clipsToBounds = true
        
        PICKERVIEW.setValue(UIColor.black, forKey: "textColor")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PICKERVIEW.delegate = self; PICKERVIEW.dataSource = self
        
        for i in 0 ..< YEARS.count {
            for ii in 0 ..< MONTHS.count {
                if "\(YEARS[i]) \(MONTHS[ii])".contains(DATE) {
                    PICKERVIEW.selectRow(i, inComponent: 0, animated: true); PICKERVIEW.selectRow(ii, inComponent: 1, animated: true)
                    pickerView(PICKERVIEW, didSelectRow: i, inComponent: 0); pickerView(PICKERVIEW, didSelectRow: ii, inComponent: 1)
                }
            }
        }
        
        EDIT_B.addTarget(self, action: #selector(EDIT_B(_:)), for: .touchUpInside)
    }
    
    @objc func EDIT_B(_ sender: UIButton) {
        
        if let BVC = UIViewController.APPDELEGATE.VC_EXPENESE_DEL {
            BVC.DATE_L.text = DATE_L.text!
            BVC.TABLEVIEW.contentOffset = CGPoint(x: 0, y: -44)
            if BVC.MN_POSITION == 0 { BVC.GET_EXPENESE_L1(NAME: "관리비내역", AC_TYPE: "overview", TARGET_MONTH: YEARS[ROW1]+MONTHS[ROW2]) }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension VC_EXPENESE_1: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 { return YEARS.count } else { return MONTHS.count }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 { return "\(YEARS[row])" } else { return "\(MONTHS[row])" }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 { ROW1 = row } else { ROW2 = row }
        DATE_L.text = "\(YEARS[ROW1]) \(MONTHS[ROW2])"
    }
}
