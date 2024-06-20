//
//  P_API.swift
//  Apartment
//
//  Created by 장 제현 on 2021/03/28.
//

import Foundation

/// var <#name#>: String = ""
/// func SET_<#name#>(<#name#>: Any) { self.<#name#> = <#name#> as? String ?? "" }

let P_URL: String = "https://apt.uic.me/access/v1"

// 소프트웨어 업데이트
struct SW_UPDATE {
    
    var VERSION: String = ""
    var ARTIST_NAME: String = ""
    var FILE_SIZE_BYTES: String = ""
    var RELEASE_NOTES: String = ""
    var DESCRIPTION: String = ""
    var SUPPORTED_DEVICES: [String] = []
    var TRACKVIEW_URL: String = ""
}

// 인증번호(확인)
class AUTH {
    
    var ADMIN_NUMBER: String = ""
    var AP_CODE: String = ""
    var AP_NAME: String = ""
    var BG_NAME: String = ""
    var BG_NO: String = ""
    var BK_NAME: String = ""
    var BK_NICK: String = ""
    var BUILDING_ID: String = ""
    var HOME_CODE: String = ""
    var HOUSE_NUMBER: String = ""
    var MB_ID: String = ""
    var MB_LEVEL: String = ""
    var MB_PHOTO: String = ""
    var MB_TYPE: String = ""
    var SD_CODE: String = ""
    var SS_TOKEN: String = ""
    var TUYA_TOKEN: String = ""
    
