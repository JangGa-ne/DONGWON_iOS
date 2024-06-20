//
//  VC_COMMUNITY_TC.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/16.
//

import UIKit

class VC_COMMUNITY_CC: UICollectionViewCell {
    
    @IBOutlet weak var CUSTOM_SV1: UIStackView!
    @IBOutlet weak var THUMB_I: UIImageView!
    @IBOutlet weak var TITLE_L: UILabel!
}

/// 그룹설정(목록)
class VC_COMMUNITY_TC: UITableViewCell {
    
    var PROTOCOL: UIViewController?
    
    var OBJ_COMMUNITY_L1: [COMMUNITY] = []
    
    @IBOutlet weak var COLLECTIONVIEW: UICollectionView!
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var THUMB_I: UIImageView!
    @IBOutlet weak var TITLE_L: UILabel!
    @IBOutlet weak var COUNT_L: UILabel!
    @IBOutlet weak var JOIN_B: UIButton!
    
    func viewDidLoad() {
        
        let LAYOUT = UICollectionViewFlowLayout()
        LAYOUT.minimumLineSpacing = 10; LAYOUT.minimumInteritemSpacing = 10; LAYOUT.scrollDirection = .horizontal
        COLLECTIONVIEW.setCollectionViewLayout(LAYOUT, animated: false)
        COLLECTIONVIEW.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        COLLECTIONVIEW.delegate = self; COLLECTIONVIEW.dataSource = self
    }
}

extension VC_COMMUNITY_TC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if OBJ_COMMUNITY_L1.count > 0 { return OBJ_COMMUNITY_L1.count } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let DATA = OBJ_COMMUNITY_L1[indexPath.item]
        let CELL = collectionView.dequeueReusableCell(withReuseIdentifier: "VC_COMMUNITY_CC", for: indexPath) as! VC_COMMUNITY_CC
        CELL.layer.borderWidth = 1; CELL.layer.borderColor = UIColor.lightGray.cgColor
        CELL.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
        
        CELL.CUSTOM_SV1.layer.cornerRadius = 15; CELL.CUSTOM_SV1.clipsToBounds = true
        
        PROTOCOL!.SDWEBIMAGE(IV: CELL.THUMB_I, IU: DATA.CC_IMG, PH: UIImage(named: "main_bg.png"), RD: 0, CM: .scaleAspectFill)
        
        CELL.TITLE_L.text = PROTOCOL!.DT_CHECK(DATA.CC_NAME)
        
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let VC = PROTOCOL!.storyboard?.instantiateViewController(withIdentifier: "VC_COMMUNITY_1") as! VC_COMMUNITY_1
        VC.OBJ_COMMUNITY = OBJ_COMMUNITY_L1; VC.POSITION = indexPath.item
        PROTOCOL!.navigationController?.pushViewController(VC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
}
