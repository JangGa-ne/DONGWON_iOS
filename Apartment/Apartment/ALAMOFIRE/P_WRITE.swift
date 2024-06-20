//
//  P_WRITE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/28.
//

import UIKit
import Alamofire
import FirebaseStorage
import RxSwift

extension VC_WRITE {
    
    func PUT_WRITE(NAME: String, AC_TYPE: String) {
        
        if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        let ALERT = UIAlertController(title: "", message: "게시글 업로드 중...", preferredStyle: .alert)
        present(ALERT, animated: true, completion: nil)
        
        var P_URL2: String = ""
        var PARAMETERS: Parameters = [
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "ap_code": UserDefaults.standard.string(forKey: "ap_code") ?? "",
            "building_id": UserDefaults.standard.string(forKey: "building_id") ?? "",
            "house_number": UserDefaults.standard.string(forKey: "house_number") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "bk_name": UserDefaults.standard.string(forKey: "bk_name") ?? "",
            "bk_nick": UserDefaults.standard.string(forKey: "bk_nick") ?? "",
            "post_type": "F"
        ]
        
        if BD_TYPE == "C" { PARAMETERS["cc_code"] = CC_CODE }

        if BD_NAME != "하자" { P_URL2 = "/article/article_insert.php"
            PARAMETERS["action_type"] = "insert"
            PARAMETERS["board_type"] = BD_TYPE
            PARAMETERS["board_name"] = BD_NAME
            PARAMETERS["code_value"] = ""
            PARAMETERS["ap_subject"] = SUBJECT_TV.text!
            PARAMETERS["ap_content"] = CONTENTS_TV.text!
        } else { P_URL2 = "/addon/fix_request_insert.php"
            PARAMETERS["action_type"] = "post"
            if TYPE_B.titleLabel?.text! == "하자" { PARAMETERS["request_type"] = "F" } else { PARAMETERS["request_type"] = "A" }
            PARAMETERS["subject"] = SUBJECT_TV.text!
            PARAMETERS["content"] = CONTENTS_TV.text!
        }
        
//        for (I, DATA) in self.FILE_DATA.enumerated() {
//            PARAMETERS["media_type[\(I)]"] = "F"
//            PARAMETERS["media_name[\(I)]"] = DATA.key
//            PARAMETERS["media_url[\(I)]"] = ""//DATA.value as? Data ?? Data()
//            PARAMETERS["ext[\(I)]"] = DATA.key.pathExtension
//        }
        
        var FILE_UPLOAD: Int = 0
        
        for (I, DATA) in FILE_DATA.enumerated() {
        
            let STORAGE_REF = Storage.storage(url: "gs://eumaptvista-1fd9d.appspot.com").reference()
            let FILE_REF = STORAGE_REF.child("files/\(DATA.key)")
            let FILE_URL: URL? = DATA.value as? URL ?? nil
            let META_DATA = StorageMetadata(); META_DATA.contentType = "file/\(DATA.key.pathExtension)"
            
            FILE_REF.putFile(from: FILE_URL!, metadata: META_DATA).observe(.success) { snapshot in
                
                FILE_REF.downloadURL { url, error in FILE_UPLOAD += 1
                    
                    PARAMETERS["media_type[\(I)]"] = "F"
                    PARAMETERS["media_name[\(I)]"] = DATA.key
                    PARAMETERS["media_url[\(I)]"] = "\(url!)"
                    PARAMETERS["ext[\(I)]"] = DATA.key.pathExtension
                    
                    if self.FILE_DATA.count == FILE_UPLOAD {
                        
                        let MANAGER = Alamofire.SessionManager.default
                        MANAGER.session.configuration.timeoutIntervalForRequest = 5
                        MANAGER.request(P_URL+P_URL2, method: .post, parameters: PARAMETERS).responseJSON { response in

                            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }

                            if response.result.isSuccess { //print(response)

                                if let DICT = response.result.value as? [String: Any] {

                                    let RESULT = DICT["result"] as? String ?? "fail"
                                    
                                    ALERT.dismiss(animated: true) {
                                        
                                        if RESULT == "success" {
                                            
                                            self.S_NOTICE(":) 등록 되었습니다")
                                            if let BVC = UIViewController.APPDELEGATE.VC_SOSIK_DEL {
                                                BVC.GET_SOSIK_L2(NAME: "소식(목록)", AC_TYPE: "LIST", LM_START: 0, MONTH: "")
                                            }
                                            if let BVC = UIViewController.APPDELEGATE.VC_COMMUNITY_1_DEL {
                                                BVC.GET_SOSIK_L2(NAME: "\(self.BD_NAME)(목록)", AC_TYPE: "LIST", LM_START: 0)
                                            }
                                            self.navigationController?.popViewController(animated: true)
                                        } else {
                                            self.S_NOTICE(":( 등록 실패하였습니다")
                                        }
                                    }
                                }
                            } else { print("FAILURE: \(response.error.debugDescription)")
                                ALERT.dismiss(animated: true) { self.S_ERROR(response.result.error as? AFError); return }
                            }
                        }
                    }
                }
            }
        }
        
