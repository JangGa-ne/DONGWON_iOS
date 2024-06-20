//
//  S_KEYBOARD.swift
//  APT
//
//  Created by 장 제현 on 2021/04/19.
//

import UIKit

// MARK: 키보드 설정
extension UIViewController: UITextFieldDelegate {
    
// MARK: 키보드 기본 설정
    func S_KEYBOARD() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(KEYBOARD_SHOW(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KEYBOARD_HIDE(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
// MARK: 키보드 나타남
    @objc func KEYBOARD_SHOW(_ sender: Notification) {
        
        let s = sender.userInfo![UIResponder.keyboardFrameEndUserInfoKey]
        let rect = (s! as AnyObject).cgRectValue

        let keyboardFrameEnd = view!.convert(rect!, to: nil)
        view.frame = CGRect(x: 0, y: 0, width: keyboardFrameEnd.size.width, height: keyboardFrameEnd.origin.y)
        view.layoutIfNeeded()
    }
    
// MARK: 키보드 사라짐
    @objc func KEYBOARD_HIDE(_ sender: Notification) {
        
        let s = sender.userInfo![UIResponder.keyboardFrameBeginUserInfoKey]
        let rect = (s! as AnyObject).cgRectValue
        
        view.frame = CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height + rect!.height)
        view.layoutIfNeeded()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done { textField.resignFirstResponder() }; return true
    }
    
// MARK: 완료 버튼
    func TOOL_BAR_DONE(TF: UITextField, TV: UITextView, SB: UISearchBar) {
        
        let TOOL_BAR = UIToolbar()
        TOOL_BAR.sizeToFit()
        
        let SPACE = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let DONE = UIBarButtonItem(title: "완료", style: .done, target: self, action:  #selector(DONE_CLICKED))
        if #available(iOS 13.0, *) { TOOL_BAR.tintColor = .label } else { TOOL_BAR.tintColor = .black }
        TOOL_BAR.setItems([SPACE, DONE], animated: false)
        
        TF.inputAccessoryView = TOOL_BAR
        TV.inputAccessoryView = TOOL_BAR
        SB.inputAccessoryView = TOOL_BAR
    }
    
    @objc func DONE_CLICKED() { view.endEditing(true) }
    
// MARK: 화면 다른곳 터치하면 키보드 내려짐
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
