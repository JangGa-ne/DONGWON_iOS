//
//  S_COLOR.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/23.
//

import UIKit

// MARK: 색상
extension UIColor {
    
    static var H_61C0A7 = UIColor(red: 97/255, green: 192/255, blue: 167/255, alpha: 1.0)   // 민트
    static var H_4E177C = UIColor(red: 78/255, green: 23/255, blue: 124/255, alpha: 1.0)    // 퍼플
    static var H_2B3F6B = UIColor(red: 43/255, green: 63/255, blue: 107/255, alpha: 1.0)    // 네이비
    static var H_FFAC0F = UIColor(red: 255/255, green: 172/255, blue: 15/255, alpha: 1.0)   // 오렌지
    static var H_4895CF = UIColor(red: 72/255, green: 149/255, blue: 207/255, alpha: 1.0)   // 블루
    static var H_FC7667 = UIColor(red: 252/255, green: 118/255, blue: 103/255, alpha: 1.0)  // 핑크
    
    static var H_F3F3F3 = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1.0)
    static var H_E1E1EB = UIColor(red: 225/255, green: 225/255, blue: 235/255, alpha: 1.0)  // 그레이
    
    static var H_ABDE54 = UIColor(red: 171/255, green: 222/255, blue: 84/255, alpha: 0.7)
    static var H_65C2A7 = UIColor(red: 101/255, green: 194/255, blue: 167/255, alpha: 0.7)
    static var H_A6DAE8 = UIColor(red: 166/255, green: 218/255, blue: 232/255, alpha: 0.7)
    
    func COMPARISON(VALUE: Int) -> UIColor { if VALUE > 0 { return .systemRed } else if VALUE < 0 { return .systemGreen } else { return .black } }
    
    public convenience init?(hex: String, alpha: CGFloat) {
        
        let r, g, b: CGFloat
        
        if hex.hasPrefix("#") {
            
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: alpha)
                    
                    return
                }
            }
        }

        return nil
    }
}
