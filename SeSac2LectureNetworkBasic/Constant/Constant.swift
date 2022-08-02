//
//  Constant.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/08/01.
//

import Foundation

struct APIKey {
    static let BOXOFFICE = "faff0d115c09cbd79a3e4bad25d907a4"
    
    static let NAVER_ID = "TNRc5NfUf6sqkTiPy72M"
    static let NAVER_SECRET = "ZWKJLPOWyO"
}

struct EndPoint{
    static let boxOfficeURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    static let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo"
    static let translateURL = "https://openapi.naver.com/v1/papago/n2mt"
    static let beerUrl = "https://api.punkapi.com/v2/beers"
}





//enum StoryboardName: String{
//    case Main
//    case Setting
//    case Choice
//    case Detail
//    case NameSetting
//}

//StoryboardName.Main.rawValue

// 구조체나 열거형을 사용해서 하드 코드 줄이기
//struct StoryboardName {
//    static let main = "Main"
//    static let search = "Search"
//    static let setting = "Setting"
//}


// 열거형속 타입 프로퍼티(l할 수 없기 때문에 타입 저장 프로퍼티로 사용 가능)
fileprivate enum StoryboardName {
        static let main = "Main"
        static let search = "Search"
        static let setting = "Setting"
}
// 장점
/*
 1. Struct Type Property vs Enum Type Property => 인스턴스 생성 방지
2. enum case vs enum static let => rawValue가 무조건 고유해야 한다.(중복된 내용을 하드코딩할 수 있는지 없는지) , case 제약(UIColor나 폰트 같은 것을 사용할 수 없음f)
 */

enum FontName{
    static let title = "Sanfransisco"
    static let body = "Sanfransisco"
    static let caption = "Apple"
}
