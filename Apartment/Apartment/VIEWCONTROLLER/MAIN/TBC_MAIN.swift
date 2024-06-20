//
//  TBC_MAIN.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/04.
//

import UIKit

class TBC_MAIN: UITabBarController {
    
    override func loadView() {
        super.loadView()
        
        let VIEW = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 0.5))
        VIEW.backgroundColor = UIColor(white: 0.0, alpha: 0.05)
        tabBar.addSubview(VIEW)
        
        let BACKGROUND_I = UIImageView()
        BACKGROUND_I.frame = CGRect(x: 0.0, y: 0.0, width: tabBar.frame.size.width, height: view.frame.maxY)
        BACKGROUND_I.contentMode = .scaleToFill
        BACKGROUND_I.image = UIImage(named: "navi_bg.png")
        tabBar.insertSubview(BACKGROUND_I, at: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(false)
    }
}

extension TBC_MAIN: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        UIImpactFeedbackGenerator().impactOccurred()
    }
}