        if FILE_DATA.count == 0 {
            
            let MANAGER = Alamofire.SessionManager.default
            MANAGER.session.configuration.timeoutIntervalForRequest = 5
            MANAGER.request(P_URL+P_URL2, method: .post, parameters: PARAMETERS).responseJSON { response in

                print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }

                if response.result.isSuccess { //print(response)

                    if let DICT = response.result.value as? [String: Any] {

                        let RESULT = DICT["result"] as? String ?? "fail"
                        
                        ALERT.dismiss(animated: true) {
                            
                            if RESULT == "success" {
                                
                                self.S_NOTICE(":) 등록 되었습니다")
                                if let BVC = UIViewController.APPDELEGATE.VC_SOSIK_DEL {
                                    BVC.GET_SOSIK_L2(NAME: "소식(목록)", AC_TYPE: "LIST", LM_START: 0, MONTH: "")
                                }
                                if let BVC = UIViewController.APPDELEGATE.VC_COMMUNITY_1_DEL {
                                    BVC.GET_SOSIK_L2(NAME: "\(self.BD_NAME)(목록)", AC_TYPE: "LIST", LM_START: 0)
                                }
                                self.navigationController?.popViewController(animated: true)
                            } else {
                                self.S_NOTICE(":( 등록 실패하였습니다")
                            }
                        }
                    }
                } else { print("FAILURE: \(response.error.debugDescription)")
                    ALERT.dismiss(animated: true) { self.S_ERROR(response.result.error as? AFError); return }
                }
            }
        }
    }
    
    func STORAGE_UPLOAD(_ FILE: [String: Any], _ completion: @escaping ([String]) -> Void) {
        
        DispatchQueue.global().async {
            
            var URLS: [String] = []
        
            for (_, DATA) in FILE.enumerated() {
                
                let STORAGE_REF = Storage.storage(url: "gs://eumaptvista-1fd9d.appspot.com").reference()
                let FILE_REF = STORAGE_REF.child("files/\(DATA.key)")
                let FILE_URL: URL? = DATA.value as? URL ?? nil
                let META_DATA = StorageMetadata(); META_DATA.contentType = "file/\(DATA.key.pathExtension)"
                
                FILE_REF.putFile(from: FILE_URL!, metadata: META_DATA).observe(.success) { snapshot in
                    FILE_REF.downloadURL { url, error in  URLS.append("\(url!)") }
                }
            }
            
            DispatchQueue.main.async { completion(URLS) }
        }
    }
        
//    func PUT_WRITE(NAME: String, AC_TYPE: String) {
//
//        for (I, DATA) in self.FILE_DATA.enumerated() {
//
//            let STORAGE_REF = Storage.storage(url: "gs://eumaptvista-1fd9d.appspot.com").reference()
//            let FILE_REF = STORAGE_REF.child("files/\(DATA.key)")
//            let FILE_URL: URL? = DATA.value as? URL ?? nil
//            let META_DATA = StorageMetadata(); META_DATA.contentType = "file/\(DATA.key.pathExtension)"
//
//            FILE_REF.putFile(from: FILE_URL!, metadata: META_DATA) { metadata, error in
//
//                FILE_REF.downloadURL { url, error in
//
//                    PARAMETERS["media_type[\(I)]"] = "F"
//                    PARAMETERS["media_name[\(I)]"] = DATA.key
//                    PARAMETERS["media_url[\(I)]"] = "\(url!)"
//                    PARAMETERS["ext[\(I)]"] = DATA.key.pathExtension
//                }
//            }
//
//            let UPLOAD = FILE_REF.putFile(from: FILE_URL!, metadata: META_DATA)
//
//            // Listen for state changes, errors, and completion of the upload.
//            UPLOAD.observe(.resume) { snapshot in
//                // Upload resumed, also fires when the upload starts
//            }
//
//            UPLOAD.observe(.pause) { snapshot in
//                // Upload paused
//            }
//
//            UPLOAD.observe(.progress) { snapshot in
//                // Upload reported progress
//                let percentComplete = 100 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
//                print(percentComplete)
//            }
//
//            UPLOAD.observe(.success) { snapshot in
//                // Upload completed successfully
//                FILE_REF.downloadURL { url, error in print(url?.path) }
//            }
//
//            UPLOAD.observe(.failure) { snapshot in
//
//                if let error = snapshot.error as? NSError {
//
//                    switch (StorageErrorCode(rawValue: error.code)!) {
//                        case .objectNotFound:
//                        // File doesn't exist
//                        break
//                        case .unauthorized:
//                        // User doesn't have permission to access file
//                        break
//                        case .cancelled:
//                        // User canceled the upload
//                        break
//                        case .unknown:
//                        // Unknown error occurred, inspect the server response
//                        break
//                        default:
//                        // A separate error occurred. This is a good place to retry the upload.
//                        break
//                    }
//                }
//            }
//        }
}
