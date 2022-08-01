//
//  UserDefaultsHelper.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/08/01.
//

import Foundation

class UserDefaultsHelper {
    
    private init() { }
    
    // 인스턴스만 메모리에 올려놓고 그 안에 있는 메서드는 가져다 사용
    static let standard = UserDefaultsHelper()    // 자기 자신의 인스턴스를 타입 프로퍼티 형태로 가지고 있음
                                                
    let userDefaults = UserDefaults.standard //싱글톤 패턴(shared, standard)
    
    enum Key: String {
        case nickname , rice, water, first
    }
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? "대장"
        }
        set {
            return userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var rice: Int {
        get {
            return userDefaults.integer(forKey: Key.rice.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.rice.rawValue)
        }
    }
    
}
