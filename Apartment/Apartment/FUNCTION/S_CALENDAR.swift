//
//  S_S_CALENDAR.swift
//  Kkumnamu
//
//  Created by 장 제현 on 2021/11/15.
//

import UIKit
import CVCalendar

// 캘린더
class S_CALENDAR: UITableViewCell {
    
    var PROTOCOL: VC_SOSIK?
    var OBJ_SOSIK: [Apartment.SOSIK_L2] = []
    
    let DF = DateFormatter()
    
    var AN_FINISHED: Bool = true; var CR_CALENDAR: Calendar?
    
    @IBOutlet weak var CUSTOM_V1: UIView!
    @IBOutlet weak var MONTH: UILabel!
    @IBOutlet weak var CALENDARVIEW: CVCalendarView!
}

extension S_CALENDAR: CVCalendarViewDelegate, CVCalendarViewAppearanceDelegate, CVCalendarMenuViewDelegate {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        UIViewController.APPDELEGATE.S_CALENDAR_DEL = self
        
        CR_CALENDAR = Calendar(identifier: .gregorian)
        CR_CALENDAR?.locale = Locale(identifier: "ko_kr")
        CR_CALENDAR?.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        if let CR_CALENDAR = CR_CALENDAR { MONTH.text = CVDate(date: Date(), calendar: CR_CALENDAR).globalDescription }
    }
    
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    func calendar() -> Calendar? {
        return CR_CALENDAR
    }
    
    func dotMarker(shouldShowOnDayView dayView: DayView) -> Bool {
        
        var MARKER: Bool?
        for DATA in OBJ_SOSIK {
            
            DF.dateFormat = "yyyy-MM-dd HH:mm:ss"; DF.locale = Locale(identifier: "ko_kr"); DF.timeZone = TimeZone(identifier: "Asia/Seoul")
            let DATETIME = DF.date(from: DATA.AP_REQUEST_TIME)!
            let YEAR = DateFormatter(); YEAR.dateFormat = "yyyy"
            let MONTH = DateFormatter(); MONTH.dateFormat = "MM"
            let DAY = DateFormatter(); DAY.dateFormat = "dd"
            
            if !dayView.isHidden && dayView.date != nil {
                if (dayView.date.year == Int(YEAR.string(from: DATETIME))) && (dayView.date.month == Int(MONTH.string(from: DATETIME))) && (dayView.date.day == Int(DAY.string(from: DATETIME))) { MARKER = true; return MARKER ?? true }
            }
        }
        
        return MARKER ?? false
    }
    
    // Dot 크기
    func dotMarker(sizeOnDayView dayView: DayView) -> CGFloat {
        return 15
    }
    // Dot 색상
    func dotMarker(colorOnDayView dayView: DayView) -> [UIColor] {
        return [.H_61C0A7]
    }
    // Dot 위치
    func dotMarker(moveOffsetOnDayView dayView: DayView) -> CGFloat {
        return 15
    }
    // Dot 이동
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: DayView) -> Bool {
        return false
    }
    
    func presentedDateUpdated(_ date: CVDate) {
        
        if MONTH.text != date.globalDescription && AN_FINISHED { MONTH.text = date.globalDescription
            // 데이터 삭제
            OBJ_SOSIK.removeAll()
            
            let MONTH = date.globalDescription.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: ".", with: "")
            PROTOCOL!.GET_SOSIK_L2(NAME: "\(PROTOCOL!.NAVI_L.text!)(목록)", AC_TYPE: "", LM_START: 0, MONTH: MONTH)
        }
    }
    
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? UIColor.systemRed : UIColor.systemRed
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool) {
        // 데이터 삭제
        PROTOCOL!.OBJ_CALENDAR.removeAll()
        
        for i in 0 ..< OBJ_SOSIK.count { DF.dateFormat = "yyyy-MM-dd"
            
            let DATA = OBJ_SOSIK[i]
            let UD_DATE = DF.string(from: dayView.date.convertedDate()!)
            let SV_DATE = DATA.AP_REQUEST_TIME
            let RANGE = SV_DATE.startIndex ..< SV_DATE.index(SV_DATE.startIndex, offsetBy: 10)
            // 데이터 추가
            if UD_DATE == SV_DATE[RANGE] { PROTOCOL!.OBJ_CALENDAR.append(DATA) }
        }
        
        PROTOCOL!.TABLEVIEW.reloadData()
    }
}

