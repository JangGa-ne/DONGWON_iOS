//
//  VC_RESERVE_1.swift
//  Apartment
//
//  Created by 장 제현 on 2021/04/12.
//

import UIKit
import CVCalendar

/// 시설예약(디테일)
class VC_RESERVE_1: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var BACKGROUND_I: UIImageView!
    @IBOutlet weak var BACKGROUND_I_HEIGHT: NSLayoutConstraint!
    @IBOutlet weak var NAVI_V: UIView!
    @IBOutlet weak var NAVI_L: UILabel!
    @IBOutlet weak var BACK_V: UIView!
    
    var OBJ_RESERVE_L: [RESERVE_L] = []
    var OBJ_RESERVE_D: [RESERVE_D] = []
    var POSITION: Int = 0
    
    var AN_FINISHED: Bool = true
    var CR_CALENDAR: Calendar?
    
    @IBOutlet weak var SCROLLVIEW: UIScrollView!
    
    @IBOutlet weak var CUSTOM_V1_HEIGHT: NSLayoutConstraint!
    @IBOutlet weak var TITLE_L1: UILabel!
    @IBOutlet weak var TIME_L: UILabel!
    
    @IBOutlet weak var CUSTOM_V2: UIView!
    @IBOutlet weak var CONTENTS_TV: UITextView!
    
    @IBOutlet weak var CUSTOM_V3: UIView!
    @IBOutlet weak var CUSTOM_V3_1: UIView!
    @IBOutlet weak var MONTH_L: UILabel!
    @IBOutlet weak var CALENDARVIEW: CVCalendarView!
    @IBOutlet weak var CUSTOM_SV1: UIStackView!
    var CUSTOM_V3_2: UIView!
    var CUSTOM_L1: UILabel!
    var CUSTOM_I1: UIImageView!
    
    @IBOutlet weak var CUSTOM_V4: UIView!
    @IBOutlet weak var CUSTOM_SV2: UIStackView!
    
    @IBOutlet weak var SUBMIT_L: UILabel!
    @IBOutlet weak var NEXT_B: UIButton!
    
    override func loadView() {
        super.loadView()
        
        BACKGROUND_I_HEIGHT.constant = UIViewController.STATUS_Y + 240
        NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(0.0); NAVI_L.titleFont(size: 18)
        BACK_V.layer.cornerRadius = 10; BACK_V.clipsToBounds = true
        NAVI_L.alpha = 0.0
        
        CUSTOM_V1_HEIGHT.constant = 190
        TITLE_L1.titleFont(size: 24)
        CUSTOM_V2.layer.cornerRadius = 15; CUSTOM_V2.clipsToBounds = true
        CONTENTS_TV.dataDetectorTypes = .link; CONTENTS_TV.isEditable = false
        CUSTOM_V3.layer.cornerRadius = 15; CUSTOM_V3.clipsToBounds = true
        CUSTOM_V3_1.layer.cornerRadius = 7.5; CUSTOM_V3_1.clipsToBounds = true
        
        DF.dateFormat = "yyyy-MM-dd"
        CR_CALENDAR = Calendar(identifier: .gregorian)
        CR_CALENDAR?.locale = Locale(identifier: "ko_kr")
        CR_CALENDAR?.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        CUSTOM_V4.layer.cornerRadius = 15; CUSTOM_V4.clipsToBounds = true
        
        if let CR_CALENDAR = CR_CALENDAR { MONTH_L.text = CVDate(date: Date(), calendar: CR_CALENDAR).globalDescription }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        CALENDARVIEW.commitCalendarViewUpdate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BACK_V.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BACK_V(_:))))
        
        SCROLLVIEW.delegate = self
        
        let DATA = OBJ_RESERVE_L[POSITION]
        
        SDWEBIMAGE(IV: BACKGROUND_I, IU: DATA.FACIL_THUMB, PH: UIImage(named: "town_bg.png"), RD: 0, CM: .scaleAspectFill)
        
        NAVI_L.text = DT_CHECK(DATA.FACIL_CODE_NAME)
        TITLE_L1.text = DT_CHECK(DATA.FACIL_CODE_NAME)
        TIME_L.text = DT_CHECK(DATA.OPEN_INFO)
        CONTENTS_TV.text = DT_CHECK(DATA.FACIL_EXPLAIN)
        
        CALENDARVIEW.delegate = self
        CALENDARVIEW.contentController.refreshPresentedMonth()
        
        if DATA.FACIL_OPEN == "Y" {
            SUBMIT_L.text = "예약하기"; NEXT_B.addTarget(self, action: #selector(NEXT_B(_:)), for: .touchUpInside)
        } else {
            SUBMIT_L.text = "모집마감"
        }
    }
    
    @objc func NEXT_B(_ sender: UIButton) {
        
        var CHECK: Bool = false
        
        for DATA in OBJ_RESERVE_D { if DATA.CHECK { CHECK = true; break } else { CHECK = false } }
        if CHECK { PUT_RESERVE(NAME: "시설예약(등록)", AC_TYPE: "insert") } else { S_NOTICE(":( 미지정된 항목이 있습니다") }
    }
    
    var VIEWS1: [UIView] = []
    var LABELS1: [UILabel] = []
    var IMAGES1: [UIImageView] = []
    var START: String = ""
    var END: String = ""
    var DATE: String = ""
    
    var VIEWS2: [UIView] = []
    var LABELS2: [UILabel] = []
    var IMAGES2: [UIImageView] = []
    
    func SETUP() {
        
        if OBJ_RESERVE_D.count == 0 {
            
            CUSTOM_V3_2 = UIView(); CUSTOM_L1 = UILabel(); CUSTOM_I1 = UIImageView()
            CUSTOM_L1.text = "예약가능한 시간이 없습니다."
            SETTING(VIEW: CUSTOM_V3_2, LABEL: CUSTOM_L1, IMAGE: CUSTOM_I1)
            
            VIEWS1[0].addSubview(LABELS1[0])
        } else {
            
            for (I, DATA) in OBJ_RESERVE_D.enumerated() {
                
                CUSTOM_V3_2 = UIView(); CUSTOM_L1 = UILabel(); CUSTOM_I1 = UIImageView()
                CUSTOM_L1.text = DT_CHECK("\(DATA.FACIL_BOOK_START) ~ \(DATA.FACIL_BOOK_END)")
                SETTING(VIEW: CUSTOM_V3_2, LABEL: CUSTOM_L1, IMAGE: CUSTOM_I1)
                
                VIEWS1[I].tag = I; LABELS1[I].tag = I; IMAGES1[I].tag = I
                VIEWS1[I].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CHECK(_:))))
                VIEWS1[I].addSubview(LABELS1[I]); VIEWS1[I].addSubview(IMAGES1[I])
            }
        }
        
        for VIEW in VIEWS1 { CUSTOM_SV1.addArrangedSubview(VIEW) }
    }
    
    func SETTING(VIEW: UIView, LABEL: UILabel, IMAGE: UIImageView) {
        
        VIEW.frame.size.width = CUSTOM_SV1.frame.width
        VIEW.heightAnchor.constraint(equalToConstant: 44).isActive = true
        VIEW.backgroundColor = .H_E1E1EB; VIEW.layer.cornerRadius = 7.5; VIEW.clipsToBounds = true
        LABEL.frame = CGRect(x: VIEW.frame.origin.x+15, y: 0, width: VIEW.frame.size.width-30, height: 44)
        LABEL.textAlignment = .left; LABEL.textColor = .black; LABEL.font = .systemFont(ofSize: 12); LABEL.alpha = 1.0
        IMAGE.frame = CGRect(x: VIEW.frame.maxX-40, y: 9.5, width: 25, height: 25)
        IMAGE.backgroundColor = .clear; IMAGE.image = UIImage(named: "check_off.png"); IMAGE.alpha = 1.0
        VIEWS1.append(VIEW); LABELS1.append(LABEL); IMAGES1.append(IMAGE)
    }
    
    @objc func CHECK(_ sender: UITapGestureRecognizer) {
        
        for i in 0 ..< VIEWS1.count {
            
            let DATA = OBJ_RESERVE_D[i]
            if sender.view!.tag == i { DATA.CHECK = true
                IMAGES1[i].image = UIImage(named: "check_on.png")
                START = DATA.FACIL_BOOK_START; END = DATA.FACIL_BOOK_END; DATE = FM_CUSTOM("\(Date())", "yyyy-MM-dd")
            } else { DATA.CHECK = false
                IMAGES1[i].image = UIImage(named: "check_off.png")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BACK_GESTURE(true)
    }
}

extension VC_RESERVE_1: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let OFFSET_Y = scrollView.contentOffset.y
        
        BACKGROUND_I_HEIGHT.constant = -OFFSET_Y + UIViewController.STATUS_Y + 240
        
        if OFFSET_Y <= 0 {
            NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(0.0)
            NAVI_L.alpha = 0.0
        } else {
            NAVI_V.backgroundColor = .H_2B3F6B.withAlphaComponent(OFFSET_Y/240)
            NAVI_L.alpha = OFFSET_Y/240
        }
    }
}

extension VC_RESERVE_1: CVCalendarViewDelegate, CVCalendarViewAppearanceDelegate, CVCalendarMenuViewDelegate {
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    func calendar() -> Calendar? {
        return CR_CALENDAR
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        if MONTH_L.text != date.globalDescription && AN_FINISHED { MONTH_L.text = date.globalDescription }
    }
    
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? UIColor.systemRed : UIColor.systemRed
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        GET_RESERVE_TIME(NAME: "시설예약(시간)", AC_TYPE: "book_time", FACIL_CODE: OBJ_RESERVE_L[POSITION].FACIL_CODE, BK_DATE: DF.string(from: dayView.date.convertedDate()!))
    }
}

