//
//  VC_ELEVATOR.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/21.
//

import UIKit

class VC_ELEVATOR_TC: UITableViewCell {
    
    @IBOutlet weak var CONTENTS_L: UILabel!
}

/// E/V호출(목록)
class VC_ELEVATOR: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    
    var OBJ_EV: [EV_L] = []
    
    @IBOutlet weak var CUSTOM_B1: UIButton!
    @IBOutlet weak var CUSTOM_B2: UIButton!
//    @IBOutlet weak var CUSTOM_V1: UINeumorphicView!
    @IBOutlet weak var TABLEVIEW: UITableView!
    
    override func loadView() {
        super.loadView()
        
        UIViewController.APPDELEGATE.VC_ELEVATOR_DEL = self
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 30)
        
        CUSTOM_B1.titleLabel?.font = UIFont(name: UIViewController.APPDELEGATE.FT_NAME, size: 20); CUSTOM_B1.setTitleColor(.H_4E177C, for: .normal)
        CUSTOM_B1.layer.cornerRadius = 15; CUSTOM_B1.clipsToBounds = true
        CUSTOM_B1.layer.borderWidth = 4; CUSTOM_B1.layer.borderColor = UIColor.H_4E177C.cgColor
        CUSTOM_B1.tag = 0; CUSTOM_B1.addTarget(self, action: #selector(EV_CONTROL(_:)), for: .touchUpInside)
        CUSTOM_B2.titleLabel?.font = UIFont(name: UIViewController.APPDELEGATE.FT_NAME, size: 20); CUSTOM_B2.setTitleColor(.darkGray, for: .normal)
        CUSTOM_B2.layer.cornerRadius = 15; CUSTOM_B2.clipsToBounds = true
        CUSTOM_B2.layer.borderWidth = 4; CUSTOM_B2.layer.borderColor = UIColor.darkGray.cgColor
        CUSTOM_B2.tag = 1; CUSTOM_B2.addTarget(self, action: #selector(EV_CONTROL(_:)), for: .touchUpInside)
        
//        CUSTOM_V1.RADIUS = 15
        TABLEVIEW.roundCorners(corners: [.layerMinXMinYCorner], radius: 15)
        TABLEVIEW.separatorStyle = .none; TABLEVIEW.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    @objc func EV_CONTROL(_ sender: UIButton) {
        
        let OBJ_LOGIN = UIViewController.APPDELEGATE.OBJ_LOGIN
        let VC = storyboard?.instantiateViewController(withIdentifier: "VC_ELEVATOR_1") as! VC_ELEVATOR_1
        VC.modalPresentationStyle = .overCurrentContext; VC.transitioningDelegate = self
        if sender.tag == 0 {
            VC.TITLE = "우리집으로 호출"; if OBJ_LOGIN.count > 0 { VC.FLOOR.append(OBJ_LOGIN[0].MEMBER_FLOOR) }
        } else {
            VC.TITLE = "공용층으로 호출"; VC.FLOOR = ["1", "B1", "B2", "B3"]
        }
        present(VC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TABLEVIEW.delegate = self; TABLEVIEW.dataSource = self; TABLEVIEW.isScrollEnabled = false
        
        GET_EVCALL(NAME: "EV호출(목록)", AC_TYPE: "list")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_ELEVATOR: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if OBJ_EV.count > 0 { TABLEVIEW.isScrollEnabled = true; return OBJ_EV.count } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let DATA = OBJ_EV[indexPath.item]
        let CELL = tableView.dequeueReusableCell(withIdentifier: "VC_ELEVATOR_TC", for: indexPath) as! VC_ELEVATOR_TC
        
        if DATA.CALL_TO == "" {
            CELL.CONTENTS_L.text = "\(FM_CUSTOM(DATA.CALL_TIME, "MM월dd일 HH시mm분ss초"))에 요청하였습니다."
        } else {
            CELL.CONTENTS_L.text = "\(FM_CUSTOM(DATA.CALL_TIME, "MM월dd일 HH시mm분ss초"))에\n\(DATA.CALL_TO.replacingOccurrences(of: "층", with: ""))층으로 요청하였습니다."
        }
        
        return CELL
    }
}
