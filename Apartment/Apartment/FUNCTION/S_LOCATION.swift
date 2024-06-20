//
//  S_LOCATION.swift
//  APT
//
//  Created by 장 제현 on 2021/12/09.
//

import UIKit
import Alamofire
import CoreLocation

// MARK: 위치 업로드
extension AppDelegate: CLLocationManagerDelegate {
    
    func LOC_UPDATE() {
        
        let MB_ID = UserDefaults.standard.string(forKey: "mb_id") ?? ""
        let MB_TYPE = UserDefaults.standard.string(forKey: "mb_type") ?? ""
        
        if MB_ID != "" && MB_TYPE == "c" {
            
            LOC_MANAGER.requestWhenInUseAuthorization()

            // 백그라운드 위치 업데이트 허용
            LOC_MANAGER.allowsBackgroundLocationUpdates = true
            // 자동으로 위치 업데이트 일시 중지
            LOC_MANAGER.pausesLocationUpdatesAutomatically = false
            // 최소 이동 거리
            if UserDefaults.standard.integer(forKey: "loc_slider") == 0 {
                LOC_MANAGER.distanceFilter = 300
            } else {
                LOC_MANAGER.distanceFilter = CLLocationDistance(UserDefaults.standard.integer(forKey: "loc_slider") * 100)
            }
            
            LOC_MANAGER.delegate = self; LOC_MANAGER.requestAlwaysAuthorization()
            LOC_MANAGER.startUpdatingLocation(); LOC_MANAGER.startMonitoringSignificantLocationChanges()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        TASK_ID = APP.beginBackgroundTask(expirationHandler: {
            // 백그라운드 시작
            DispatchQueue.main.async { if self.TASK_ID != .invalid { self.APP.endBackgroundTask(self.TASK_ID); self.TASK_ID = .invalid } }
        })
        
        for LOCATION in locations { if LOCATION.horizontalAccuracy <= 200 { PUT_LOCATION(NAME: "자녀위치업로드", AC_TYPE: "insert", COORDINATE: LOCATION.coordinate, ACCURACY: LOCATION.horizontalAccuracy) } }
        
        // 백그라운드 종료
        DispatchQueue.global(qos: .default).async { DispatchQueue.main.async { self.APP.endBackgroundTask(self.TASK_ID); self.TASK_ID = .invalid } }
    }
    
    // MARK: 위치 업로드
    func PUT_LOCATION(NAME: String, AC_TYPE: String, COORDINATE: CLLocationCoordinate2D, ACCURACY: CLLocationAccuracy) {
        
        let PARAMETERS: Parameters = [
            "action_type": AC_TYPE,
            "mb_id": UserDefaults.standard.string(forKey: "mb_id") ?? "",
            "bk_name": UserDefaults.standard.string(forKey: "bk_name") ?? "",
            "lat": COORDINATE.latitude,
            "lng": COORDINATE.longitude,
            "accuracy": ACCURACY,
            "app_name": "아파트4U_iOS",
            "etc": "s",
        ]
        
        let MANAGER = Alamofire.SessionManager.default
        MANAGER.session.configuration.timeoutIntervalForRequest = 5
        MANAGER.request(P_URL+"/location/update_location.php", method: .post, parameters: PARAMETERS).responseString(completionHandler: { response in
            
            print("[\(NAME)]"); for (KEY, VALUE) in PARAMETERS { print("KEY: \(KEY), VALUE: \(VALUE)") }; print(response)
            
//            UIViewController.APPDELEGATE.VC_DEL.LOCALPUSH(TITLE: "학교정보통 꿈나무", BODY: "[알림] 위치 업로드\nLAT: \(COORDINATE.latitude), LNG: \(COORDINATE.longitude)")
        })
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }
}
