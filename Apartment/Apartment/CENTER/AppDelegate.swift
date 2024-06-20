//
//  AppDelegate.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/23.
//

import UIKit
import CoreLocation
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
// MARK: CORELOCATION ----------------------------------------------------
    
    let APP = UIApplication.shared
    var TASK_ID = UIBackgroundTaskIdentifier.invalid
    var LOC_MANAGER = CLLocationManager()
    
// MARK: FIREBASE -------------------------------------------------------
    
    let GCM_MSG_ID_KEY = "gcm.message_id"
    
// MARK: APPDELEGATE ----------------------------------------------------
    
    var MENU: String = ""
    let MENUS: [String: String] = ["마을일정": "VC_SOSIK", "관리비": "VC_EXPENESE", "방문·주차": "VC_PARKING", "집전화": "VC_AA", "투표": "VC_SOSIK", "마을소식": "VC_SOSIK", "학교소식": "VC_SOSIK", "스마트홈": "VC_AA", "동네정보": "VC_RESTAURANT", "택배알림": "VC_DELIVERY", "시설예약": "VC_RESERVE", "CCTV": "VC_CCTV", "원격검침": "VC_AA", "E/V호출": "VC_ELEVATOR", "통합예약": "VC_INTEGRATED", "자녀안심": "VC_SAFE", "민원·수리·신고": "VC_SOSIK", "동네연락처": "VC_CONTACT", "아파트알림장": "VC_SOSIK", "커뮤니티": "VC_SOSIK", "주변의료시설": "VC_MEDICAL", "파일바구니": "VC_AA", "우리마을전단지": "VC_SOSIK", "아파트일정": "VC_SOSIK", "나의게시글": "VC_SOSIK", "전기차충전소": "VC_EVCAR"]
    
    // JalnanOTF YiSunShinDotumB
    var FT_NAME: String = "JalnanOTF"
    
    var SW_VERSION: String = "1.0"
    var GCM_KEY: String = "gcm.message_id"
    
    var APP_ICON: UIImage? = nil
    var APP_NAME: String = ""
    var AGREE_TITLE: String = ""
    
    var WINDOW: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    var STORYBOARD: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var SWIPE_GESTURE: Bool = false
    
    // DELEGATE
    var TBC_2_DEL: TBC_2? = nil
    var VC_INPUT_DEL: VC_INPUT? = nil
    var VC_SEARCH_DEL: VC_SEARCH? = nil
    var VC_EXPENESE_DEL: VC_EXPENESE? = nil
    var VC_SAFE_DEL: VC_SAFE? = nil
    var VC_ELEVATOR_DEL: VC_ELEVATOR? = nil
    var VC_DELIVERY_DEL: VC_DELIVERY? = nil
    var VC_SOSIK_DEL: VC_SOSIK? = nil
    var VC_COMMUNITY_DEL: VC_COMMUNITY? = nil
    var VC_COMMUNITY_1_DEL: VC_COMMUNITY_1? = nil
    var VC_WRITE_DEL: VC_WRITE? = nil
    var S_CALENDAR_DEL: S_CALENDAR? = nil
    
    // OBJECT
    var OBJ_LOGIN: [LOGIN] = []
    var OBJ_WEATHER: [WEATHER] = []
    var OBJ_SOSIK1: [SOSIK_L1] = []
    var OBJ_EXPENESE: EXPENESE = EXPENESE()
    var OBJ_PARKING: PARKING = PARKING()
    var OBJ_ALLMENU: [ALLMENU_L] = []
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        SW_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        
        // 알림
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { didAllow, Error in })
        application.registerForRemoteNotifications()
        
        FirebaseApp.configure(); Messaging.messaging().delegate = self
        
        if APP_NAME.contains("이편한") {
            APP_ICON = UIImage(named: "elife.png")
            APP_NAME = UserDefaults.standard.string(forKey: "ap_name") ?? "이 편한세상"
        } else {
            APP_ICON = UIImage(named: "dongwon.png")
            APP_NAME = UserDefaults.standard.string(forKey: "ap_name") ?? "비스타 동원"
        }
        
        let VC = STORYBOARD.instantiateViewController(withIdentifier: "VC_LOADING") as! VC_LOADING
        VC.ONOFF = false; VC.UPDATE = false; VC.UPDATE = false
        let NC = UINavigationController(rootViewController: VC)
        NC.setNavigationBarHidden(true, animated: true)
        WINDOW?.rootViewController = NC; WINDOW?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // FIREBASE TOKEN 초기화 방지
        Messaging.messaging().isAutoInitEnabled = true
//        // 생체인증 (로그아웃)
//        LOGIN_AUTH(MODE: "BACKGROUND")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // FIREBASE TOKEN 초기화 방지
        Messaging.messaging().isAutoInitEnabled = true
//        // 생체인증 (로그인)
//        LOGIN_AUTH(MODE: "FOREGROUND")
    }
    
// MARK: 위치조회 ----------------------------------------------------------------
    
    func applicationWillResignActive(_ application: UIApplication) {
        // FIREBASE TOKEN 초기화 방지
        Messaging.messaging().isAutoInitEnabled = true
        // 학생 위치 서비스 설정
        LOC_UPDATE()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // FIREBASE TOKEN 초기화 방지
        Messaging.messaging().isAutoInitEnabled = true
        // 학생 위치 서비스 설정
        LOC_UPDATE()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // FIREBASE TOKEN 초기화 방지
        Messaging.messaging().isAutoInitEnabled = true
        // 학생 위치 서비스 설정
        LOC_UPDATE()
    }
}

