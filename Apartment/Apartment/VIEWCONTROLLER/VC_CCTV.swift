//
//  VC_CCTV.swift
//  Apartment
//
//  Created by 장 제현 on 2021/05/13.
//

import UIKit

class VC_CCTV_TC: UITableViewCell {
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var CUSTOM_V2: UIView!
}

/// CCTV(목록)
class VC_CCTV: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    var OBJ_CCTV: [CCTV] = []
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var LINE_V: UIView!
    
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0
        
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_CCTV(NAME: "CCTV(목록)", AC_TYPE: "list")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_CCTV: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 } else if OBJ_CCTV.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_CCTV.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let CELL = tableView.dequeueReusableCell(withIdentifier: "TITLE_TC", for: indexPath) as! TITLE_TC
            CELL.TITLE_L.titleFont(size: 30)
            return CELL
        } else {
            
            let DATA = OBJ_CCTV[indexPath.item]
            let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_CCTV_TC", for: indexPath) as! VC_CCTV_TC
            
            CELL.CUSTOM_V1.layer.borderWidth = 1; CELL.CUSTOM_V1.layer.borderColor = UIColor.lightGray.cgColor
            CELL.CUSTOM_V1.roundShadows(color: .black, offset: CGSize(width: 0, height: 5), opcity: 0.1, radius1: 5, radius2: 15)
            
            CELL.NAME_L.text = DT_CHECK(DATA.VIDEO_NAME)
            
            CELL.CUSTOM_V2.roundCorners(corners: [.layerMaxXMaxYCorner], radius: 15)
            
            return CELL
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            
            let VC = storyboard?.instantiateViewController(withIdentifier: "VC_CCTV_1") as! VC_CCTV_1
            VC.OBJ_CCTV = OBJ_CCTV; VC.POSITION = indexPath.item
            navigationController?.pushViewController(VC, animated: true)
        }
    }
}

extension VC_CCTV: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let OFFSET_Y = scrollView.contentOffset.y
        if OFFSET_Y > -44 { NAVI_L.alpha = (OFFSET_Y+44)/10; LINE_V.alpha = 0.1 } else { NAVI_L.alpha = 0.0; LINE_V.alpha = 0.0 }
    }
}
