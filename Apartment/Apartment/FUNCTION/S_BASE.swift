//
//  S_BASE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/24.
//

import UIKit
import AFNetworking

var DF = DateFormatter()
var NF = NumberFormatter()

// MARK: 기본 설정
extension UIViewController {
    
    static var APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
    static var NFG = UINotificationFeedbackGenerator()
    static var DIC = UIDocumentInteractionController()
    static let STATUS_Y = UIApplication.shared.statusBarFrame.height + 50
    
    @objc func BACK_V(_ sender: UITapGestureRecognizer) { guard let _ = navigationController?.popViewController(animated: true) else { dismiss(animated: true, completion: nil); return } }
    @objc func NOTICE_B(_ sender: UIButton) { PRESENT_VC(IDENTIFIER: "VC_NOTICE", ANIMATED: true) }
    @objc func SETTING_B(_ sender: UIButton) { PRESENT_VC(IDENTIFIER: "VC_SETTING", ANIMATED: true) }
    
    // MARK: 하이픈
    func FORMAT(MASK: String, PHONE: String) -> String {
        
        let NUMBERS = PHONE.replacingOccurrences(of: "[^0-9*#]", with: "", options: .regularExpression)
        var RESULT: String = ""
        var INDEX = NUMBERS.startIndex
        
        for CH in MASK where INDEX < NUMBERS.endIndex {
            if CH == "X" { RESULT.append(NUMBERS[INDEX]); INDEX = NUMBERS.index(after: INDEX) } else { RESULT.append(CH) }
        }
        
        return RESULT
    }
    
    // MARK: 전화번호 형식 적용
    func NUMBER(_ COUNT: Int, _ NUMBER: String) -> String {
        
        if NUMBER.contains("-") {
            return NUMBER
        } else if COUNT <= 8 {
            return FORMAT(MASK: "XXXX-XXXX", PHONE: NUMBER)
        } else if COUNT <= 9 && NUMBER[NUMBER.startIndex] == "0" && NUMBER[NUMBER.index(after: NUMBER.startIndex)] == "2" {
            return FORMAT(MASK: "XX-XXX-XXXX", PHONE: NUMBER)
        } else if COUNT <= 10 && NUMBER[NUMBER.startIndex] == "0" && NUMBER[NUMBER.index(after: NUMBER.startIndex)] == "2" {
            return FORMAT(MASK: "XX-XXXX-XXXX", PHONE: NUMBER)
        } else if COUNT <= 10 {
            return FORMAT(MASK: "XXX-XXX-XXXX", PHONE: NUMBER)
        } else if COUNT <= 11 {
            return FORMAT(MASK: "XXX-XXXX-XXXX", PHONE: NUMBER)
        } else if COUNT <= 12 {
            return FORMAT(MASK: "XXXX-XXXX-XXXX", PHONE: NUMBER)
        } else {
            return NUMBER
        }
    }
    
    func FILE(DOWN: String, WEB: String, NAME: String) {
        
        let ALERT = UIAlertController(title: "미리보기 및 다운로드하고 싶은 파일을 선택해주세요", message: nil, preferredStyle: .actionSheet)
        
        let CANCEL = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        CANCEL.setValue(UIColor.systemRed, forKey: "titleTextColor")
        
        ALERT.addAction(UIAlertAction(title: NAME, style: .default) { (_) in
            
//            let SUB_ALERT = UIAlertController(title: "미리보기 및 다운로드하고 싶은 파일을 선택해주세요", message: nil, preferredStyle: .actionSheet)
//            SUB_ALERT.addAction(UIAlertAction(title: "미리보기", style: .default, handler: { _ in
//                if WEB == "" {
//                    self.S_NOTICE(":( 미리보기 미지원")
//                } else {
//                    let VC = self.storyboard?.instantiateViewController(withIdentifier: "VC_PRIVIEW") as! VC_PRIVIEW
//                    VC.WEB = WEB
//                    self.navigationController?.pushViewController(VC, animated: true)
//                }
//            }))
//            SUB_ALERT.addAction(UIAlertAction(title: "다운로드", style: .default, handler: { _ in
                if DOWN == "" {
                    self.S_NOTICE(":( 다운로드 미지원")
                } else {
                    self.DOWNLOAD(DOWN: DOWN, NAME: NAME)
                }
//            }))
//            SUB_ALERT.addAction(CANCEL)
//            self.present(SUB_ALERT, animated: true, completion: nil)
        })
        ALERT.addAction(CANCEL)
        
        present(ALERT, animated: true, completion: nil)
    }
    