    func SET_ADMIN_NUMBER(ADMIN_NUMBER: Any) { self.ADMIN_NUMBER = ADMIN_NUMBER as? String ?? "" }
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_AP_NAME(AP_NAME: Any) { self.AP_NAME = AP_NAME as? String ?? "" }
    func SET_BG_NAME(BG_NAME: Any) { self.BG_NAME = BG_NAME as? String ?? "" }
    func SET_BG_NO(BG_NO: Any) { self.BG_NO = BG_NO as? String ?? "" }
    func SET_BK_NAME(BK_NAME: Any) { self.BK_NAME = BK_NAME as? String ?? "" }
    func SET_BK_NICK(BK_NICK: Any) { self.BK_NICK = BK_NICK as? String ?? "" }
    func SET_BUILDING_ID(BUILDING_ID: Any) { self.BUILDING_ID = BUILDING_ID as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_HOUSE_NUMBER(HOUSE_NUMBER: Any) { self.HOUSE_NUMBER = HOUSE_NUMBER as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_MB_LEVEL(MB_LEVEL: Any) { self.MB_LEVEL = MB_LEVEL as? String ?? "" }
    func SET_MB_PHOTO(MB_PHOTO: Any) { self.MB_PHOTO = MB_PHOTO as? String ?? "" }
    func SET_MB_TYPE(MB_TYPE: Any) { self.MB_TYPE = MB_TYPE as? String ?? "" }
    func SET_SD_CODE(SD_CODE: Any) { self.SD_CODE = SD_CODE as? String ?? "" }
    func SET_SS_TOKEN(SS_TOKEN: Any) { self.SS_TOKEN = SS_TOKEN as? String ?? "" }
    func SET_TUYA_TOKEN(TUYA_TOKEN: Any) { self.TUYA_TOKEN = TUYA_TOKEN as? String ?? "" }
}

// 아파트검색(목록)
class SEARCH_L {
    
    var DON_HO_INFO: [SEARCH_D] = []
    var SD_CODE: String = ""
    var AP_CODE: String = ""
    var AP_NAME: String = ""
    var APP_NUMBER: String = ""
    var APT_LOGO: String = ""
    var K_APT_ADDR: String = ""
    var K_APT_LAT: String = ""
    var K_APT_LNG: String = ""
    
    func SET_DON_HO_INFO(DON_HO_INFO: [SEARCH_D]) { self.DON_HO_INFO = DON_HO_INFO }
    func SET_SD_CODE(SD_CODE: Any) { self.SD_CODE = SD_CODE as? String ?? "" }
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_AP_NAME(AP_NAME: Any) { self.AP_NAME = AP_NAME as? String ?? "" }
    func SET_APP_NUMBER(APP_NUMBER: Any) { self.APP_NUMBER = APP_NUMBER as? String ?? "" }
    func SET_APT_LOGO(APT_LOGO: Any) { self.APT_LOGO = APT_LOGO as? String ?? "" }
    func SET_K_APT_ADDR(K_APT_ADDR: Any) { self.K_APT_ADDR = K_APT_ADDR as? String ?? "" }
    func SET_K_APT_LAT(K_APT_LAT: Any) { self.K_APT_LAT = K_APT_LAT as? String ?? "" }
    func SET_K_APT_LNG(K_APT_LNG: Any) { self.K_APT_LNG = K_APT_LNG as? String ?? "" }
}
// 아파트검색(디테일)
class SEARCH_D {
    
    var BUILDING_ID: String = ""
    var HOUSE_INFO: [String] = []
    
    func SET_BUILDING_ID(BUILDING_ID: Any) { self.BUILDING_ID = BUILDING_ID as? String ?? "" }
    func SET_HOUSE_INFO(HOUSE_INFO: Any) { self.HOUSE_INFO = HOUSE_INFO as? [String] ?? [] }
}

// 로그인
class LOGIN {
    
    var AP_CODE: String = ""
    var AP_NAME: String = ""
    var BK_NAME: String = ""
    var BK_NICK: String = ""
    var BUILDING_ID: String = ""
    var FCM_ID: String = ""
    var HOME_ID: String = ""
    var HOME_CODE: String = ""
    var HOME_NAME: String = ""
    var HOME_PHONE: String = ""
    var HOME_SAFE_NUMBER: String = ""
    var HOUSE_NUMBER: String = ""
    var MB_ID: String = ""
    var MB_LEVEL: String = ""
    var MB_PHOTO: String = ""
    var MB_TYPE: String = ""
    var MEMBER_FLOOR: String = ""
    var RESULT: String = ""
    var SAFE_NUMBER: String = ""
    var SC_CITY: String = ""
    var SD_CODE: String = ""
    var SIP_ID: String = ""
    var SIP_IP: String = ""
    var SIP_IP2: String = ""
    var SIP_IP3: String = ""
    var SIP_PORT: String = ""
    var SS_TOKEN: String = ""
    var STUN_PORT: String = ""
    var TUYA_TOKEN: String = ""
    
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_AP_NAME(AP_NAME: Any) { self.AP_NAME = AP_NAME as? String ?? "" }
    func SET_BK_NAME(BK_NAME: Any) { self.BK_NAME = BK_NAME as? String ?? "" }
    func SET_BK_NICK(BK_NICK: Any) { self.BK_NICK = BK_NICK as? String ?? "" }
    func SET_BUILDING_ID(BUILDING_ID: Any) { self.BUILDING_ID = BUILDING_ID as? String ?? "" }
    func SET_FCM_ID(FCM_ID: Any) { self.FCM_ID = FCM_ID as? String ?? "" }
    func SET_HOME_ID(HOME_ID: Any) { self.HOME_ID = HOME_ID as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_HOME_NAME(HOME_NAME: Any) { self.HOME_NAME = HOME_NAME as? String ?? "" }
    func SET_HOME_PHONE(HOME_PHONE: Any) { self.HOME_PHONE = HOME_PHONE as? String ?? "" }
    func SET_HOME_SAFE_NUMBER(HOME_SAFE_NUMBER: Any) { self.HOME_SAFE_NUMBER = HOME_SAFE_NUMBER as? String ?? "" }
    func SET_HOUSE_NUMBER(HOUSE_NUMBER: Any) { self.HOUSE_NUMBER = HOUSE_NUMBER as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_MB_LEVEL(MB_LEVEL: Any) { self.MB_LEVEL = MB_LEVEL as? String ?? "" }
    func SET_MB_PHOTO(MB_PHOTO: Any) { self.MB_PHOTO = MB_PHOTO as? String ?? "" }
    func SET_MB_TYPE(MB_TYPE: Any) { self.MB_TYPE = MB_TYPE as? String ?? "" }
    func SET_MEMBER_FLOOR(MEMBER_FLOOR: Any) { self.MEMBER_FLOOR = MEMBER_FLOOR as? String ?? "" }
    func SET_RESULT(RESULT: Any) { self.RESULT = RESULT as? String ?? "" }
    func SET_SAFE_NUMBER(SAFE_NUMBER: Any) { self.SAFE_NUMBER = SAFE_NUMBER as? String ?? "" }
    func SET_SC_CITY(SC_CITY: Any) { self.SC_CITY = SC_CITY as? String ?? "" }
    func SET_SD_CODE(SD_CODE: Any) { self.SD_CODE = SD_CODE as? String ?? "" }
    func SET_SIP_ID(SIP_ID: Any) { self.SIP_ID = SIP_ID as? String ?? "" }
    func SET_SIP_IP(SIP_IP: Any) { self.SIP_IP = SIP_IP as? String ?? "" }
    func SET_SIP_IP2(SIP_IP2: Any) { self.SIP_IP2 = SIP_IP2 as? String ?? "" }
    func SET_SIP_IP3(SIP_IP3: Any) { self.SIP_IP3 = SIP_IP3 as? String ?? "" }
    func SET_SIP_PORT(SIP_PORT: Any) { self.SIP_PORT = SIP_PORT as? String ?? "" }
    func SET_SS_TOKEN(SS_TOKEN: Any) { self.SS_TOKEN = SS_TOKEN as? String ?? "" }
    func SET_STUN_PORT(STUN_PORT: Any) { self.STUN_PORT = STUN_PORT as? String ?? "" }
    func SET_TUYA_TOKEN(TUYA_TOKEN: Any) { self.TUYA_TOKEN = TUYA_TOKEN as? String ?? "" }
}
// 날씨
class WEATHER {
    
    var AP_ADDR: String = ""
    var AP_LOGO: String = ""
    var AP_NAME: String = ""
    var LGT: String = ""
    var PTY: String = ""
    var REH: String = ""
    var RN1: String = ""
    var SKY: String = ""
    var T1H: String = ""
    var UUU: String = ""
    var VEC: String = ""
    var VVV: String = ""
    var WSD: String = ""
    var PM10VALUE: String = ""
    var PM25VALUE: String = ""
    
    func SET_AP_ADDR(AP_ADDR: Any) { self.AP_ADDR = AP_ADDR as? String ?? "" }
    func SET_AP_LOGO(AP_LOGO: Any) { self.AP_LOGO = AP_LOGO as? String ?? "" }
    func SET_AP_NAME(AP_NAME: Any) { self.AP_NAME = AP_NAME as? String ?? "" }
    func SET_LGT(LGT: Any) { self.LGT = LGT as? String ?? "" }
    func SET_PTY(PTY: Any) { self.PTY = PTY as? String ?? "" }
    func SET_REH(REH: Any) { self.REH = REH as? String ?? "" }
    func SET_RN1(RN1: Any) { self.RN1 = RN1 as? String ?? "" }
    func SET_SKY(SKY: Any) { self.SKY = SKY as? String ?? "" }
    func SET_T1H(T1H: Any) { self.T1H = T1H as? String ?? "" }
    func SET_UUU(UUU: Any) { self.UUU = UUU as? String ?? "" }
    func SET_VEC(VEC: Any) { self.VEC = VEC as? String ?? "" }
    func SET_VVV(VVV: Any) { self.VVV = VVV as? String ?? "" }
    func SET_WSD(WSD: Any) { self.WSD = WSD as? String ?? "" }
    func SET_PM10VALUE(PM10VALUE: Any) { self.PM10VALUE = PM10VALUE as? String ?? "" }
    func SET_PM25VALUE(PM25VALUE: Any) { self.PM25VALUE = PM25VALUE as? String ?? "" }
}
// 소식(공지사항,커뮤니티,동네소식)
class SOSIK_L1 {
    
    var ARRAY_CNT: Int = 0
    var AP_CODE: String = ""
    var AP_COMMENT: String = ""
    var AP_CONTENT_TEXT: String = ""
    var AP_LIKE: String = ""
    var AP_MSG_GROUP: String = ""
    var AP_REQUEST_TIME: String = ""
    var AP_SEQ: String = ""
    var AP_SUBJECT: String = ""
    var AP_SUBJECT_TEXT: String = ""
    var ARTICLE_TYPE: String = ""
    var BADGE_COLOR: String = ""
    var BK_NAME: String = ""
    var BOARD_NAME: String = ""
    var BOARD_TYPE: String = ""
    var CC_CODE: String = ""
    var CC_NAME: String = ""
    var LOGO_URL: String = ""
    var READ_CNT: String = ""
    var SD_CODE: String = ""
    var SENDER_NICK: String = ""
    
    func SET_ARRAY_CNT(ARRAY_CNT: Any) { self.ARRAY_CNT = ARRAY_CNT as? Int ?? 0 }
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_AP_COMMENT(AP_COMMENT: Any) { self.AP_COMMENT = AP_COMMENT as? String ?? "" }
    func SET_AP_CONTENT_TEXT(AP_CONTENT_TEXT: Any) { self.AP_CONTENT_TEXT = AP_CONTENT_TEXT as? String ?? "" }
    func SET_AP_LIKE(AP_LIKE: Any) { self.AP_LIKE = AP_LIKE as? String ?? "" }
    func SET_AP_MSG_GROUP(AP_MSG_GROUP: Any) { self.AP_MSG_GROUP = AP_MSG_GROUP as? String ?? "" }
    func SET_AP_REQUEST_TIME(AP_REQUEST_TIME: Any) { self.AP_REQUEST_TIME = AP_REQUEST_TIME as? String ?? "" }
    func SET_AP_SEQ(AP_SEQ: Any) { self.AP_SEQ = AP_SEQ as? String ?? "" }
    func SET_AP_SUBJECT(AP_SUBJECT: Any) { self.AP_SUBJECT = AP_SUBJECT as? String ?? "" }
    func SET_AP_SUBJECT_TEXT(AP_SUBJECT_TEXT: Any) { self.AP_SUBJECT_TEXT = AP_SUBJECT_TEXT as? String ?? "" }
    func SET_ARTICLE_TYPE(ARTICLE_TYPE: Any) { self.ARTICLE_TYPE = ARTICLE_TYPE as? String ?? "" }
    func SET_BADGE_COLOR(BADGE_COLOR: Any) { self.BADGE_COLOR = BADGE_COLOR as? String ?? "" }
    func SET_BK_NAME(BK_NAME: Any) { self.BK_NAME = BK_NAME as? String ?? "" }
    func SET_BOARD_NAME(BOARD_NAME: Any) { self.BOARD_NAME = BOARD_NAME as? String ?? "" }
    func SET_BOARD_TYPE(BOARD_TYPE: Any) { self.BOARD_TYPE = BOARD_TYPE as? String ?? "" }
    func SET_CC_CODE(CC_CODE: Any) { self.CC_CODE = CC_CODE as? String ?? "" }
    func SET_CC_NAME(CC_NAME: Any) { self.CC_NAME = CC_NAME as? String ?? "" }
    func SET_LOGO_URL(LOGO_URL: Any) { self.LOGO_URL = LOGO_URL as? String ?? "" }
    func SET_READ_CNT(READ_CNT: Any) { self.READ_CNT = READ_CNT as? String ?? "" }
    func SET_SD_CODE(SD_CODE: Any) { self.SD_CODE = SD_CODE as? String ?? "" }
    func SET_SENDER_NICK(SENDER_NICK: Any) { self.SENDER_NICK = SENDER_NICK as? String ?? "" }
}
// 관리비(기본)
struct EXPENESE {
    
    var AMOUNT: String = ""
    var IN_OUT: String = ""
    var TARGET_MONTH: String = ""
}
// 주차정보(기본)
struct PARKING {
    
    var PERM_CAR: String = "0"
    var TEMP_CAR: String = "0"
}
// 전체메뉴(목록)
class ALLMENU_L {
    
    var AP_CODE: String = ""
    var AP_NAME: String = ""
    var CATEGORY_NAME: String = ""
    var CATEGORY_TYPE: String = ""
    var DISPLAY_CONTENT: String = ""
    var DISPLAY_LIST: String = ""
    var DISPLAY_MAIN: String = ""
    var DISPLAY_OFFICE_CONTENT: String = ""
    var DISPLAY_OFFICE_LIST: String = ""
    var DISPLAY_OFFICE_MAIN: String = ""
    var FUNCTION_CODE: String = ""
    var FUNCTION_EXPLAIN: String = ""
    var FUNCTION_NAME: String = ""
    var FUNCTION_ORDER: String = ""
    var ICON_IMG: String = ""
    var IDX: String = ""
    var USE_COMPANY: String = ""
    var USE_MODEL: String = ""
    
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_AP_NAME(AP_NAME: Any) { self.AP_NAME = AP_NAME as? String ?? "" }
    func SET_CATEGORY_NAME(CATEGORY_NAME: Any) { self.CATEGORY_NAME = CATEGORY_NAME as? String ?? "" }
    func SET_CATEGORY_TYPE(CATEGORY_TYPE: Any) { self.CATEGORY_TYPE = CATEGORY_TYPE as? String ?? "" }
    func SET_DISPLAY_CONTENT(DISPLAY_CONTENT: Any) { self.DISPLAY_CONTENT = DISPLAY_CONTENT as? String ?? "" }
    func SET_DISPLAY_LIST(DISPLAY_LIST: Any) { self.DISPLAY_LIST = DISPLAY_LIST as? String ?? "" }
    func SET_DISPLAY_MAIN(DISPLAY_MAIN: Any) { self.DISPLAY_MAIN = DISPLAY_MAIN as? String ?? "" }
    func SET_DISPLAY_OFFICE_CONTENT(DISPLAY_OFFICE_CONTENT: Any) { self.DISPLAY_OFFICE_CONTENT = DISPLAY_OFFICE_CONTENT as? String ?? "" }
    func SET_DISPLAY_OFFICE_LIST(DISPLAY_OFFICE_LIST: Any) { self.DISPLAY_OFFICE_LIST = DISPLAY_OFFICE_LIST as? String ?? "" }
    func SET_DISPLAY_OFFICE_MAIN(DISPLAY_OFFICE_MAIN: Any) { self.DISPLAY_OFFICE_MAIN = DISPLAY_OFFICE_MAIN as? String ?? "" }
    func SET_FUNCTION_CODE(FUNCTION_CODE: Any) { self.FUNCTION_CODE = FUNCTION_CODE as? String ?? "" }
    func SET_FUNCTION_EXPLAIN(FUNCTION_EXPLAIN: Any) { self.FUNCTION_EXPLAIN = FUNCTION_EXPLAIN as? String ?? "" }
    func SET_FUNCTION_NAME(FUNCTION_NAME: Any) { self.FUNCTION_NAME = FUNCTION_NAME as? String ?? "" }
    func SET_FUNCTION_ORDER(FUNCTION_ORDER: Any) { self.FUNCTION_ORDER = FUNCTION_ORDER as? String ?? "" }
    func SET_ICON_IMG(ICON_IMG: Any) { self.ICON_IMG = ICON_IMG as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_USE_COMPANY(USE_COMPANY: Any) { self.USE_COMPANY = USE_COMPANY as? String ?? "" }
    func SET_USE_MODEL(USE_MODEL: Any) { self.USE_MODEL = USE_MODEL as? String ?? "" }
}

// 시설예약(목록)
class RESERVE_L {
    
    var AP_CODE: String = ""
    var AUTO_APPROVE: String = ""
    var BOOK_AVIL_DAYS: String = ""
    var BOOK_ONETIME_USE: String = ""
    var DISPLAY: String = ""
    var FACIL_CODE: String = ""
    var FACIL_CODE_NAME: String = ""
    var FACIL_EXPLAIN: String = ""
    var FACIL_FILE: String = ""
    var FACIL_OPEN: String = ""
    var FACIL_PRICE_MEMBER: String = ""
    var FACIL_PRICE_ONETIME: String = ""
    var FACIL_THUMB: String = ""
    var FACIL_TYPE: String = ""
    var ICON_URL: String = ""
    var IDX: String = ""
    var MANAGER_NAME: String = ""
    var MANAGER_PHONE: String = ""
    var MAX_BOOK_CNT: String = ""
    var MAX_BOOK_TYPE: String = ""
    var MEMBER_ONLY: String = ""
    var MEMBER_USE: String = ""
    var OPEN_INFO: String = ""
    var SEND_QR: String = ""
    var USE_BOOK_TIME: String = ""
    var USER_CNT: String = ""
    
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_AUTO_APPROVE(AUTO_APPROVE: Any) { self.AUTO_APPROVE = AUTO_APPROVE as? String ?? "" }
    func SET_BOOK_AVIL_DAYS(BOOK_AVIL_DAYS: Any) { self.BOOK_AVIL_DAYS = BOOK_AVIL_DAYS as? String ?? "" }
    func SET_BOOK_ONETIME_USE(BOOK_ONETIME_USE: Any) { self.BOOK_ONETIME_USE = BOOK_ONETIME_USE as? String ?? "" }
    func SET_DISPLAY(DISPLAY: Any) { self.DISPLAY = DISPLAY as? String ?? "" }
    func SET_FACIL_CODE(FACIL_CODE: Any) { self.FACIL_CODE = FACIL_CODE as? String ?? "" }
    func SET_FACIL_CODE_NAME(FACIL_CODE_NAME: Any) { self.FACIL_CODE_NAME = FACIL_CODE_NAME as? String ?? "" }
    func SET_FACIL_EXPLAIN(FACIL_EXPLAIN: Any) { self.FACIL_EXPLAIN = FACIL_EXPLAIN as? String ?? "" }
    func SET_FACIL_FILE(FACIL_FILE: Any) { self.FACIL_FILE = FACIL_FILE as? String ?? "" }
    func SET_FACIL_OPEN(FACIL_OPEN: Any) { self.FACIL_OPEN = FACIL_OPEN as? String ?? "" }
    func SET_FACIL_PRICE_MEMBER(FACIL_PRICE_MEMBER: Any) { self.FACIL_PRICE_MEMBER = FACIL_PRICE_MEMBER as? String ?? "" }
    func SET_FACIL_PRICE_ONETIME(FACIL_PRICE_ONETIME: Any) { self.FACIL_PRICE_ONETIME = FACIL_PRICE_ONETIME as? String ?? "" }
    func SET_FACIL_THUMB(FACIL_THUMB: Any) { self.FACIL_THUMB = FACIL_THUMB as? String ?? "" }
    func SET_FACIL_TYPE(FACIL_TYPE: Any) { self.FACIL_TYPE = FACIL_TYPE as? String ?? "" }
    func SET_ICON_URL(ICON_URL: Any) { self.ICON_URL = ICON_URL as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_MANAGER_NAME(MANAGER_NAME: Any) { self.MANAGER_NAME = MANAGER_NAME as? String ?? "" }
    func SET_MANAGER_PHONE(MANAGER_PHONE: Any) { self.MANAGER_PHONE = MANAGER_PHONE as? String ?? "" }
    func SET_MAX_BOOK_CNT(MAX_BOOK_CNT: Any) { self.MAX_BOOK_CNT = MAX_BOOK_CNT as? String ?? "" }
    func SET_MAX_BOOK_TYPE(MAX_BOOK_TYPE: Any) { self.MAX_BOOK_TYPE = MAX_BOOK_TYPE as? String ?? "" }
    func SET_MEMBER_ONLY(MEMBER_ONLY: Any) { self.MEMBER_ONLY = MEMBER_ONLY as? String ?? "" }
    func SET_MEMBER_USE(MEMBER_USE: Any) { self.MEMBER_USE = MEMBER_USE as? String ?? "" }
    func SET_OPEN_INFO(OPEN_INFO: Any) { self.OPEN_INFO = OPEN_INFO as? String ?? "" }
    func SET_SEND_QR(SEND_QR: Any) { self.SEND_QR = SEND_QR as? String ?? "" }
    func SET_USE_BOOK_TIME(USE_BOOK_TIME: Any) { self.USE_BOOK_TIME = USE_BOOK_TIME as? String ?? "" }
    func SET_USER_CNT(USER_CNT: Any) { self.USER_CNT = USER_CNT as? String ?? "" }
}
// 시설예약(시간)
class RESERVE_D {
    
    var CHECK: Bool = false
    var BOOK_AVAIL: String = ""
    var FACIL_BOOK_END: String = ""
    var FACIL_BOOK_START: String = ""
    var FACIL_CODE: String = ""
    var FACIL_DAY: String = ""
    var FACIL_TIME_NAME: String = ""
    var IDX: String = ""
    
    func SET_BOOK_AVAIL(BOOK_AVAIL: Any) { self.BOOK_AVAIL = BOOK_AVAIL as? String ?? "" }
    func SET_FACIL_BOOK_END(FACIL_BOOK_END: Any) { self.FACIL_BOOK_END = FACIL_BOOK_END as? String ?? "" }
    func SET_FACIL_BOOK_START(FACIL_BOOK_START: Any) { self.FACIL_BOOK_START = FACIL_BOOK_START as? String ?? "" }
    func SET_FACIL_CODE(FACIL_CODE: Any) { self.FACIL_CODE = FACIL_CODE as? String ?? "" }
    func SET_FACIL_DAY(FACIL_DAY: Any) { self.FACIL_DAY = FACIL_DAY as? String ?? "" }
    func SET_FACIL_TIME_NAME(FACIL_TIME_NAME: Any) { self.FACIL_TIME_NAME = FACIL_TIME_NAME as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
}

// 방문주차(목록)
class PARKING_L {
    
    var AP_CODE: String = ""
    var APPROVE_END: String = ""
    var APPROVE_START: String = ""
    var BK_NAME: String = ""
    var BUILDING_ID: String = ""
    var HOME_CODE: String = ""
    var HOUSE_NUMBER: String = ""
    var IDX: String = ""
    var INPUT_DATETIME: String = ""
    var IN_DATE: String = ""
    var IN_TIME: String = ""
    var MB_ID: String = ""
    var QUE_STATUS: String = ""
    var CAR_CHAR: String = ""
    var CAR_END: String = ""
    var CAR_INIT: String = ""
    var CAR_MEMO: String = ""
    var CAR_PHONE: String = ""
    var CAR_STATUS: String = ""
    var DISABLED_CAR: String = ""
    var DATE: String = ""
    var END: String = ""
    var MEMO: String = ""
    var MODIFY: String = ""
    var NAME: String = ""
    var ORG_NUMBER: String = ""
    var OUT_DATE: String = ""
    var OUT_TIME: String = ""
    var PHONE: String = ""
    var PLATE_INFO: String = ""
    var PREG_CAR: String = ""
    var PUSH: String = ""
    var REG_DATE: String = ""
    var REG_TYPE: String = ""
    var RESON: String = ""
    var SAFE_NUMBER: String = ""
    var START: String = ""
    var STATUS: String = ""
    var VISIT_IDX: String = ""
    
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_APPROVE_END(APPROVE_END: Any) { self.APPROVE_END = APPROVE_END as? String ?? "" }
    func SET_APPROVE_START(APPROVE_START: Any) { self.APPROVE_START = APPROVE_START as? String ?? "" }
    func SET_BK_NAME(BK_NAME: Any) { self.BK_NAME = BK_NAME as? String ?? "" }
    func SET_BUILDING_ID(BUILDING_ID: Any) { self.BUILDING_ID = BUILDING_ID as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_HOUSE_NUMBER(HOUSE_NUMBER: Any) { self.HOUSE_NUMBER = HOUSE_NUMBER as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_INPUT_DATETIME(INPUT_DATETIME: Any) { self.INPUT_DATETIME = INPUT_DATETIME as? String ?? "" }
    func SET_IN_DATE(IN_DATE: Any) { self.IN_DATE = IN_DATE as? String ?? "" }
    func SET_IN_TIME(IN_TIME: Any) { self.IN_TIME = IN_TIME as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_QUE_STATUS(QUE_STATUS: Any) { self.QUE_STATUS = QUE_STATUS as? String ?? "" }
    func SET_CAR_CHAR(CAR_CHAR: Any) { self.CAR_CHAR = CAR_CHAR as? String ?? "" }
    func SET_CAR_END(CAR_END: Any) { self.CAR_END = CAR_END as? String ?? "" }
    func SET_CAR_INIT(CAR_INIT: Any) { self.CAR_INIT = CAR_INIT as? String ?? "" }
    func SET_CAR_MEMO(CAR_MEMO: Any) { self.CAR_MEMO = CAR_MEMO as? String ?? "" }
    func SET_CAR_PHONE(CAR_PHONE: Any) { self.CAR_PHONE = CAR_PHONE as? String ?? "" }
    func SET_CAR_STATUS(CAR_STATUS: Any) { self.CAR_STATUS = CAR_STATUS as? String ?? "" }
    func SET_DISABLED_CAR(DISABLED_CAR: Any) { self.DISABLED_CAR = DISABLED_CAR as? String ?? "" }
    func SET_DATE(DATE: Any) { self.DATE = DATE as? String ?? "" }
    func SET_END(END: Any) { self.END = END as? String ?? "" }
    func SET_MEMO(MEMO: Any) { self.MEMO = MEMO as? String ?? "" }
    func SET_MODIFY(MODIFY: Any) { self.MODIFY = MODIFY as? String ?? "" }
    func SET_NAME(NAME: Any) { self.NAME = NAME as? String ?? "" }
    func SET_ORG_NUMBER(ORG_NUMBER: Any) { self.ORG_NUMBER = ORG_NUMBER as? String ?? "" }
    func SET_OUT_DATE(OUT_DATE: Any) { self.OUT_DATE = OUT_DATE as? String ?? "" }
    func SET_OUT_TIME(OUT_TIME: Any) { self.OUT_TIME = OUT_TIME as? String ?? "" }
    func SET_PHONE(PHONE: Any) { self.PHONE = PHONE as? String ?? "" }
    func SET_PLATE_INFO(PLATE_INFO: Any) { self.PLATE_INFO = PLATE_INFO as? String ?? "" }
    func SET_PREG_CAR(PREG_CAR: Any) { self.PREG_CAR = PREG_CAR as? String ?? "" }
    func SET_PUSH(PUSH: Any) { self.PUSH = PUSH as? String ?? "" }
    func SET_REG_DATE(REG_DATE: Any) { self.REG_DATE = REG_DATE as? String ?? "" }
    func SET_REG_TYPE(REG_TYPE: Any) { self.REG_TYPE = REG_TYPE as? String ?? "" }
    func SET_RESON(RESON: Any) { self.RESON = RESON as? String ?? "" }
    func SET_SAFE_NUMBER(SAFE_NUMBER: Any) { self.SAFE_NUMBER = SAFE_NUMBER as? String ?? "" }
    func SET_START(START: Any) { self.START = START as? String ?? "" }
    func SET_STATUS(STATUS: Any) { self.STATUS = STATUS as? String ?? "" }
    func SET_VISIT_IDX(VISIT_IDX: Any) { self.VISIT_IDX = VISIT_IDX as? String ?? "" }
}

// EV자동차(목록)
class EVCAR_L {
    
    var AP_CODE: String = ""
    var CHARGER_END: String = ""
    var CHARGER_ID: String = ""
    var CHARGER_NAME: String = ""
    var CHARGER_START: String = ""
    var CHARGER_STATUS: String = ""
    var CHARGER_TYPE: String = ""
    var HOME_CODE: String = ""
    var IDX: String = ""
    var PLATE_INFO: String = ""
    
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_CHARGER_END(CHARGER_END: Any) { self.CHARGER_END = CHARGER_END as? String ?? "" }
    func SET_CHARGER_ID(CHARGER_ID: Any) { self.CHARGER_ID = CHARGER_ID as? String ?? "" }
    func SET_CHARGER_NAME(CHARGER_NAME: Any) { self.CHARGER_NAME = CHARGER_NAME as? String ?? "" }
    func SET_CHARGER_START(CHARGER_START: Any) { self.CHARGER_START = CHARGER_START as? String ?? "" }
    func SET_CHARGER_STATUS(CHARGER_STATUS: Any) { self.CHARGER_STATUS = CHARGER_STATUS as? String ?? "" }
    func SET_CHARGER_TYPE(CHARGER_TYPE: Any) { self.CHARGER_TYPE = CHARGER_TYPE as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_PLATE_INFO(PLATE_INFO: Any) { self.PLATE_INFO = PLATE_INFO as? String ?? "" }
}

// 배송조회(목록/디테일)
class DELIVERY_L1 {
    
    var AUTO_DATETIME: String = ""
    var COMPANY_CODE: String = ""
    var COMPANY_NAME: String = ""
    var COMPANY_PHONE: String = ""
    var COMPLETE_YN: String = ""
    var DETAIL: String = ""
    var HOME_CODE: String = ""
    var IDX: String = ""
    var IN_VOICE_NO: String = ""
    var ITEM_IMAGE: String = ""
    var ITEM_NAME: String = ""
    var MB_ID: String = ""
    var PAR_DETAIL: [DELIVERY_D1] = []
    var RECEIVER_ADDR: String = ""
    var RECEIVER_NAME: String = ""
    var RECIPIENT: String = ""
    var REG_DATE: String = ""
    var RELOAD: String = ""
    var SENDER_NAME: String = ""
    var TOTAL_LEVEL: String = ""
    
    func SET_AUTO_DATETIME(AUTO_DATETIME: Any) { self.AUTO_DATETIME = AUTO_DATETIME as? String ?? "" }
    func SET_COMPANY_CODE(COMPANY_CODE: Any) { self.COMPANY_CODE = COMPANY_CODE as? String ?? "" }
    func SET_COMPANY_NAME(COMPANY_NAME: Any) { self.COMPANY_NAME = COMPANY_NAME as? String ?? "" }
    func SET_COMPANY_PHONE(COMPANY_PHONE: Any) { self.COMPANY_PHONE = COMPANY_PHONE as? String ?? "" }
    func SET_COMPLETE_YN(COMPLETE_YN: Any) { self.COMPLETE_YN = COMPLETE_YN as? String ?? "" }
    func SET_DETAIL(DETAIL: Any) { self.DETAIL = DETAIL as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_IN_VOICE_NO(IN_VOICE_NO: Any) { self.IN_VOICE_NO = IN_VOICE_NO as? String ?? "" }
    func SET_ITEM_IMAGE(ITEM_IMAGE: Any) { self.ITEM_IMAGE = ITEM_IMAGE as? String ?? "" }
    func SET_ITEM_NAME(ITEM_NAME: Any) { self.ITEM_NAME = ITEM_NAME as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_PAR_DETAIL(PAR_DETAIL: [DELIVERY_D1]) { self.PAR_DETAIL = PAR_DETAIL }
    func SET_RECEIVER_ADDR(RECEIVER_ADDR: Any) { self.RECEIVER_ADDR = RECEIVER_ADDR as? String ?? "" }
    func SET_RECEIVER_NAME(RECEIVER_NAME: Any) { self.RECEIVER_NAME = RECEIVER_NAME as? String ?? "" }
    func SET_RECIPIENT(RECIPIENT: Any) { self.RECIPIENT = RECIPIENT as? String ?? "" }
    func SET_REG_DATE(REG_DATE: Any) { self.REG_DATE = REG_DATE as? String ?? "" }
    func SET_RELOAD(RELOAD: Any) { self.RELOAD = RELOAD as? String ?? "" }
    func SET_SENDER_NAME(SENDER_NAME: Any) { self.SENDER_NAME = SENDER_NAME as? String ?? "" }
    func SET_TOTAL_LEVEL(TOTAL_LEVEL: Any) { self.TOTAL_LEVEL = TOTAL_LEVEL as? String ?? "" }
}
class DELIVERY_D1 {
    
    var COMPLETE_YN: String = ""
    var IDX: String = ""
    var IN_VOICE_NO: String = ""
    var KIND: String = ""
    var LEVEL: String = ""
    var MAN_NAME: String = ""
    var MAN_PIC: String = ""
    var TEL_NO1: String = ""
    var TEL_NO2: String = ""
    var TIME_STRING: String = ""
    var WHERE_NOW: String = ""
    
    func SET_COMPLETE_YN(COMPLETE_YN: Any) { self.COMPLETE_YN = COMPLETE_YN as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_IN_VOICE_NO(IN_VOICE_NO: Any) { self.IN_VOICE_NO = IN_VOICE_NO as? String ?? "" }
    func SET_KIND(KIND: Any) { self.KIND = KIND as? String ?? "" }
    func SET_LEVEL(LEVEL: Any) { self.LEVEL = LEVEL as? String ?? "" }
    func SET_MAN_NAME(MAN_NAME: Any) { self.MAN_NAME = MAN_NAME as? String ?? "" }
    func SET_MAN_PIC(MAN_PIC: Any) { self.MAN_PIC = MAN_PIC as? String ?? "" }
    func SET_TEL_NO1(TEL_NO1: Any) { self.TEL_NO1 = TEL_NO1 as? String ?? "" }
    func SET_TEL_NO2(TEL_NO2: Any) { self.TEL_NO2 = TEL_NO2 as? String ?? "" }
    func SET_TIME_STRING(TIME_STRING: Any) { self.TIME_STRING = TIME_STRING as? String ?? "" }
    func SET_WHERE_NOW(WHERE_NOW: Any) { self.WHERE_NOW = WHERE_NOW as? String ?? "" }
}
// 택배회사(목록)
class DELIVERY_L2 {
    
    var IDX: String = ""
    var POST_COMPANY: String = ""
    var COMPANY_CODE: String = ""
    var COMPANY_PHONE: String = ""
    var PARSING_URL: String = ""
    var PARSING_NAME: String = ""
    
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_POST_COMPANY(POST_COMPANY: Any) { self.POST_COMPANY = POST_COMPANY as? String ?? "" }
    func SET_COMPANY_CODE(COMPANY_CODE: Any) { self.COMPANY_CODE = COMPANY_CODE as? String ?? "" }
    func SET_COMPANY_PHONE(COMPANY_PHONE: Any) { self.COMPANY_PHONE = COMPANY_PHONE as? String ?? "" }
    func SET_PARSING_URL(PARSING_URL: Any) { self.PARSING_URL = PARSING_URL as? String ?? "" }
    func SET_PARSING_NAME(PARSING_NAME: Any) { self.PARSING_NAME = PARSING_NAME as? String ?? "" }
}

// 관리비 내역(목록)
class EXPENESE_L1 {
    
    var AMOUNT: String = ""
    var AP_CODE: String = ""
    var AP_NAME: String = ""
    var BILL_COMPARE: [EXPENESE_D1] = []
    var BILL_DETAIL: [EXPENESE_D2] = []
    var BILL_PAID: String = ""
    var BUILDING_ID: String = ""
    var HOME_CODE: String = ""
    var HOUSE_NUMBER: String = ""
    var IDX: String = ""
    var IN_OUT: String = ""
    var LAST_AMOUNT: String = ""
    var LAST_IN_OUT: String = ""
    var LAST_UPDATE: String = ""
    var TARGET_MONTH: String = ""
    
    func SET_AMOUNT(AMOUNT: Any) { self.AMOUNT = AMOUNT as? String ?? "" }
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_AP_NAME(AP_NAME: Any) { self.AP_NAME = AP_NAME as? String ?? "" }
    func SET_BILL_COMPARE(BILL_COMPARE: [EXPENESE_D1]) { self.BILL_COMPARE = BILL_COMPARE }
    func SET_BILL_DETAIL(BILL_DETAIL: [EXPENESE_D2]) { self.BILL_DETAIL = BILL_DETAIL }
    func SET_BILL_PAID(BILL_PAID: Any) { self.BILL_PAID = BILL_PAID as? String ?? "" }
    func SET_BUILDING_ID(BUILDING_ID: Any) { self.BUILDING_ID = BUILDING_ID as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_HOUSE_NUMBER(HOUSE_NUMBER: Any) { self.HOUSE_NUMBER = HOUSE_NUMBER as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_IN_OUT(IN_OUT: Any) { self.IN_OUT = IN_OUT as? String ?? "" }
    func SET_LAST_AMOUNT(LAST_AMOUNT: Any) { self.LAST_AMOUNT = LAST_AMOUNT as? String ?? "" }
    func SET_LAST_IN_OUT(LAST_IN_OUT: Any) { self.LAST_IN_OUT = LAST_IN_OUT as? String ?? "" }
    func SET_LAST_UPDATE(LAST_UPDATE: Any) { self.LAST_UPDATE = LAST_UPDATE as? String ?? "" }
    func SET_TARGET_MONTH(TARGET_MONTH: Any) { self.TARGET_MONTH = TARGET_MONTH as? String ?? "" }
    
//        "idx": "1",
//        "target_month": "202203",
//        "building_id": "1",
//        "house_number": "408",
//        "ap_code": "K00000001",
//        "home_code": "K000000011408",
//        "house_area": "206.6891",
//        "wa_remain_cost": "0",
//        "vote_fee": "112",
//        "chair_fee": "883",
//        "ele_garo": "492",
//        "ele_sanup": "1527",
//        "ele_pub": "4841",
//        "wa_pub": "-1085",
//        "trash_living": "830",
//        "ele_ev": "1226",
//        "office_manage": "1137",
//        "office_ins": "4194",
//        "office_fix": "2408",
//        "ev_fix": "0",
//        "sodoc": "0",
//        "office_secu": "34410",
//        "office_clean": "47292",
//        "general_fee": "49246",
//        "home_net": "0",
//        "job_support": "-550",
//        "longterm_fix": "20462",
//        "wa_out_cost": "10920",
//        "ele_house_cost": "79230",
//        "ele_house_mount": "424",
//        "ele_charge_mount": "0",
//        "ele_charge_cost": "0",
//        "remain_balance": "0",
//        "parking_fee": "5000",
//        "tv_fee": "2500",
//        "wa_in_cost": "19160",
//        "wa_in_amount": "21",
//        "totall_bill": "284240",
//        "late_bill": "0",
//        "late_fee": "0",
//        "in_total_amount": "284240",
//        "late_totall_bill_fee": "0",
//        "late_total_bill": "284240",
//        "ele_this": "5901",
//        "ele_last": "5477",
//        "wa_this": "241",
//        "wa_last": "220",
//        "heat_this": "0",
//        "heat_last": "0"
    
//    var IDX: String = ""
//    var TARGET_MONTH: String = ""
//    var BUILDING_ID: String = ""
//    var HOUSE_NUMBER: String = ""
//    var AP_CODE: String = ""
//    var HOME_CODE: String = ""
//    var HOUSE_AREA: String = ""
//    var WA_REMAIN_COST: String = ""
//    var VOTE_FEE: String = ""
//    var CHAIR_FEE: String = ""
//    var ELE_GARO: String = ""
//    var ELE_SANUP: String = ""
//    var ELE_PUB: String = ""
//    var WA_PUB: String = ""
//    var TRASH_LIVING: String = ""
//    var ELE_EV: String = ""
//    var OFF: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
//    var <#name#>: String = ""
}
class EXPENESE_D1 {
    
    var APT_AMOUNT_COST: String = ""
    var APT_HOUSE_CNT: String = ""
    var DONG_AMOUNT_COST: String = ""
    var DONG_HOUSE_CNT: String = ""
    
    func SET_APT_AMOUNT_COST(APT_AMOUNT_COST: Any) { self.APT_AMOUNT_COST = APT_AMOUNT_COST as? String ?? "" }
    func SET_APT_HOUSE_CNT(APT_HOUSE_CNT: Any) { self.APT_HOUSE_CNT = APT_HOUSE_CNT as? String ?? "" }
    func SET_DONG_AMOUNT_COST(DONG_AMOUNT_COST: Any) { self.DONG_AMOUNT_COST = DONG_AMOUNT_COST as? String ?? "" }
    func SET_DONG_HOUSE_CNT(DONG_HOUSE_CNT: Any) { self.DONG_HOUSE_CNT = DONG_HOUSE_CNT as? String ?? "" }
}
class EXPENESE_D2 {
    
    var BILL_COST: String = ""
    var BILL_NAME: String = ""
    var TARGET_MONTH: String = ""
    
    func SET_BILL_COST(BILL_COST: Any) { self.BILL_COST = BILL_COST as? String ?? "" }
    func SET_BILL_NAME(BILL_NAME: Any) { self.BILL_NAME = BILL_NAME as? String ?? "" }
    func SET_TARGET_MONTH(TARGET_MONTH: Any) { self.TARGET_MONTH = TARGET_MONTH as? String ?? "" }
}
// 관리비 은행(목록)
class EXPENESE_L2 {
    
    
}

// 동네연락처(목록)
class CONTACT_L {
    
    var AP_CODE: String = ""
    var IDX: String = ""
    var PH_ADDR: String = ""
    var PH_EMAIL: String = ""
    var PH_FAX: String = ""
    var PH_NAME: String = ""
    var PH_PHONE1: String = ""
    var PH_PHONE2: String = ""
    
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_PH_ADDR(PH_ADDR: Any) { self.PH_ADDR = PH_ADDR as? String ?? "" }
    func SET_PH_EMAIL(PH_EMAIL: Any) { self.PH_EMAIL = PH_EMAIL as? String ?? "" }
    func SET_PH_FAX(PH_FAX: Any) { self.PH_FAX = PH_FAX as? String ?? "" }
    func SET_PH_NAME(PH_NAME: Any) { self.PH_NAME = PH_NAME as? String ?? "" }
    func SET_PH_PHONE1(PH_PHONE1: Any) { self.PH_PHONE1 = PH_PHONE1 as? String ?? "" }
    func SET_PH_PHONE2(PH_PHONE2: Any) { self.PH_PHONE2 = PH_PHONE2 as? String ?? "" }
}

// 병원/약국(목록)
class MEDICAL_L {
    
    var TIME_1C: String = ""
    var TIME_1S: String = ""
    var TIME_2C: String = ""
    var TIME_2S: String = ""
    var TIME_3C: String = ""
    var TIME_3S: String = ""
    var TIME_4C: String = ""
    var TIME_4S: String = ""
    var TIME_5C: String = ""
    var TIME_5S: String = ""
    var TIME_6C: String = ""
    var TIME_6S: String = ""
    var TIME_7C: String = ""
    var TIME_7S: String = ""
    var TIME_8C: String = ""
    var TIME_8S: String = ""
    var ADDR: String = ""
    var BREAK_DAY: String = ""
    var CLCD: String = ""
    var CLCD_NAME: String = ""
    var DGSBJTCD: String = ""
    var DGSBJTCD_NAME: String = ""
    var DISTANCE: String = ""
    var HOS_ID: String = ""
    var HOS_NAME: String = ""
    var HOS_TYPE: String = ""
    var IDX: String = ""
    var LAT: String = ""
    var LNG: String = ""
    var TEL_NO: String = ""
    var ZIPCD: String = ""
    var ZIPCD_NAME: String = ""
    
    func SET_TIME_1C(TIME_1C: Any) { self.TIME_1C = TIME_1C as? String ?? "" }
    func SET_TIME_1S(TIME_1S: Any) { self.TIME_1S = TIME_1S as? String ?? "" }
    func SET_TIME_2C(TIME_2C: Any) { self.TIME_2C = TIME_2C as? String ?? "" }
    func SET_TIME_2S(TIME_2S: Any) { self.TIME_2S = TIME_2S as? String ?? "" }
    func SET_TIME_3C(TIME_3C: Any) { self.TIME_3C = TIME_3C as? String ?? "" }
    func SET_TIME_3S(TIME_3S: Any) { self.TIME_3S = TIME_3S as? String ?? "" }
    func SET_TIME_4C(TIME_4C: Any) { self.TIME_4C = TIME_4C as? String ?? "" }
    func SET_TIME_4S(TIME_4S: Any) { self.TIME_4S = TIME_4S as? String ?? "" }
    func SET_TIME_5C(TIME_5C: Any) { self.TIME_5C = TIME_5C as? String ?? "" }
    func SET_TIME_5S(TIME_5S: Any) { self.TIME_5S = TIME_5S as? String ?? "" }
    func SET_TIME_6C(TIME_6C: Any) { self.TIME_6C = TIME_6C as? String ?? "" }
    func SET_TIME_6S(TIME_6S: Any) { self.TIME_6S = TIME_6S as? String ?? "" }
    func SET_TIME_7C(TIME_7C: Any) { self.TIME_7C = TIME_7C as? String ?? "" }
    func SET_TIME_7S(TIME_7S: Any) { self.TIME_7S = TIME_7S as? String ?? "" }
    func SET_TIME_8C(TIME_8C: Any) { self.TIME_8C = TIME_8C as? String ?? "" }
    func SET_TIME_8S(TIME_8S: Any) { self.TIME_8S = TIME_8S as? String ?? "" }
    func SET_ADDR(ADDR: Any) { self.ADDR = ADDR as? String ?? "" }
    func SET_BREAK_DAY(BREAK_DAY: Any) { self.BREAK_DAY = BREAK_DAY as? String ?? "" }
    func SET_CLCD(CLCD: Any) { self.CLCD = CLCD as? String ?? "" }
    func SET_CLCD_NAME(CLCD_NAME: Any) { self.CLCD_NAME = CLCD_NAME as? String ?? "" }
    func SET_DGSBJTCD(DGSBJTCD: Any) { self.DGSBJTCD = DGSBJTCD as? String ?? "" }
    func SET_DGSBJTCD_NAME(DGSBJTCD_NAME: Any) { self.DGSBJTCD_NAME = DGSBJTCD_NAME as? String ?? "" }
    func SET_DISTANCE(DISTANCE: Any) { self.DISTANCE = DISTANCE as? String ?? "" }
    func SET_HOS_ID(HOS_ID: Any) { self.HOS_ID = HOS_ID as? String ?? "" }
    func SET_HOS_NAME(HOS_NAME: Any) { self.HOS_NAME = HOS_NAME as? String ?? "" }
    func SET_HOS_TYPE(HOS_TYPE: Any) { self.HOS_TYPE = HOS_TYPE as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_LAT(LAT: Any) { self.LAT = LAT as? String ?? "" }
    func SET_LNG(LNG: Any) { self.LNG = LNG as? String ?? "" }
    func SET_TEL_NO(TEL_NO: Any) { self.TEL_NO = TEL_NO as? String ?? "" }
    func SET_ZIPCD(ZIPCD: Any) { self.ZIPCD = ZIPCD as? String ?? "" }
    func SET_ZIPCD_NAME(ZIPCD_NAME: Any) { self.ZIPCD_NAME = ZIPCD_NAME as? String ?? "" }
}

// EV호출(목록)
class EV_L {
    
    var IDX: String = ""
    var MB_ID: String = ""
    var HOME_CODE: String = ""
    var CALL_TO: String = ""
    var CALL_TIME: String = ""
    var REACH_TIME: String = ""
    
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_CALL_TO(CALL_TO: Any) { self.CALL_TO = CALL_TO as? String ?? "" }
    func SET_CALL_TIME(CALL_TIME: Any) { self.CALL_TIME = CALL_TIME as? String ?? "" }
    func SET_REACH_TIME(REACH_TIME: Any) { self.REACH_TIME = REACH_TIME as? String ?? "" }
}

// 소식(전체)
class SOSIK_L2 {
    
    var MEDIA_CONTENT: [SOSIK_D] = []
    var AP_COMMENT: String = ""
    var AP_CONTENT_TEXT: String = ""
    var AP_LIKE: String = ""
    var AP_MSG_GROUP: String = ""
    var AP_REQUEST_TIME: String = ""
    var AP_SEQ: String = ""
    var AP_SUBJECT: String = ""
    var AP_SUBJECT_TEXT: String = ""
    var BADGE_COLOR: String = ""
    var BOARD_NAME: String = ""
    var BOARD_TYPE: String = ""
    var CC_CODE: String = ""
    var CC_NAME: String = ""
    var COMMENT_CNT: Int = 0
    var LOGO_URL: String = ""
    var READ_CNT: Int = 0
    var SENDER_NICK: String = ""
    
    func SET_MEDIA_CONTENT(MEDIA_CONTENT: [SOSIK_D]) { self.MEDIA_CONTENT = MEDIA_CONTENT}
    func SET_AP_COMMENT(AP_COMMENT: Any) { self.AP_COMMENT = AP_COMMENT as? String ?? ""}
    func SET_AP_CONTENT_TEXT(AP_CONTENT_TEXT: Any) { self.AP_CONTENT_TEXT = AP_CONTENT_TEXT as? String ?? ""}
    func SET_AP_LIKE(AP_LIKE: Any) { self.AP_LIKE = AP_LIKE as? String ?? ""}
    func SET_AP_MSG_GROUP(AP_MSG_GROUP: Any) { self.AP_MSG_GROUP = AP_MSG_GROUP as? String ?? ""}
    func SET_AP_REQUEST_TIME(AP_REQUEST_TIME: Any) { self.AP_REQUEST_TIME = AP_REQUEST_TIME as? String ?? ""}
    func SET_AP_SEQ(AP_SEQ: Any) { self.AP_SEQ = AP_SEQ as? String ?? ""}
    func SET_AP_SUBJECT(AP_SUBJECT: Any) { self.AP_SUBJECT = AP_SUBJECT as? String ?? "" }
    func SET_AP_SUBJECT_TEXT(AP_SUBJECT_TEXT: Any) { self.AP_SUBJECT_TEXT = AP_SUBJECT_TEXT as? String ?? ""}
    func SET_BADGE_COLOR(BADGE_COLOR: Any) { self.BADGE_COLOR = BADGE_COLOR as? String ?? ""}
    func SET_BOARD_NAME(BOARD_NAME: Any) { self.BOARD_NAME = BOARD_NAME as? String ?? ""}
    func SET_BOARD_TYPE(BOARD_TYPE: Any) { self.BOARD_TYPE = BOARD_TYPE as? String ?? ""}
    func SET_CC_CODE(CC_CODE: Any) { self.CC_CODE = CC_CODE as? String ?? ""}
    func SET_CC_NAME(CC_NAME: Any) { self.CC_NAME = CC_NAME as? String ?? ""}
    func SET_COMMENT_CNT(COMMENT_CNT: Any) { self.COMMENT_CNT = Int(COMMENT_CNT as? String ?? "") ?? 0 }
    func SET_LOGO_URL(LOGO_URL: Any) { self.LOGO_URL = LOGO_URL as? String ?? ""}
    func SET_READ_CNT(READ_CNT: Any) { self.READ_CNT = Int(READ_CNT as? String ?? "") ?? 0 }
    func SET_SENDER_NICK(SENDER_NICK: Any) { self.SENDER_NICK = SENDER_NICK as? String ?? ""}
    
    var AP_CODE: String = ""
    var BK_NAME: String = ""
    var BK_NICK: String = ""
    var BUILDING_ID: String = ""
    var CONTENT: String = ""
    var HOME_CODE: String = ""
    var HOUSE_NUMBER: String = ""
    var IDX: String = ""
    var MB_ID: String = ""
    var ON_QUE: String = ""
    var ORG_IDX: String = ""
    var REQUEST_TIME: String = ""
    var REQUEST_TYPE: String = ""
    var RESULT_BG_NAME: String = ""
    var RESULT_BG_NO: String = ""
    var RESULT_CONTENT: String = ""
    var RESULT_MB_ID: String = ""
    var RESULT_SUBJECT: String = ""
    var SUBJECT: String = ""
    
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_BK_NAME(BK_NAME: Any) { self.BK_NAME = BK_NAME as? String ?? "" }
    func SET_BK_NICK(BK_NICK: Any) { self.BK_NICK = BK_NICK as? String ?? "" }
    func SET_BUILDING_ID(BUILDING_ID: Any) { self.BUILDING_ID = BUILDING_ID as? String ?? "" }
    func SET_CONTENT(CONTENT: Any) { self.CONTENT = CONTENT as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_HOUSE_NUMBER(HOUSE_NUMBER: Any) { self.HOUSE_NUMBER = HOUSE_NUMBER as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_ON_QUE(ON_QUE: Any) { self.ON_QUE = ON_QUE as? String ?? "" }
    func SET_ORG_IDX(ORG_IDX: Any) { self.ORG_IDX = ORG_IDX as? String ?? "" }
    func SET_REQUEST_TIME(REQUEST_TIME: Any) { self.REQUEST_TIME = REQUEST_TIME as? String ?? "" }
    func SET_REQUEST_TYPE(REQUEST_TYPE: Any) { self.REQUEST_TYPE = REQUEST_TYPE as? String ?? "" }
    func SET_RESULT_BG_NAME(RESULT_BG_NAME: Any) { self.RESULT_BG_NAME = RESULT_BG_NAME as? String ?? "" }
    func SET_RESULT_BG_NO(RESULT_BG_NO: Any) { self.RESULT_BG_NO = RESULT_BG_NO as? String ?? "" }
    func SET_RESULT_CONTENT(RESULT_CONTENT: Any) { self.RESULT_CONTENT = RESULT_CONTENT as? String ?? "" }
    func SET_RESULT_MB_ID(RESULT_MB_ID: Any) { self.RESULT_MB_ID = RESULT_MB_ID as? String ?? "" }
    func SET_RESULT_SUBJECT(RESULT_SUBJECT: Any) { self.RESULT_SUBJECT = RESULT_SUBJECT as? String ?? "" }
    func SET_SUBJECT(SUBJECT: Any) { self.SUBJECT = SUBJECT as? String ?? "" }
}
// 소식(디테일)
class SOSIK_DL {
    
    var AP_COMMENT: String = ""
    var AP_CONTENT: String = ""
    var AP_CONTENT_TEXT: String = ""
    var AP_CONTENT_TEXT_2: String = ""
    var ARTICLE_TYPE: String = ""
    var AP_LIKE: String = ""
    var AP_MSG_GROUP: String = ""
    var AP_REQUEST_TIME: String = ""
    var AP_SEQ: String = ""
    var AP_SUBJECT: String = ""
    var AP_SUBJECT_TEXT: String = ""
    var BADGE_COLOR: String = ""
    var BOARD_NAME: String = ""
    var BOARD_TYPE: String = ""
    var CC_NAME: String = ""
    var LOGO_URL: String = ""
    var SENDER_NICK: String = ""
    
    func SET_AP_COMMENT(AP_COMMENT: Any) { self.AP_COMMENT = AP_COMMENT as? String ?? "" }
    func SET_AP_CONTENT(AP_CONTENT: Any) { self.AP_CONTENT = AP_CONTENT as? String ?? "" }
    func SET_AP_CONTENT_TEXT(AP_CONTENT_TEXT: Any) { self.AP_CONTENT_TEXT = AP_CONTENT_TEXT as? String ?? "" }
    func SET_AP_CONTENT_TEXT_2(AP_CONTENT_TEXT_2: Any) { self.AP_CONTENT_TEXT_2 = AP_CONTENT_TEXT_2 as? String ?? "" }
    func SET_ARTICLE_TYPE(ARTICLE_TYPE: Any) { self.ARTICLE_TYPE = ARTICLE_TYPE as? String ?? "" }
    func SET_AP_LIKE(AP_LIKE: Any) { self.AP_LIKE = AP_LIKE as? String ?? "" }
    func SET_AP_MSG_GROUP(AP_MSG_GROUP: Any) { self.AP_MSG_GROUP = AP_MSG_GROUP as? String ?? "" }
    func SET_AP_REQUEST_TIME(AP_REQUEST_TIME: Any) { self.AP_REQUEST_TIME = AP_REQUEST_TIME as? String ?? "" }
    func SET_AP_SEQ(AP_SEQ: Any) { self.AP_SEQ = AP_SEQ as? String ?? "" }
    func SET_AP_SUBJECT(AP_SUBJECT: Any) { self.AP_SUBJECT = AP_SUBJECT as? String ?? "" }
    func SET_AP_SUBJECT_TEXT(AP_SUBJECT_TEXT: Any) { self.AP_SUBJECT_TEXT = AP_SUBJECT_TEXT as? String ?? ""}
    func SET_BADGE_COLOR(BADGE_COLOR: Any) { self.BADGE_COLOR = BADGE_COLOR as? String ?? "" }
    func SET_BOARD_NAME(BOARD_NAME: Any) { self.BOARD_NAME = BOARD_NAME as? String ?? "" }
    func SET_BOARD_TYPE(BOARD_TYPE: Any) { self.BOARD_TYPE = BOARD_TYPE as? String ?? "" }
    func SET_CC_NAME(CC_NAME: Any) { self.CC_NAME = CC_NAME as? String ?? "" }
    func SET_LOGO_URL(LOGO_URL: Any) { self.LOGO_URL = LOGO_URL as? String ?? "" }
    func SET_SENDER_NICK(SENDER_NICK: Any) { self.SENDER_NICK = SENDER_NICK as? String ?? "" }
}
// 소식(미디어)
class SOSIK_D {
    
    var AP_MSG_GROUP: String = ""
    var MEDIA_NAME: String = ""
    var MEDIA_THUMBS: String = ""
    var MEDIA_TYPE: String = ""
    var MEDIA_URL: String = ""
    
    func SET_AP_MSG_GROUP(AP_MSG_GROUP: Any) { self.AP_MSG_GROUP = AP_MSG_GROUP as? String ?? "" }
    func SET_MEDIA_NAME(MEDIA_NAME: Any) { self.MEDIA_NAME = MEDIA_NAME as? String ?? ""}
    func SET_MEDIA_THUMBS(MEDIA_THUMBS: Any) { self.MEDIA_THUMBS = MEDIA_THUMBS as? String ?? ""}
    func SET_MEDIA_TYPE(MEDIA_TYPE: Any) { self.MEDIA_TYPE = MEDIA_TYPE as? String ?? ""}
    func SET_MEDIA_URL(MEDIA_URL: Any) { self.MEDIA_URL = MEDIA_URL as? String ?? ""}
}
// 소식(코멘트)
class COMMENT_L {
    
    var CO_DEPTH: String = ""
    var COMMENT: String = ""
    var IDX: String = ""
    var BK_NICK: String = ""
    var REG_DATE: String = ""
    var UPPER_IDX: String = ""
    
    func SET_CO_DEPTH(CO_DEPTH: Any) { self.CO_DEPTH = CO_DEPTH as? String ?? "" }
    func SET_COMMENT(COMMENT: Any) { self.COMMENT = COMMENT as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_BK_NICK(BK_NICK: Any) { self.BK_NICK = BK_NICK as? String ?? "" }
    func SET_REG_DATE(REG_DATE: Any) { self.REG_DATE = REG_DATE as? String ?? "" }
    func SET_UPPER_IDX(UPPER_IDX: Any) { self.UPPER_IDX = UPPER_IDX as? String ?? "" }
}

// CCTV(목록)
class CCTV {
    
    var AP_CODE: String = ""
    var AP_NAME: String = ""
    var COM_TYPE: String = ""
    var ETC_PARAM: String = ""
    var ETC_VALUE: String = ""
    var ID_PARAM: String = ""
    var ID_VALUE: String = ""
    var IDX: String = ""
    var PW_PARAM: String = ""
    var PW_VALUE: String = ""
    var REG_DATE: String = ""
    var URL: String = ""
    var VIDEO_NAME: String = ""
    var VIEW_TYPE: String = ""
    
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_AP_NAME(AP_NAME: Any) { self.AP_NAME = AP_NAME as? String ?? "" }
    func SET_COM_TYPE(COM_TYPE: Any) { self.COM_TYPE = COM_TYPE as? String ?? "" }
    func SET_ETC_PARAM(ETC_PARAM: Any) { self.ETC_PARAM = ETC_PARAM as? String ?? "" }
    func SET_ETC_VALUE(ETC_VALUE: Any) { self.ETC_VALUE = ETC_VALUE as? String ?? "" }
    func SET_ID_PARAM(ID_PARAM: Any) { self.ID_PARAM = ID_PARAM as? String ?? "" }
    func SET_ID_VALUE(ID_VALUE: Any) { self.ID_VALUE = ID_VALUE as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_PW_PARAM(PW_PARAM: Any) { self.PW_PARAM = PW_PARAM as? String ?? "" }
    func SET_PW_VALUE(PW_VALUE: Any) { self.PW_VALUE = PW_VALUE as? String ?? "" }
    func SET_REG_DATE(REG_DATE: Any) { self.REG_DATE = REG_DATE as? String ?? "" }
    func SET_URL(URL: Any) { self.URL = URL as? String ?? "" }
    func SET_VIDEO_NAME(VIDEO_NAME: Any) { self.VIDEO_NAME = VIDEO_NAME as? String ?? "" }
    func SET_VIEW_TYPE(VIEW_TYPE: Any) { self.VIEW_TYPE = VIEW_TYPE as? String ?? "" }
}

// 커뮤니티
class COMMUNITY {
    
    var JOIN: Bool = false
    var AP_CODE: String = ""
    var BK_NAME: String = ""
    var BK_NICK: String = ""
    var BUILDING_ID: String = ""
    var CC_CODE: String = ""
    var CC_COUNT_IN: String = ""
    var CC_EXPLAIN: String = ""
    var CC_IMG: String = ""
    var CC_NAME: String = ""
    var CC_STATUS: String = ""
    var DATETIME: String = ""
    var HOME_CODE: String = ""
    var HOUSE_NUMBER: String = ""
    var IDX: String = ""
    var MB_ID: String = ""
    
    func SET_JOIN(JOIN: Any) { self.JOIN = JOIN as? Bool ?? false }
    func SET_AP_CODE(AP_CODE: Any) { self.AP_CODE = AP_CODE as? String ?? "" }
    func SET_BK_NAME(BK_NAME: Any) { self.BK_NAME = BK_NAME as? String ?? "" }
    func SET_BK_NICK(BK_NICK: Any) { self.BK_NICK = BK_NICK as? String ?? "" }
    func SET_BUILDING_ID(BUILDING_ID: Any) { self.BUILDING_ID = BUILDING_ID as? String ?? "" }
    func SET_CC_CODE(CC_CODE: Any) { self.CC_CODE = CC_CODE as? String ?? "" }
    func SET_CC_COUNT_IN(CC_COUNT_IN: Any) { self.CC_COUNT_IN = CC_COUNT_IN as? String ?? "" }
    func SET_CC_EXPLAIN(CC_EXPLAIN: Any) { self.CC_EXPLAIN = CC_EXPLAIN as? String ?? "" }
    func SET_CC_IMG(CC_IMG: Any) { self.CC_IMG = CC_IMG as? String ?? "" }
    func SET_CC_NAME(CC_NAME: Any) { self.CC_NAME = CC_NAME as? String ?? "" }
    func SET_CC_STATUS(CC_STATUS: Any) { self.CC_STATUS = CC_STATUS as? String ?? "" }
    func SET_DATETIME(DATETIME: Any) { self.DATETIME = DATETIME as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_HOUSE_NUMBER(HOUSE_NUMBER: Any) { self.HOUSE_NUMBER = HOUSE_NUMBER as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
}

// 동네시설(카테고리)
class RESTAURANT_C {
    
    var CATE_CODE: String = ""
    var CATE_DEPATH: String = ""
    var CATE_EXPLAIN: String = ""
    var CATE_NAME: String = ""
    var CATE_ICON: String = ""
    var DISPLAY: String = ""
    var IDX: String = ""
    var UPPER_CATE: String = ""
    
    func SET_CATE_CODE(CATE_CODE: Any) { self.CATE_CODE = CATE_CODE as? String ?? "" }
    func SET_CATE_DEPATH(CATE_DEPATH: Any) { self.CATE_DEPATH = CATE_DEPATH as? String ?? "" }
    func SET_CATE_EXPLAIN(CATE_EXPLAIN: Any) { self.CATE_EXPLAIN = CATE_EXPLAIN as? String ?? "" }
    func SET_CATE_NAME(CATE_NAME: Any) { self.CATE_NAME = CATE_NAME as? String ?? "" }
    func SET_CATE_ICON(CATE_ICON: Any) { self.CATE_ICON = CATE_ICON as? String ?? "" }
    func SET_DISPLAY(DISPLAY: Any) { self.DISPLAY = DISPLAY as? String ?? "" }
    func SET_IDX(IDX: Any) { self.IDX = IDX as? String ?? "" }
    func SET_UPPER_CATE(UPPER_CATE: Any) { self.UPPER_CATE = UPPER_CATE as? String ?? "" }
}

// 가족등록(목록)
class FAMILY {
    
    var BK_HP: String = ""
    var BK_NAME: String = ""
    var BK_NICK: String = ""
    var HOME_CODE: String = ""
    var MB_PHOTO: String = ""
    var MB_TYPE: String = ""
    
    func SET_BK_HP(BK_HP: Any) { self.BK_HP = BK_HP as? String ?? "" }
    func SET_BK_NAME(BK_NAME: Any) { self.BK_NAME = BK_NAME as? String ?? "" }
    func SET_BK_NICK(BK_NICK: Any) { self.BK_NICK = BK_NICK as? String ?? "" }
    func SET_HOME_CODE(HOME_CODE: Any) { self.HOME_CODE = HOME_CODE as? String ?? "" }
    func SET_MB_PHOTO(MB_PHOTO: Any) { self.MB_PHOTO = MB_PHOTO as? String ?? "" }
    func SET_MB_TYPE(MB_TYPE: Any) { self.MB_TYPE = MB_TYPE as? String ?? "" }
}
// 자녀안심(위치)
class LOCATE {
    
    var ACCURACY: String = ""
    var BK_NAME: String = ""
    var BK_NICK: String = ""
    var LAT: String = ""
    var LNG: String = ""
    var MB_ID: String = ""
    var REG_DATE: String = ""
    var RESULT: String = ""
    
    func SET_ACCURACY(ACCURACY: Any) { self.ACCURACY = ACCURACY as? String ?? "" }
    func SET_BK_NAME(BK_NAME: Any) { self.BK_NAME = BK_NAME as? String ?? "" }
    func SET_BK_NICK(BK_NICK: Any) { self.BK_NICK = BK_NICK as? String ?? "" }
    func SET_LAT(LAT: Any) { self.LAT = LAT as? String ?? "" }
    func SET_LNG(LNG: Any) { self.LNG = LNG as? String ?? "" }
    func SET_MB_ID(MB_ID: Any) { self.MB_ID = MB_ID as? String ?? "" }
    func SET_REG_DATE(REG_DATE: Any) { self.REG_DATE = REG_DATE as? String ?? "" }
    func SET_RESULT(RESULT: Any) { self.RESULT = RESULT as? String ?? "" }
}
