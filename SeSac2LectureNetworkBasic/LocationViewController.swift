//
//  LocationViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {
    
    //Notification 1. user notification 클래스의 인스턴스 생성
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAuthorization()
    }
    
    @IBAction func notificationButtonTapped(_ sender: UIButton) {
        sendNotification()
    }
    
    // Notification 2. 권한 요청
    func requestAuthorization() {
        
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        // bool -> 사용자가 요청을 받았는가?! Error
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            
            if success {
                self.sendNotification()
            }
            
        }
        
    }

    // Notification 3. 권한 허용했을 때 알림 요청(언제보낼거냐? 어떤 컨텐츠를 보낼거냐)
    // iOS 시스템에서 알림을 담당하기 때문에 알림을 등록
    
    /*
     - 권한 허용 해야만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한 번만 뜬다.
     - 허용 안 된 경우 애플 설정으로 직접 유도하는 코드를 구성해야 한다.
     
     - 기본적으로 알림은 포그라운드에서 수신되지 않는다. (앱딜리게이트 메서드로 해결)
     - 로컬 알림에서 60초 이상 반복 가능 / 개수 제한 64개 / 커스텀 사운드
     
     
     1. 뱃지 제거? > 언제 제거하는게 맞을 까? -> sceneDelegate에서
     2. 노티 제거? > 노티의 유효기간은? > appdelegate에서 launch 될 때 or scenedelegate 에서 forground
     3. 포그라운드 수신? > 앱을 사용하는 동안에도 push, 노티를 받고 싶을 때 (앱딜리게이트 메서드로 해결!)
     
     +a
     - 노티는 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정 화면으로 가고 싶다면?
     - 포그라운드 수신 > 채팅방 기반으로 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 받고 싶다면?
     - iOS15 알림 집중모드 등 5~6개 우선순위 존재!
     */
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "다마고치를 키워보세요"
        notificationContent.subtitle = "오늘 행운의 숫자는 \(Int.random(in: (1...100)))입니다."
        notificationContent.body = "저는 따끔따끔 다마고치입니다. 배고파요."
        notificationContent.badge = 40
        
        // 언제 보낼 것인가? 1.시간 간격 2. 캘린더 3. 위치에 따라 설정 가능.
        // 1. 시간 간격일 때는 60초 이상 설정해야 반복 가능
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false
        )
        
        var dateComponents = DateComponents()
        dateComponents.minute = 15
        
        let notiTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents , repeats: true)
        
        // 알림 요청
        // identifier : 만약 알림 관리할 필요 없다 -> 알림 클릭하면 앱을 켜주는 정도.
        // 만약 알림 관리 할 필요가 있다. -> +1, 고유 이름, 규칙 등
        
        let request = UNNotificationRequest(identifier: "jack", content: notificationContent, trigger: notiTrigger)
        
        notificationCenter.add(request)
    }
    
    
}
