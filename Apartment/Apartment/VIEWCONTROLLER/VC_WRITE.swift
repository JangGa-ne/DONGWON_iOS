//
//  VC_WRITE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/28.
//

import UIKit
import MobileCoreServices

class VC_WRITE: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var BD_TYPE: String = ""
    var BD_NAME: String = ""
    var CC_CODE: String = ""
    
    var FILE_DATA: [String: Any] = [:]
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var SUBMIT_B: UIButton!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var SCROLLVIEW: UIScrollView!
    @IBOutlet weak var TITLE_L: UILabel!
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var TYPE_B: UIButton!
    @IBOutlet weak var SUBJECT_TV: UITextView!
    @IBOutlet weak var CONTENTS_TV: UITextView!
    
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var CUSTOM_SV1: UIStackView!
    @IBOutlet weak var FILE_B: UIButton!
    
    override func loadView() {
        super.loadView()
        
        S_KEYBOARD(); UIViewController.APPDELEGATE.VC_WRITE_DEL = self
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        CUSTOM_V1.layer.cornerRadius = 15; CUSTOM_V1.clipsToBounds = true
        TYPE_B.layer.cornerRadius = 7.5; TYPE_B.clipsToBounds = true
        TYPE_B.backgroundColor = .H_E1E1EB
        TYPE_B.setTitle("   \(BD_NAME)", for: .normal)
        
        SUBJECT_TV.delegate = self; SUBJECT_TV.text = "제목을 입력해주세요."; SUBJECT_TV.textColor = .lightGray; SUBJECT_TV.returnKeyType = .next
        CONTENTS_TV.delegate = self; CONTENTS_TV.text = "내용을 입력해주세요."; CONTENTS_TV.textColor = .lightGray
        
        FILE_B.layer.cornerRadius = 7.5; FILE_B.clipsToBounds = true
        
        CUSTOM_V2.layer.cornerRadius = 15; CUSTOM_V2.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCROLLVIEW.delegate = self
        
        SUBMIT_B.addTarget(self, action: #selector(SUBMIT_B(_:)), for: .touchUpInside)
        
        if BD_NAME == "하자" { TYPE_B.addTarget(self, action: #selector(TYPE_B(_:)), for: .touchUpInside) }
        FILE_B.addTarget(self, action: #selector(FILE_B(_:)), for: .touchUpInside)
    }
    
    @objc func SUBMIT_B(_ sender: UIButton) {
        
        if SUBJECT_TV.text! == "" || SUBJECT_TV.text! == "제목을 입력해주세요." || CONTENTS_TV.text! == "" || CONTENTS_TV.text! == "내용을 입력해주세요." {
            S_NOTICE(":( 미입력된 항목이 있습니다")
        } else {
            PUT_WRITE(NAME: (TYPE_B.titleLabel?.text! ?? "").replacingOccurrences(of: " ", with: "")+"(등록)", AC_TYPE: "")
        }
    }
    
    @objc func TYPE_B(_ sender: UIButton) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "VC_CATEGORY") as! VC_CATEGORY
        VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self
        VC.TYPES = ["하자", "민원"]
        present(VC, animated: true, completion: nil)
    }
    
    @objc func FILE_B(_ sender: UIButton) {
        
        SUBJECT_TV.resignFirstResponder(); CONTENTS_TV.resignFirstResponder()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let DOCUMENTPICKER: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF), String(kUTTypeData), String(kUTTypeImage), String(kUTTypeHTML), String(kUTTypeGIF)], in: .import)
            DOCUMENTPICKER.delegate = self; DOCUMENTPICKER.modalPresentationStyle = .formSheet
            self.present(DOCUMENTPICKER, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_WRITE: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray { textView.text = nil; textView.textColor = .black }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView == SUBJECT_TV { textView.text = "제목을 입력해주세요." } else if textView == CONTENTS_TV { textView.text = "내용을 입력해주세요." }; textView.textColor = .lightGray
        }
    }
}

extension VC_WRITE: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let NAME: String = "\(url.path)".components(separatedBy: "/")["\(url.path)".components(separatedBy: "/").count-1]
        let FILE = UIButton(); FILE.frame.size.height = 15
        FILE.titleLabel?.font = .systemFont(ofSize: 14); FILE.setTitleColor(.black, for: .normal)
        FILE.contentHorizontalAlignment = .left; FILE.setTitle(NAME, for: .normal)
        FILE.tag = CUSTOM_SV1.tag; FILE.addTarget(self, action: #selector(DELETE(_:)), for: .touchUpInside)
        CUSTOM_SV1.addArrangedSubview(FILE); FILE_DATA[NAME] = url
    }
    
    @objc func DELETE(_ sender: UIButton) {
        
        let ALERT = UIAlertController(title: "", message: "첨부파일을 삭제하시겠습니까?", preferredStyle: .alert)
        
        ALERT.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            sender.removeFromSuperview(); self.FILE_DATA.removeValue(forKey: sender.titleLabel?.text ?? "")
        }))
        ALERT.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        present(ALERT, animated: true, completion: nil)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension VC_WRITE: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > 0 { NAVI_L.alpha = OFFSET_Y/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
