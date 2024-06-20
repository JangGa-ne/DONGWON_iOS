//
//  S_INDICATOR.swift
//  Apartment
//
//  Created by 장 제현 on 2021/06/05.
//

import UIKit

extension UIViewController {

    @discardableResult
    func customActivityIndicatory(_ viewContainer: UIView, startAnimate: Bool? = true) -> UIActivityIndicatorView {
        
        let mainContainer = UIView(frame: viewContainer.frame)
        mainContainer.center = viewContainer.center
        mainContainer.backgroundColor = .white
        mainContainer.alpha = 0.5
        mainContainer.tag = 789456123
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading = UIView(frame: CGRect(x: 0, y: 0,width: 80, height: 80))
        viewBackgroundLoading.center = viewContainer.center
        viewBackgroundLoading.backgroundColor = .gray
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.frame = CGRect(x: 0, y: 0,width: 40, height: 40)
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)
        if startAnimate! {
            viewBackgroundLoading.addSubview(activityIndicatorView); mainContainer.addSubview(viewBackgroundLoading); viewContainer.addSubview(mainContainer); activityIndicatorView.startAnimating()
        } else {
            for subview in viewContainer.subviews { if subview.tag == 789456123 { subview.removeFromSuperview() } }
        }
        
        return activityIndicatorView
    }
}
