//
//  VC_AGREEMENT.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/30.
//

import UIKit
import WebKit

class VC_AGREEMENT: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var SCROLLVIEW: UIScrollView!
    @IBOutlet weak var TITLE_L: UILabel!
    @IBOutlet weak var WKWEBVIEW: WKWebView!
    @IBOutlet weak var WKWEBVIEW_HEIGHT: NSLayoutConstraint!
    
    override func loadView() {
        super.loadView()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.text = UIViewController.APPDELEGATE.AGREE_TITLE; NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TITLE_L.titleFont(size: 30); TITLE_L.text = UIViewController.APPDELEGATE.AGREE_TITLE
        
        WKWEBVIEW.scrollView.isScrollEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SCROLLVIEW.delegate = self; SCROLLVIEW.isScrollEnabled = false
        WKWEBVIEW.uiDelegate = self; WKWEBVIEW.navigationDelegate = self
        
        NODATA(RECT: view, MESSAGE: "데이터 없음"); if !S_NETWORK() { S_NOTICE(":( 네트워크 상태를 확인해 주세요"); return }
        
        if let KOREAN_URL = URL(string: "https://in.uic.me/policy/term.php?serv=\(UIViewController.APPDELEGATE.APP_NAME)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!) {
            SCROLLVIEW.isScrollEnabled = true; UIViewController.NODATA_L.removeFromSuperview(); WKWEBVIEW.load(URLRequest(url: KOREAN_URL))
        }
    }
    
    func AGREE_HTML(_ NAME: String) {
        
        var STRING: String = ""
        let PATH = Bundle.main.path(forResource: NAME, ofType: "html")
        do { STRING = try String(contentsOfFile: PATH!, encoding: .utf8) } catch { }
        WKWEBVIEW.loadHTMLString(STRING, baseURL: URL(fileURLWithPath: PATH!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_AGREEMENT: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil { webView.load(navigationAction.request) }; return nil
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("document.readyState") { complete, error in
            
            if complete != nil {
                webView.evaluateJavaScript("document.body.scrollHeight") { height, error in self.WKWEBVIEW_HEIGHT.constant = height as! CGFloat }
            } else {
                self.WKWEBVIEW_HEIGHT.constant = 0
            }
        }
    }
}

extension VC_AGREEMENT: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > 0 { NAVI_L.alpha = OFFSET_Y/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
