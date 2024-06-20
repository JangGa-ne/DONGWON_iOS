//
//  S_IMAGE.swift
//  Horticulture
//
//  Created by 장 제현 on 2021/10/30.
//

import UIKit
import AVKit
import SDWebImage
import FirebaseStorage

// MARK: 이미지, 비디오
extension UIViewController {
    
    // 이미지 비동기화
    func SDWEBIMAGE(IV: UIImageView, IU: String, PH: UIImage?, RD: CGFloat, CM: UIView.ContentMode) {
        
//        SDImageCache.shared.clearMemory(); SDImageCache.shared.clearDisk()
        IV.layer.cornerRadius = RD; IV.clipsToBounds = true; IV.contentMode = CM
        
        let FT = IU.replacingOccurrences(of: "https://apt.uic.mehttps://apt.uic.me", with: "https://apt.uic.me").replacingOccurrences(of: ".jpg.jpg", with: ".jpg")
        
//        if IU.contains("firebase") {
//            Storage.storage().reference(forURL: IU).getData(maxSize: 1 * 1024 * 1024) { data, error in
//                if let _ = error { IV.image = PH! } else { IV.image = UIImage(data: data!) }
//            }
//        }
        if IU != "" {
            if IU.contains("firebase") && PH != nil {
                IV.sd_setImage(with: URL(string: FT)!, placeholderImage: PH)
            } else if PH != nil {
                IV.sd_setImage(with: URL(string: FT.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "")!, placeholderImage: PH)
            } else {
                IV.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
                IV.sd_setImage(with: URL(string: FT.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "")!)
            }
        } else {
            IV.image = PH ?? UIImage(named: "main_bg.png")
        }
    }
    
    // 비디오 썸네일
    func SDWEBVIDEO(IV: UIImageView, IU: String, PH: UIImage?, RD: CGFloat, CM: UIView.ContentMode) {
        
        IV.layer.cornerRadius = RD; IV.clipsToBounds = true; IV.contentMode = CM
//        UIIndicatorView().sharedInstance.showIndicator()
        
        if IU != "" {
            DispatchQueue.global().async {
                do {
                    let ASSET = AVAsset(url: URL(string: IU)!)
                    let IMAGE_GENERATOR = AVAssetImageGenerator(asset: ASSET); IMAGE_GENERATOR.appliesPreferredTrackTransform = true
                    let CG_IMAGE = try IMAGE_GENERATOR.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
                    DispatchQueue.main.async { IV.image = UIImage(cgImage: CG_IMAGE) }
                } catch {
                    IV.image = PH ?? UIImage(named: "main_bg.png")
                }
            }
        } else {
            IV.image = PH ?? UIImage(named: "main_bg.png")
        }
    }
    
    // 비디오 플레이어
    func VIDIO_PLAYER(OBJ_MEDIA: [SOSIK_D], TAG: Int, PROTOCOL: UIViewController?) {
        
        let DATA = OBJ_MEDIA[TAG]
        if DATA.MEDIA_TYPE == "M" && DATA.MEDIA_URL != "" {
            
            let PLAYER = AVPlayer(url: URL(string: DATA.MEDIA_URL)!)
            let PLAYER_VC = AVPlayerViewController()
            
            PLAYER_VC.player = PLAYER
            PLAYER.play()
            PROTOCOL!.present(PLAYER_VC, animated: true, completion: nil)
        }
    }
}
