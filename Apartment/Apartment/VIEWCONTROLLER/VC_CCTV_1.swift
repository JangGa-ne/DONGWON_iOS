//
//  VC_CCTV_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/14.
//

import UIKit
import WebKit

/// CCTV(디테일)
class VC_CCTV_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var OBJ_CCTV: [CCTV] = []
    var POSITION: Int = 0
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    
    @IBOutlet weak var WKWEBVIEW: WKWebView!
    
    override func loadView() {
        super.loadView()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.text = OBJ_CCTV[POSITION].VIDEO_NAME
        
        WKWEBVIEW.scrollView.isScrollEnabled = false; WKWEBVIEW.scrollView.bouncesZoom = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WKWEBVIEW.uiDelegate = self; WKWEBVIEW.navigationDelegate = self
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        if let KOREAN_URL = URL(string: OBJ_CCTV[POSITION].URL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!) {
            UIViewController.NODATA_L.removeFromSuperview()
            WKWEBVIEW.load(URLRequest(url: KOREAN_URL)); WKWEBVIEW.backgroundColor = .black
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_CCTV_1: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }; return nil
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let METHOD = challenge.protectionSpace.authenticationMethod
        if METHOD == NSURLAuthenticationMethodDefault || METHOD == NSURLAuthenticationMethodHTTPBasic || METHOD == NSURLAuthenticationMethodHTTPDigest {
            let CREDENTIAL = URLCredential(user: OBJ_CCTV[POSITION].ID_VALUE, password: OBJ_CCTV[POSITION].PW_VALUE, persistence: .forSession)
            challenge.sender?.use(CREDENTIAL, for: challenge); completionHandler(.useCredential, CREDENTIAL)
        } else if METHOD == NSURLAuthenticationMethodServerTrust {
            completionHandler(.performDefaultHandling, nil)
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
