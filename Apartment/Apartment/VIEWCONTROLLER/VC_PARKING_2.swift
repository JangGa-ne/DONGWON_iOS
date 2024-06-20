//
//  VC_PARKING_2.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/16.
//

import UIKit

class VC_PARKING_2: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var TITLE: String = ""
    var DATE: String = ""
    var CHECK_1: Bool = false
    var CHECK_2: Bool = false
    var CHECK_3: Bool = false
    
    let MIDDLES: [String] = ["가", "나", "다", "라", "마", "거", "너", "더", "러", "머", "버", "서", "어", "저", "고", "노", "도", "로", "모", "보", "소", "오", "조", "구", "누", "두", "루", "무", "부", "수", "우", "주", "하", "허", "호", "배", "아", "바", "사", "자"]
    let CITYS: [String] = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"]
    
    @IBAction func BACK_B(_ sender: UIButton) { dismiss(animated: true, completion: nil) }
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var TITLE_L: UILabel!
    @IBOutlet weak var BACK_B: UIButton!
    @IBOutlet weak var EDIT_B: UIButton!
    
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var CITY_TV: UITextView!
    @IBOutlet weak var NUMBER_TF1: UITextField!
    @IBOutlet weak var NUMBER_TF2: UITextField!
    @IBOutlet weak var NUMBER_TF3: UITextField!
    var PICKERVIEW1 = UIPickerView()
    
    @IBOutlet weak var CUSTOM_V3: UIView!
    @IBOutlet weak var CHECK_I1: UIImageView!
    @IBOutlet weak var CUSTOM_V4: UIView!
    @IBOutlet weak var CHECK_I2: UIImageView!
    @IBOutlet weak var CUSTOM_V5: UIView!
    @IBOutlet weak var CHECK_I3: UIImageView!
    @IBOutlet weak var PICKERVIEW2: UIPickerView!
    @IBOutlet weak var NOTICE_L: UILabel!
    
    override func loadView() {
        super.loadView()
        
        S_KEYBOARD()
        
        if DEVICE_RATIO() { CUSTOM_V1.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15) }
        TITLE_L.titleFont(size: 18); TITLE_L.text = TITLE
        BACK_B.layer.cornerRadius = 15; BACK_B.clipsToBounds = true
        EDIT_B.layer.cornerRadius = 15; EDIT_B.clipsToBounds = true
        
        CUSTOM_V2.layer.borderWidth = 2; CUSTOM_V2.layer.borderColor = UIColor.lightGray.cgColor
        CUSTOM_V2.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
        
        CITY_TV.isHidden = true; CITY_TV.isEditable = false; CITY_TV.lineHeight()
        PLACEHOLDER(TF: NUMBER_TF1, PH: "12"); PLACEHOLDER(TF: NUMBER_TF2, PH: "가"); PLACEHOLDER(TF: NUMBER_TF3, PH: "1234")
        
        for VIEW in [CUSTOM_V3, CUSTOM_V4, CUSTOM_V5] { VIEW?.layer.cornerRadius = 7.5; VIEW?.clipsToBounds = true }
        
        PICKERVIEW2.isHidden = true; PICKERVIEW2.setValue(UIColor.black, forKey: "textColor")
        
        if TITLE == "세대주차" { BACK_B.isHidden = true; NOTICE_L.isHidden = false } else { BACK_B.isHidden = false; NOTICE_L.isHidden = true }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EDIT_B.addTarget(self, action: #selector(EDIT_B(_:)), for: .touchUpInside)
        
        for TF in [NUMBER_TF1, NUMBER_TF2, NUMBER_TF3] { TF?.delegate = self }
        NUMBER_TF2.inputView = PICKERVIEW1
        PICKERVIEW1.delegate = self; PICKERVIEW1.dataSource = self
        
        CUSTOM_V3.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CUSTOM_V3(_:))))
        CUSTOM_V4.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CUSTOM_V4(_:))))
        CUSTOM_V5.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CUSTOM_V5(_:))))
        
        PICKERVIEW2.delegate = self; PICKERVIEW2.dataSource = self
    }
    
    @objc func EDIT_B(_ sender: UIButton) {
        
        if NUMBER_TF1.text! == "" || NUMBER_TF2.text! == "" || NUMBER_TF3.text! == "" {
            S_NOTICE(":( 미입력된 항목이 있습니다")
        } else if TITLE == "방문주차" {
            PUT_PARKING_2(NAME: "방문주차(등록)", AC_TYPE: "insert")
        } else if TITLE == "세대주차" {
            PUT_PARKING_2(NAME: "세대주차(등록)", AC_TYPE: "insert")
        }
    }
    
    @objc func CUSTOM_V3(_ sender: UITapGestureRecognizer) {
        
        for TF in [NUMBER_TF1, NUMBER_TF2, NUMBER_TF3] { TF?.resignFirstResponder() }
        
        if !CHECK_1 { CHECK_1 = true; CHECK_2 = true
            CUSTOM_V2.backgroundColor = .systemYellow; CITY_TV.isHidden = false; CHECK_I1.image = UIImage(named: "check_on.png")
            CHECK_I2.image = UIImage(named: "check_on.png"); PICKERVIEW2.isHidden = false
        } else { CHECK_1 = false
            CUSTOM_V2.backgroundColor = .H_F3F3F3; CITY_TV.isHidden = false; CHECK_I1.image = UIImage(named: "check_off.png")
        }
    }
    
    @objc func CUSTOM_V4(_ sender: UITapGestureRecognizer) {
        
        for TF in [NUMBER_TF1, NUMBER_TF2, NUMBER_TF3] { TF?.resignFirstResponder() }
        
        if !CHECK_2 { CHECK_2 = true
            CITY_TV.isHidden = false; CHECK_I2.image = UIImage(named: "check_on.png"); PICKERVIEW2.isHidden = false
        } else { CHECK_1 = false; CHECK_2 = false
            CUSTOM_V2.backgroundColor = .H_F3F3F3; CITY_TV.isHidden = true; CHECK_I1.image = UIImage(named: "check_off.png")
            CHECK_I2.image = UIImage(named: "check_off.png"); PICKERVIEW2.isHidden = true
        }
    }
    
    @objc func CUSTOM_V5(_ sender: UITapGestureRecognizer) {
        
        for TF in [NUMBER_TF1, NUMBER_TF2, NUMBER_TF3] { TF?.resignFirstResponder() }
        
        if !CHECK_3 { CHECK_3 = true
            CHECK_I3.image = UIImage(named: "check_on.png")
        } else { CHECK_3 = false
            CHECK_I3.image = UIImage(named: "check_off.png")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == NUMBER_TF1 {
            if NUMBER_TF1.text!.count + string.count <= 3 { return true } else { NUMBER_TF2.becomeFirstResponder() }
        } else if textField == NUMBER_TF3 {
            if NUMBER_TF3.text!.count + string.count <= 4 { return true } else { NUMBER_TF3.resignFirstResponder() }
        }
        
        return false
    }
}

extension VC_PARKING_2: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == PICKERVIEW1 { return MIDDLES.count } else if pickerView == PICKERVIEW2 { return CITYS.count } else { return 0 }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == PICKERVIEW1 { return MIDDLES[row] } else if pickerView == PICKERVIEW2 { return CITYS[row] } else { return "" }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == PICKERVIEW1 { NUMBER_TF2.text = MIDDLES[row] } else if pickerView == PICKERVIEW2 { CITY_TV.text = CITYS[row] }
    }
}
