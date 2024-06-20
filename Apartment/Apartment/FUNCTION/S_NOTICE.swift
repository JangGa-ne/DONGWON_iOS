//
//  S_NOTICE.swift
//  Horticulture
//
//  Created by 장 제현 on 2021/10/16.
//

import UIKit
import Alamofire

// MARK: 알림 문구
extension UIViewController {
    
    func S_NOTICE(_ MESSAGE: String) {
        
        UINotificationFeedbackGenerator().notificationOccurred(.error)
        
        let NOTIFICATION = UILabel(frame: CGRect(x: view.frame.size.width/2 - 97.5, y: 0.0, width: 195.0, height: 50.0))
            
        NOTIFICATION.backgroundColor = .black.withAlphaComponent(0.8)
        NOTIFICATION.textColor = .lightGray
        NOTIFICATION.textAlignment = .center
        NOTIFICATION.font = .boldSystemFont(ofSize: 12)
        NOTIFICATION.text = MESSAGE
        NOTIFICATION.layer.cornerRadius = 25
        NOTIFICATION.clipsToBounds = true
        NOTIFICATION.alpha = 0.0
        
        UIViewController.APPDELEGATE.WINDOW?.addSubview(NOTIFICATION)
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            
            NOTIFICATION.alpha = 1.0
            if !self.DEVICE_RATIO() {
                NOTIFICATION.transform = CGAffineTransform(translationX: 0, y: 20)
            } else {
                NOTIFICATION.transform = CGAffineTransform(translationX: 0, y: 44)
            }
        })
            
        UIView.animate(withDuration: 0.3, delay: 2.0, options: .curveEaseOut, animations: {
                
            NOTIFICATION.alpha = 0.0
            NOTIFICATION.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: {(isCompleted) in
                
            NOTIFICATION.removeFromSuperview()
        })
    }
    
    // Alamofire 에러 알림장
    func S_ERROR(_ sender: AFError?) {
        
        // TIMEOUT
        if sender?._code == NSURLErrorTimedOut { self.S_NOTICE(":( TIMEOUT") }
        if sender?._code == NSURLErrorNetworkConnectionLost { self.S_NOTICE(":( 네트워크 연결 실패") }
        
        //
        switch sender {
        case .none:
            break
        case .some(.invalidURL(url: _)):
            self.S_NOTICE(":( 잘못된 URL")
        case .some(.parameterEncodingFailed(reason: _)):
            self.S_NOTICE(":( 매개 변수 인코딩 실패")
        case .some(.multipartEncodingFailed(reason: _)):
            self.S_NOTICE(":( 멀티 파트 인코딩 실패")
        case .some(.responseSerializationFailed(reason: _)):
//            self.S_NOTICE(":( 응답 직렬화 실패")
            break
        case .some(.responseValidationFailed(reason: _)):
            self.S_NOTICE(":( 응답 확인 실패")
        }
    }
    
    func ALERT(TITLE: String?, BODY: String?, STYLE: UIAlertController.Style) {
        
        let ALERT = UIAlertController(title: TITLE, message: BODY, preferredStyle: STYLE)
        present(ALERT, animated: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                ALERT.dismiss(animated: true, completion: nil)
            })
        })
    }
    
    func ALERT(VIEW: UIView, LABEL: UILabel, TEXT: String) {
        
        VIEW.frame = view.frame; VIEW.backgroundColor = UIColor(white: 0.0, alpha: 0.1); view.addSubview(VIEW)
        LABEL.frame = CGRect(x: UIScreen.main.bounds.width / 2 - 130, y: UIScreen.main.bounds.height / 2 - 30, width: 260, height: 60)
        LABEL.layer.cornerRadius = 10; LABEL.clipsToBounds = true
        if #available(iOS 13.0, *) {
            LABEL.backgroundColor = .tertiarySystemBackground
        } else {
            LABEL.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        }
        LABEL.font = UIFont.systemFont(ofSize: 14)
        LABEL.textAlignment = .center; if #available(iOS 13.0, *) { LABEL.textColor = .label } else { LABEL.textColor = .black }
        LABEL.numberOfLines = 2; LABEL.text = TEXT
        view.addSubview(LABEL)
    }
    
    func PUSH(TITLE: String, BODY: String) {
        
        let CONTENT = UNMutableNotificationContent()
        CONTENT.title = TITLE; CONTENT.body = BODY; CONTENT.sound = .default
        if BODY.contains("부재중 전화") { CONTENT.userInfo = ["sf_reject": 1] } else { CONTENT.userInfo = ["sf_reject": 0] }
        
        let TRIGGER = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let REQUEST = UNNotificationRequest(identifier: "\(Int.random(in: 100000000...999999999))", content: CONTENT, trigger: TRIGGER)
        UNUserNotificationCenter.current().add(REQUEST)
    }
}
