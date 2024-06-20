//
//  VC_DELIVERY_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/14.
//

import UIKit

class VC_DELIVERY_1_CC: UICollectionViewCell {
    
    @IBOutlet weak var NAME_L: UILabel!
}

/// 배송조회(등록)
class VC_DELIVERY_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func BACK_B(_ sender: UIButton) {
        
        NUMBER_TF.resignFirstResponder()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        
            if self.NUMBER_TF.text! == "" {
                self.dismiss(animated: true, completion: nil)
            } else {
            
                let ALERT = UIAlertController(title: "", message: "작성중인 항목을 삭제하시겠습니까?", preferredStyle: .alert)
                
                ALERT.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in self.dismiss(animated: true, completion: nil) }))
                ALERT.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                
                self.present(ALERT, animated: true, completion: nil)
            }
        }
    }
    
    var OBJ_DELIVERY: [DELIVERY_L2] = []
    var POSITION: Int = 0
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var NUMBER_TF: UITextField!
    @IBOutlet weak var EDIT_B: UIButton!
    @IBOutlet weak var COLLECTIONVIEW: UICollectionView!
    
    override func loadView() {
        super.loadView()
        
        S_KEYBOARD()
        
        if DEVICE_RATIO() { CUSTOM_V1.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 15) }
        
        PLACEHOLDER(TF: NUMBER_TF, PH: "운송장번호를 입력해 주세요.")
        EDIT_B.layer.cornerRadius = 15; EDIT_B.clipsToBounds = true
        
        let LAYOUT = UICollectionViewFlowLayout()
        LAYOUT.minimumInteritemSpacing = 10; LAYOUT.minimumLineSpacing = 10; LAYOUT.scrollDirection = .horizontal
        COLLECTIONVIEW.setCollectionViewLayout(LAYOUT, animated: false)
        COLLECTIONVIEW.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EDIT_B.addTarget(self, action: #selector(EDIT_B(_:)), for: .touchUpInside)
        
        COLLECTIONVIEW.delegate = self; COLLECTIONVIEW.dataSource = self; COLLECTIONVIEW.isScrollEnabled = false
        
        GET_DELIVERY_L2(NAME: "택배회사(목록)", AC_TYPE: "get")
    }
    
    @objc func EDIT_B(_ sender: UIButton) {
        
        if NUMBER_TF.text! == "" {
            S_NOTICE(":( 미입력된 항목이 있습니다")
        } else {
            PUT_DELIVERY(NAME: "배송정보(추가)", AC_TYPE: "insert")
        }
    }
}

extension VC_DELIVERY_1: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if OBJ_DELIVERY.count != 0 { COLLECTIONVIEW.isScrollEnabled = true; return OBJ_DELIVERY.count } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let DATA = OBJ_DELIVERY[indexPath.item]
        let CELL = collectionView.dequeueReusableCell(withReuseIdentifier: "VC_DELIVERY_1_CC", for: indexPath) as! VC_DELIVERY_1_CC
        
        CELL.layer.cornerRadius = 7.5; CELL.clipsToBounds = true
        
        if POSITION == indexPath.item {
            CELL.backgroundColor = .H_4E177C; CELL.NAME_L.textColor = .white
        } else {
            CELL.backgroundColor = .H_E1E1EB; CELL.NAME_L.textColor = .black
        }
        
        CELL.NAME_L.text = DT_CHECK(DATA.POST_COMPANY)
        
        return CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        POSITION = indexPath.item; collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-40)/3-10, height: collectionView.frame.height/3-10)
    }
}
