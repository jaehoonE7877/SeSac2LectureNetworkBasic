//
//  TranslateViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/07/28.
//

import UIKit

//UIButton, UITextField > Action
//UITextView, UISearchBar, UIPickerView > X
//UIControl을 상속받지 않은 애들은 Action없음
//UIResponderChain > resignFirstResponder() / becomeFirstResponder()


class TranslateViewController: UIViewController {
        
    @IBOutlet weak var userInputTextView: UITextView!
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        // 구조체나 열거형, 타입프로퍼티로 만들어서 사용!
        userInputTextView.font = UIFont(name: "CookieRunOTF-Regular", size: 17)
        
    }
    


}

extension TranslateViewController: UITextViewDelegate {
    
    //텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
    }
    
    //편집이 시작될 때. 커서가 시작될 때
    //텍스트뷰의 글자: 플레이스 홀더랑 글자가 같으면 clear
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Begin")
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    //편집이 끝났을 때, 커서가 없어지는 순간
    //텍스트뷰 글자: 플레이스 홀더랑 글자가 같으면 clear
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        if textView.text.isEmpty {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
    }
    
    
}
