//
//  VC_LOCATE.swift
//  Apartment
//
//  Created by 장 제현 on 2021/07/02.
//

import UIKit
import MapKit

class VC_LOCATE: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) { return .darkContent } else { return .default }
    }
    
    @IBOutlet weak var BACK_V: UINeumorphicView!
    @IBOutlet weak var NAVI_L: UILabel!
    
    var TITLE: String = ""
    
    var OBJ_FAMILY: [FAMILY] = []; var POSITION: Int = 0
    var OBJ_LOCATE: [LOCATE] = []
    
    var COORDINATE: [CLLocationCoordinate2D] = []
    
    @IBOutlet weak var MAPVIEW: MKMapView!
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var CUSTOM_I1: UIImageView!
    @IBOutlet weak var CUSTOM_L1: UILabel!
    @IBOutlet weak var CUSTOM_V2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        NAVI_L.titleFont(size: 18); NAVI_L.text = TITLE
        
        if TITLE == "최근위치" {
            GET_LOCATE(NAME: "최근위치(목록)", AC_TYPE: "list")
        } else if TITLE == "이동경로" {
            GET_LOCATE(NAME: "이동경로(목록)", AC_TYPE: "list")
        }
        
        // 맵뷰
        MAPVIEW.delegate = self; MAPVIEW.showsCompass = false; MAPVIEW.showsScale = false; MAPVIEW.showsUserLocation = true
        if #available(iOS 13.0, *) { MAPVIEW.overrideUserInterfaceStyle = .light }
        
        CUSTOM_V1.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OPTION1(_:))))
        CUSTOM_V1.layer.cornerRadius = 25; CUSTOM_V1.clipsToBounds = true
        CUSTOM_V2.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OPTION2(_:))))
        CUSTOM_V2.layer.cornerRadius = 25; CUSTOM_V2.clipsToBounds = true
    }
    
    @objc func OPTION1(_ sender: UITapGestureRecognizer) {
        
        UIViewController.APPDELEGATE.LOC_MANAGER.requestAlwaysAuthorization()
        // 현위치
        if MAPVIEW.userTrackingMode == .none {
            CUSTOM_V1.backgroundColor = .H_2B3F6B; CUSTOM_I1.tintColor = .white; CUSTOM_L1.textColor = .white
            MAPVIEW.setUserTrackingMode(.follow, animated: true)
        } else if MAPVIEW.userTrackingMode == .follow {
            CUSTOM_V1.backgroundColor = .H_FFAC0F; CUSTOM_I1.tintColor = .white; CUSTOM_L1.textColor = .white
            MAPVIEW.setUserTrackingMode(.followWithHeading, animated: true)
        } else if MAPVIEW.userTrackingMode == .followWithHeading {
            CUSTOM_V1.backgroundColor = .white; CUSTOM_I1.tintColor = .H_2B3F6B; CUSTOM_L1.textColor = .H_2B3F6B
            MAPVIEW.setUserTrackingMode(.none, animated: true)
        }
    }
    
    @objc func OPTION2(_ sender: UITapGestureRecognizer) {
        // 길찾기
        if OBJ_LOCATE.count == 0 {

            let ALERT = UIAlertController(title: "위치 데이터 없음", message: "자녀의 위치 데이터가 없을 경우 안내 기능을 사용할 수 없습니다.", preferredStyle: .alert)
            ALERT.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
            present(ALERT, animated: true)
        } else {

            let ALERT = UIAlertController(title: "\'비스타 동원\'이(가)\n\'지도\'을(를) 열려고 합니다", message: nil, preferredStyle: .alert)
            ALERT.addAction(UIAlertAction(title: "열기", style: .default, handler: { (_) in

                let LOCATE = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(self.OBJ_LOCATE[0].LAT) ?? 0.0, longitude: Double(self.OBJ_LOCATE[0].LNG) ?? 0.0)))
                LOCATE.name = "가족위치"
                MKMapItem.openMaps(with: [LOCATE], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
            }))
            ALERT.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
            present(ALERT, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
    
    func SETUP() {
        
        for i in 0 ..< OBJ_LOCATE.count {

            let DATA = OBJ_LOCATE[i]

            // 특수 효과 만들기
            let ANNOTATION = MKPointAnnotation()
            ANNOTATION.title = DATA.REG_DATE
            ANNOTATION.subtitle = "오차범위 \(Int(floor(Double(DATA.ACCURACY) ?? 0.0)))m"
            ANNOTATION.coordinate = CLLocationCoordinate2D(latitude: Double(DATA.LAT) ?? 0.0, longitude: Double(DATA.LNG) ?? 0.0)
            MAPVIEW.addAnnotation(ANNOTATION)
            
            COORDINATE.append(CLLocationCoordinate2D(latitude: Double(DATA.LAT) ?? 0.0, longitude: Double(DATA.LNG) ?? 0.0))
        }
        
        let DATA = OBJ_LOCATE[0]
        
        // 특수 효과 확대
        let CENTER = CLLocationCoordinate2D(latitude: Double(DATA.LAT) ?? 0.0, longitude: Double(DATA.LNG) ?? 0.0)
        let SPAN = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let REGION = MKCoordinateRegion(center: CENTER, span: SPAN)
        MAPVIEW.setRegion(REGION, animated: true)
        
        // 라인
        MAPVIEW.addOverlay(MKPolyline(coordinates: COORDINATE, count: COORDINATE.count))
    }
}

extension VC_LOCATE: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let LINE_RENDER = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        LINE_RENDER.strokeColor = .H_2B3F6B; LINE_RENDER.lineWidth = 4
        return LINE_RENDER
    }
}
