//
//  VC_RESTAURANT.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/27.
//

import UIKit

class VC_RESTAURANT_CC: UICollectionViewCell {
    
    @IBOutlet weak var THUMB_I: UIImageView!
    @IBOutlet weak var NAME_L: UILabel!
}

class VC_RESTAURANT: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    var OBJ_RESTAURANT: [RESTAURANT_C] = []
    
    @IBOutlet weak var COLLECTIONVIEW: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        let LAYOUT = UICollectionViewFlowLayout()
        LAYOUT.minimumInteritemSpacing = 10; LAYOUT.minimumLineSpacing = 10; LAYOUT.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        COLLECTIONVIEW.setCollectionViewLayout(LAYOUT, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        COLLECTIONVIEW.delegate = self; COLLECTIONVIEW.dataSource = self; COLLECTIONVIEW.isScrollEnabled = false
        
        GET_RESTAURANT_L(NAME: "동네시설(카테고리)", AC_TYPE: "cate")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_RESTAURANT: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let CELL = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TITLE_CC", for: indexPath) as! TITLE_CC
        CELL.TITLE_L.titleFont(size: 30)
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if OBJ_RESTAURANT.count > 0 { COLLECTIONVIEW.isScrollEnabled = true; return OBJ_RESTAURANT.count } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let DATA = OBJ_RESTAURANT[indexPath.item]
        let CELL = collectionView.dequeueReusableCell(withReuseIdentifier: "VC_RESTAURANT_CC", for: indexPath) as! VC_RESTAURANT_CC
        
        CELL.layer.borderWidth = 1; CELL.layer.borderColor = UIColor.lightGray.cgColor
        CELL.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
        
        SDWEBIMAGE(IV: CELL.THUMB_I, IU: DATA.CATE_ICON, PH: UIImage(named: "main_bg.png"), RD: 15, CM: .scaleAspectFill)
        CELL.NAME_L.layer.cornerRadius = 7.5; CELL.NAME_L.clipsToBounds = true
        CELL.NAME_L.text = DT_CHECK(DATA.CATE_NAME)
        
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let VC = storyboard?.instantiateViewController(withIdentifier: "VC_RESTAURANT_1") as! VC_RESTAURANT_1
//        VC.OBJ_RESTAURANT_L = OBJ_RESTAURANT; VC.POSITION = indexPath.item
//        navigationController?.pushViewController(VC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 60) / 3, height: (collectionView.frame.size.width - 60) / 3)
    }
}

extension VC_RESTAURANT: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > 0 { NAVI_L.alpha = OFFSET_Y/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
