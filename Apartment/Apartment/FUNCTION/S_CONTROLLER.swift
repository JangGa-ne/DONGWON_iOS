//
//  S_CONTROLLER.swift
//  Horticulture
//
//  Created by 장 제현 on 2021/10/07.
//

import UIKit

// MARK: 뷰컨트롤러 설정
extension UIViewController {
    
    func PRESENT_TBC(IDENTIFIER: String, INDEX: Int, ANIMATED: Bool) {
        
        let TBC = storyboard?.instantiateViewController(withIdentifier: IDENTIFIER) as! UITabBarController
        TBC.selectedIndex = INDEX
        navigationController?.pushViewController(TBC, animated: ANIMATED)
    }
    
    func PRESENT_VC(IDENTIFIER: String, ANIMATED: Bool) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: IDENTIFIER)
        navigationController?.pushViewController(VC!, animated: ANIMATED)
    }
}

// MARK: 내비게이션 설정
extension UIViewController: UIGestureRecognizerDelegate {
    
    func BACK_GESTURE(_ BOOL: Bool) {
        UIViewController.APPDELEGATE.SWIPE_GESTURE = BOOL
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        return UIViewController.APPDELEGATE.SWIPE_GESTURE
    }
}

extension UINavigationController {

    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin(); CATransaction.setCompletionBlock(completion); pushViewController(viewController, animated: animated); CATransaction.commit()
    }
}
