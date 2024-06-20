//
//  VC_SOSIK_TC.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/08.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VC_SOSIK_CC: UICollectionViewCell {
    
    let CUSTOM_V1 = UIVisualEffectView()
    let BACKGROUND_I = UIImageView()
    let MEDIA_I = UIImageView()
    let PLAY_I = UIImageView()
    
    let MEDIA_V = WKYTPlayerView()
}

/// 소식(목록)
class VC_SOSIK_TC: UITableViewCell {
    
    var PROTOCOL: UIViewController?
    var DETAIL: Bool = false
    
    var BD_TYPE: String = ""
    var AP_SEQ: String = ""
    var AP_MSG_GROUP: String = ""
    
    var OBJ_MEDIA: [SOSIK_D] = []
    var OBJ_FILE: [SOSIK_D] = []
    
    @IBOutlet weak var TITLE_L: UILabel!
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var PROFILE_I: UIImageView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var ADDR_L: UILabel!
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var PAGE_L: UILabel!
    @IBOutlet weak var COLLECTIONVIEW: UICollectionView!
    @IBOutlet weak var LINE_V: UIView!
    @IBOutlet weak var TYPE_L: UILabel!
    @IBOutlet weak var TYPE_L_WIDTH: NSLayoutConstraint!
    @IBOutlet weak var COUNT_L: UILabel!
    @IBOutlet weak var SUBJECT_L: UILabel!
    @IBOutlet weak var CONTENTS_L: UILabel!
    @IBOutlet weak var CONTENTS_TV: UITextView!
    @IBOutlet weak var FILE_L: UILabel!
    @IBOutlet weak var NICK_L: UILabel!
    @IBOutlet weak var COMMENT_L: UILabel!
    @IBOutlet weak var DATETIME_L: UILabel!
    @IBOutlet weak var DAYS_V: UIView!
    
    func viewDidLoad() {
        
        let LAYOUT = UICollectionViewFlowLayout()
        LAYOUT.minimumLineSpacing = 0; LAYOUT.minimumInteritemSpacing = 0; LAYOUT.scrollDirection = .horizontal
        COLLECTIONVIEW.setCollectionViewLayout(LAYOUT, animated: false)
        if !DETAIL { COLLECTIONVIEW.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15) }
        COLLECTIONVIEW.delegate = self; COLLECTIONVIEW.dataSource = self; COLLECTIONVIEW.reloadData()
    }
}

extension VC_SOSIK_TC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if OBJ_MEDIA.count > 0 { return OBJ_MEDIA.count } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let DATA = OBJ_MEDIA[indexPath.item]
        let CELL = collectionView.dequeueReusableCell(withReuseIdentifier: "VC_SOSIK_CC", for: indexPath) as! VC_SOSIK_CC
        
        if !(DATA.MEDIA_TYPE == "Y" || DATA.MEDIA_TYPE == "y") {
            
            CELL.BACKGROUND_I.frame = CELL.bounds; CELL.BACKGROUND_I.backgroundColor = .clear
            if DATA.MEDIA_URL != "" {
                CELL.CUSTOM_V1.isHidden = false; CELL.CUSTOM_V1.frame = CELL.bounds; CELL.CUSTOM_V1.effect = UIBlurEffect(style: .light)
            } else {
                CELL.CUSTOM_V1.isHidden = true
            }
            CELL.MEDIA_I.frame = CELL.bounds; CELL.MEDIA_I.backgroundColor = .clear
            
            if DATA.MEDIA_TYPE == "P" || DATA.MEDIA_TYPE == "p" { CELL.PLAY_I.isHidden = true
                PROTOCOL!.SDWEBIMAGE(IV: CELL.BACKGROUND_I, IU: DATA.MEDIA_URL, PH: UIImage(named: "main_bg.png"), RD: 0, CM: .scaleAspectFill)
                PROTOCOL!.SDWEBIMAGE(IV: CELL.MEDIA_I, IU: DATA.MEDIA_URL, PH: UIImage(named: "main_bg.png"), RD: 0, CM: .scaleAspectFit)
            } else if DATA.MEDIA_TYPE == "M" || DATA.MEDIA_TYPE == "m" { CELL.PLAY_I.isHidden = false
                PROTOCOL!.SDWEBVIDEO(IV: CELL.BACKGROUND_I, IU: DATA.MEDIA_URL, PH: UIImage(named: "main_bg.png"), RD: 0, CM: .scaleAspectFill)
                PROTOCOL!.SDWEBVIDEO(IV: CELL.MEDIA_I, IU: DATA.MEDIA_URL, PH: UIImage(named: "main_bg.png"), RD: 0, CM: .scaleAspectFit)
            }
            
            if !DETAIL {
                CELL.PLAY_I.frame = CGRect(x: collectionView.frame.minX+15, y: collectionView.frame.maxY-45, width: 30, height: 30)
            } else {
                CELL.PLAY_I.frame = CGRect(x: collectionView.frame.minX+20, y: collectionView.frame.maxY-60, width: 30, height: 30)
            }; CELL.PLAY_I.image = UIImage(named: "play.png")
            
            CELL.addSubview(CELL.BACKGROUND_I); CELL.addSubview(CELL.CUSTOM_V1); CELL.addSubview(CELL.MEDIA_I); CELL.addSubview(CELL.PLAY_I)
        } else { CELL.PLAY_I.isHidden = true
            CELL.MEDIA_V.frame = CELL.bounds; CELL.addSubview(CELL.MEDIA_V); CELL.MEDIA_V.load(withVideoId: DATA.MEDIA_URL)
        }
        
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !DETAIL {
            
            let VC = PROTOCOL!.storyboard?.instantiateViewController(withIdentifier: "VC_SOSIK_1") as! VC_SOSIK_1
            VC.BD_TYPE = BD_TYPE; VC.AP_SEQ = AP_SEQ; VC.AP_MSG_GROUP = AP_MSG_GROUP
            PROTOCOL!.navigationController?.pushViewController(VC, animated: true)
        } else {
            
            let DATA = OBJ_MEDIA[indexPath.item]
            if DATA.MEDIA_TYPE == "M" || DATA.MEDIA_TYPE == "m" {
                PROTOCOL!.VIDIO_PLAYER(OBJ_MEDIA: OBJ_MEDIA, TAG: indexPath.item, PROTOCOL: PROTOCOL)
            } else {
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        PAGE_L.text = "\(Int(targetContentOffset.pointee.x / COLLECTIONVIEW.frame.width) + 1)/\(OBJ_MEDIA.count)"
    }
}
