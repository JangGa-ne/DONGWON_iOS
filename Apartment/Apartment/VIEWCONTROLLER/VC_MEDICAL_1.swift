//
//  VC_MEDICAL_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/11.
//

import UIKit
import MapKit
import CoreLocation

/// 병원/약국(디테일)
class VC_MEDICAL_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    
    var OBJ_MEDICAL: [MEDICAL_L] = []
    var POSITION: Int = 0
    
    @IBOutlet weak var MKMAPVIEW: MKMapView!
    @IBOutlet weak var NAME_L: UILabel!
    @IBOutlet weak var NUMBER_L: UILabel!
    @IBOutlet weak var ADDR_L: UILabel!
    @IBOutlet weak var CALL_B: UINeumorphicView!
    @IBOutlet weak var LOAD_B: UINeumorphicView!
    
    override func loadView() {
        super.loadView()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        
        MKMAPVIEW.showsCompass = false; MKMAPVIEW.showsScale = false; MKMAPVIEW.showsUserLocation = true
        if #available(iOS 13.0, *) { MKMAPVIEW.overrideUserInterfaceStyle = .light }
        
        CALL_B.RADIUS = 22; CALL_B.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CALL_B(_:))))
        LOAD_B.RADIUS = 22; LOAD_B.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LOAD_B(_:))))
    }
    
    @objc func CALL_B(_ sender: UITapGestureRecognizer) {
        
        UIApplication.shared.open(URL(string: "tel://" + OBJ_MEDICAL[POSITION].TEL_NO)!)
    }
    @objc func LOAD_B(_ sender: UITapGestureRecognizer) {
        
        let DATA = OBJ_MEDICAL[POSITION]
        let ALERT = UIAlertController(title: "\'아파트4U\'이(가)\n\'지도\'을(를) 열려고 합니다", message: nil, preferredStyle: .alert)
        ALERT.addAction(UIAlertAction(title: "열기", style: .default, handler: { (_) in
            let MKMAPITEM = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(DATA.LAT) ?? 0.0, longitude: Double(DATA.LNG) ?? 0.0)))
            MKMAPITEM.name = DATA.HOS_NAME; MKMAPITEM.phoneNumber = DATA.TEL_NO
            MKMapItem.openMaps(with: [MKMAPITEM], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }))
        ALERT.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(ALERT, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIViewController.APPDELEGATE.LOC_UPDATE()
        
        let DATA = OBJ_MEDICAL[POSITION]
        
        let ANNOTATION = MKPointAnnotation()
        ANNOTATION.title = DATA.HOS_NAME
        ANNOTATION.subtitle = "\(DATA.ADDR)\n\(NUMBER(DATA.TEL_NO.count, DATA.TEL_NO))"
        ANNOTATION.coordinate = CLLocationCoordinate2D(latitude: Double(DATA.LAT) ?? 0.0, longitude: Double(DATA.LNG) ?? 0.0)
        MKMAPVIEW.addAnnotation(ANNOTATION)
        
        let CENTER = CLLocationCoordinate2D(latitude: Double(DATA.LAT) ?? 0.0, longitude: Double(DATA.LNG) ?? 0.0)
        let SPAN = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let REGION = MKCoordinateRegion(center: CENTER, span: SPAN)
        MKMAPVIEW.setRegion(REGION, animated: true)
        
        NAME_L.text = DT_CHECK(DATA.HOS_NAME)
        NUMBER_L.text = DT_CHECK(NUMBER(DATA.TEL_NO.count, DATA.TEL_NO))
        ADDR_L.text = DT_CHECK(DATA.ADDR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}