    func DOWNLOAD(DOWN: String, NAME: String) {
        
        let FILTER = "\(DOWN[DOWN.index(DOWN.endIndex, offsetBy: -3)])\(DOWN[DOWN.index(DOWN.endIndex, offsetBy: -2)])\(DOWN[DOWN.index(DOWN.endIndex, offsetBy: -1)])"
        
        if !(FILTER == "bmp") || (FILTER == "BMP") {
            
            var FILE_URL: String = ""
            
            if DOWN.contains("firebase") { FILE_URL = DOWN } else { FILE_URL = DOWN.replacingOccurrences(of: "&2520", with: "%20").addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "" }
            let MEDIA_FILE = URL(string: FILE_URL)
            var REQUEST: URLRequest? = nil
            if let MEDIA_FILE = MEDIA_FILE { REQUEST = URLRequest(url: MEDIA_FILE) }
            
            let SECURITY_POLICY = AFSecurityPolicy(pinningMode: .none)
            SECURITY_POLICY.allowInvalidCertificates = true; SECURITY_POLICY.validatesDomainName = false
            
            let SESSION = AFHTTPSessionManager()
            SESSION.securityPolicy = SECURITY_POLICY
            
            let PROGRESS: Progress? = nil
            
            if REQUEST != nil {
                
                let TASK = SESSION.downloadTask(with: REQUEST!, progress: nil, destination: { targetPath, response in
                    
                    let PATH = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? "")
                    return PATH.appendingPathComponent(NAME)
                }, completionHandler: { response, filePath, error in
                    
                    PROGRESS?.removeObserver(self, forKeyPath: "fractionCompleted", context: nil)
                    
                    UIViewController.DIC = UIDocumentInteractionController(url: filePath!)
                    UIViewController.DIC.presentOpenInMenu(from: .zero, in: self.view, animated: true)
                })
                
                TASK.resume(); PROGRESS?.addObserver(self, forKeyPath: "fractionCompleted", options: .new, context: nil)
            } else {
                S_NOTICE(":( 첨부파일 열 수 없음")
            }
        } else {
            S_NOTICE(":( 지원하지 않는 첨부파일")
        }
    }
}

extension UITableViewCell {
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
}

class TITLE_TC: UITableViewCell {
    
    @IBOutlet weak var TITLE_L: UILabel!
}

class TITLE_CC: UICollectionViewCell {
    
    @IBOutlet weak var TITLE_L: UILabel!
}

extension UIView {
    
    func roundShadows(color: UIColor, offset: CGSize, opcity: Float, radius1: CGFloat, radius2: CGFloat) {
        layer.shadowColor = color.cgColor; layer.shadowOffset = offset; layer.shadowOpacity = opcity; layer.shadowRadius = radius1; layer.cornerRadius = radius2
    }
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        layer.maskedCorners = corners; self.layer.cornerRadius = radius; self.clipsToBounds = true
    }
    
    func rotate360() {
        
        let ROTATE = CABasicAnimation(keyPath: "transform.rotation.z")
        ROTATE.toValue = Double.pi * 2
        ROTATE.duration = 1.0
        ROTATE.isCumulative = true
        ROTATE.repeatCount = .greatestFiniteMagnitude
        
        layer.add(ROTATE, forKey: "rotationAnimation")
    }
}

extension UIStackView {
    
    func removeAllArrangedSubviews() { arrangedSubviews.forEach { removeArrangedSubview($0); NSLayoutConstraint.deactivate($0.constraints); $0.removeFromSuperview() } }
}
