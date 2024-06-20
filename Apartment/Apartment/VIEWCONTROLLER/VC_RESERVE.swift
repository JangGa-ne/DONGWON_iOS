//
//  VC_RESERVE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/28.
//

import UIKit

class VC_RESERVE_CC: UICollectionViewCell {
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var STATE_L: UILabel!
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var THUMB_I: UIImageView!
    @IBOutlet weak var TYPE_V: UIView!
}

/// 시설예약(목록)
class VC_RESERVE: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    var OBJ_RESERVE: [RESERVE_L] = []
    
    @IBOutlet weak var COLLECTIONVIEW: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        let LAYOUT = UICollectionViewFlowLayout()
        LAYOUT.minimumInteritemSpacing = 20; LAYOUT.minimumLineSpacing = 20; LAYOUT.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        COLLECTIONVIEW.setCollectionViewLayout(LAYOUT, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        COLLECTIONVIEW.delegate = self; COLLECTIONVIEW.dataSource = self; COLLECTIONVIEW.isScrollEnabled = false
        
        GET_RESERVE(NAME: "시설예약(목록)", AC_TYPE: "list")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_RESERVE: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let CELL = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TITLE_CC", for: indexPath) as! TITLE_CC
        CELL.TITLE_L.titleFont(size: 30)
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if OBJ_RESERVE.count > 0 { COLLECTIONVIEW.isScrollEnabled = true; return OBJ_RESERVE.count } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let DATA = OBJ_RESERVE[indexPath.item]
        let CELL = collectionView.dequeueReusableCell(withReuseIdentifier: "VC_RESERVE_CC1", for: indexPath) as! VC_RESERVE_CC
        
        CELL.layer.borderWidth = 1; CELL.layer.borderColor = UIColor.lightGray.cgColor
        CELL.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
        CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
        
        CELL.NAME_L.text = DT_CHECK(DATA.FACIL_CODE_NAME)
        if DATA.FACIL_OPEN == "Y" { CELL.STATE_L.text = "예약가능" } else { CELL.STATE_L.text = "모집마감" }
        
        CELL.CUSTOM_V2.roundCorners(corners: [.layerMinXMaxYCorner], radius: 15)
        SDWEBIMAGE(IV: CELL.THUMB_I, IU: DATA.ICON_URL, PH: UIImage(named: "reserve.png"), RD: CELL.THUMB_I.frame.width/2, CM: .scaleAspectFit)
        
        CELL.TYPE_V.layer.cornerRadius = 5; CELL.TYPE_V.clipsToBounds = true
        if DATA.BOOK_ONETIME_USE == "member" { CELL.TYPE_V.backgroundColor = .H_61C0A7 } else { CELL.TYPE_V.backgroundColor = .darkGray }
        
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let VC = storyboard?.instantiateViewController(withIdentifier: "VC_RESERVE_1") as! VC_RESERVE_1
//        VC.OBJ_RESERVE_L = OBJ_RESERVE; VC.POSITION = indexPath.item
//        navigationController?.pushViewController(VC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 60) / 2, height: (collectionView.frame.size.width - 60) / 2 - 20)
    }
}

extension VC_RESERVE: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > 0 { NAVI_L.alpha = OFFSET_Y/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
