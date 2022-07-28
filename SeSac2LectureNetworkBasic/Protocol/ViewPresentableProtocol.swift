//
//  ViewPresentableProtocol.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/07/28.
//

import Foundation
import UIKit

/*
 네이밍
 ~~목적~~Protocol
 ~~기능~~Delegate
 */

//프로토콜은 규약이자 필요한 요소를 명세만 할 뿐, 실질적인 구현부는 작성하지 않는다!
//실질적인 구현은 프로토콜을 채택, 준수한 타입에 대해서 구현이 가능하다.
//클래스, 구조체, 확장, 열거형... 에서 사용가능
//클래스는 단일 상속만 가능하지만, 프로토콜은 채택 개수의 제한이 없다.
//@objc optional > 선택적 요청(Optional Requirement)
//프로토콜 프로퍼티, 프로토콜 메서드
//레이블의 텍스트 처럼 쓸거야? 버튼의 커런트타이틀처럼 쓸거야?
//프로토콜 프로퍼티: 연산 프로퍼티로 쓰든 저장 프로퍼티로 쓰든 상관 없다!,
//명세하지 않기ㅇㅔ,구현을 할 때 프로퍼티를 저장 프로퍼티로 쓸 수 있고 연산 프로퍼티로 사용할 수도 있다.
//무조건 var로 선언해야 한다.
//만약에 get만 명시했다면, get 기능만 최소한 구현되어 있으면 된다. +알파로 set기능을 추가해주는 것은 상관 없음!
@objc
protocol ViewPresentableProtocol {
    
    var navigationTitleString: String { get set }
    var backgroundColor: UIColor { get }
    static var identifier: String { get }
    
    func configureView()
    @objc optional func configureLabel()
    @objc optional func configureTextField()
}

/*
 ex. 테이블뷰
 
 */

@objc
protocol jackTableViewProtocol {
    func numberOfRowsInSection() -> Int
    func cellForRowAt(indexPath: IndexPath) -> UITableViewCell
    @objc optional func didSelectRowAt()
}
