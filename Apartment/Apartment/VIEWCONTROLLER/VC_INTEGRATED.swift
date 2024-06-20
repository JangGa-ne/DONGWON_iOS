//
//  VC_INTEGRATED.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/15.
//

import UIKit

class VC_INTEGRATED_CC: UICollectionViewCell {
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var THUMB_I: UIImageView!
}

/// 통합예약(목록)
class VC_INTEGRATED: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
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
        
        COLLECTIONVIEW.delegate = self; COLLECTIONVIEW.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_INTEGRATED: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let CELL = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TITLE_CC", for: indexPath) as! TITLE_CC
        CELL.TITLE_L.titleFont(size: 30)
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let CELL = collectionView.dequeueReusableCell(withReuseIdentifier: "VC_INTEGRATED_CC", for: indexPath) as! VC_INTEGRATED_CC
        
        CELL.layer.borderWidth = 1; CELL.layer.borderColor = UIColor.lightGray.cgColor
        CELL.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
        CELL.CUSTOM_V1.layer.cornerRadius = 15; CELL.CUSTOM_V1.clipsToBounds = true
        
        CELL.NAME_L.text = ["이사", "입주청소", "인테리어", "기타"][indexPath.item]
        
        CELL.CUSTOM_V2.roundCorners(corners: [.layerMinXMaxYCorner], radius: 15)
        
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 60) / 2, height: (collectionView.frame.size.width - 60) / 2 - 20)
    }
}

extension VC_INTEGRATED: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > 0 { NAVI_L.alpha = OFFSET_Y/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
