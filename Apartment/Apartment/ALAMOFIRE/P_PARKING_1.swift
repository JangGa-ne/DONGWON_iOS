//
//  P_PARKING_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/20.
//

import UIKit
import Alamofire

extension VC_PARKING_2 {
    
    func PUT_PARKING_2(NAME: String, AC_TYPE: String) {
        
        let BUILDING_ID = UserDefaults.standard.string(forKey: "building_id") ?? ""
        let HOUSE_NUMBER = UserDefaults.standard.string(forKey: "house_number") ?? ""
        
        var P_URL2: String = ""
        var PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "bk_name": UserDefaults.standard.string(forKey: "bk_name") ?? "",
            "home_code": UserDefaults.standard.string(forKey: "home_code") ?? "",
            "building_id": BUILDING_ID,
            "house_number": HOUSE_NUMBER,
            "owner_type": "P"
        ]
        
        if TITLE == "방문주차" { P_URL2 = "/addon/visit.php"
            PARAMETERS["visit_name"] = "\(BUILDING_ID)동 \(HOUSE_NUMBER)호 방문자"
            PARAMETERS["visit_date"] = DATE
            PARAMETERS["visit_car_init"] = NUMBER_TF1.text!
            PARAMETERS["visit_car_char"] = NUMBER_TF2.text!
            PARAMETERS["visit_car_end"] = NUMBER_TF3.text!
        } else if TITLE == "세대주차" { P_URL2 = "/addon/parking_insert.php"
            PARAMETERS["car_init"] = NUMBER_TF1.text!
            PARAMETERS["car_char"] = NUMBER_TF2.text!
            PARAMETERS["car_end"] = NUMBER_TF3.text!
        }
        
        if CHECK_1 { PARAMETERS["plate_type"] = "L" } else { PARAMETERS["plate_type"] = "N" }
        if CHECK_2 { PARAMETERS["car_local"] = CITY_TV.text! }
        if CHECK_3 { PARAMETERS["disabled_car"] = "Y" } else { PARAMETERS["disabled_car"] = "N" }
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+P_URL2, method: .post, parameters: PARAMETERS).responseJSON { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("키: \(KEY), 값: \(VALUE)") }
            
            if response.result.isSuccess { //print(response)
                
                if let DICT = response.result.value as? [String: Any] {
                    
                    if DICT["result"] as? String ?? "fail" == "success" {
                        self.S_NOTICE(":) 등록 되었습니다")
                        if self.TITLE == "방문주차" { self.dismiss(animated: true) { self.dismiss(animated: true, completion: nil) }
                            if let DEL = UIViewController.APPDELEGATE.TBC_2_DEL {
                                let TEMP_CAR = Int(UIViewController.APPDELEGATE.OBJ_PARKING.TEMP_CAR) ?? 0
                                DEL.PARKING_L1.text = "\(TEMP_CAR+1)"
                            }
                        } else if self.TITLE == "세대주차" { self.dismiss(animated: true, completion: nil)
                            if let DEL = UIViewController.APPDELEGATE.TBC_2_DEL {
                                let PERM_CAR = Int(UIViewController.APPDELEGATE.OBJ_PARKING.PERM_CAR) ?? 0
                                DEL.PARKING_L2.text = "\(PERM_CAR+1)"
                            }
                        }
                    } else {
                        self.S_NOTICE(":( 등록 할 수 없습니다")
                    }
                }
            } else { print("FAILURE: \(response.error.debugDescription)")
                self.S_ERROR(response.result.error as? AFError)
            }
        }
    }
}
