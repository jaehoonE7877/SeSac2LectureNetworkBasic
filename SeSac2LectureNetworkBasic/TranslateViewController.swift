//
//  TranslateViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/07/28.
//

import UIKit

import Alamofire
import SwiftyJSON

//UIButton, UITextField > Action
//UITextView, UISearchBar, UIPickerView > X
//UIControl을 상속받지 않은 애들은 Action없음
//UIResponderChain > resignFirstResponder() / becomeFirstResponder()


class TranslateViewController: UIViewController {
        
    @IBOutlet weak var userInputTextView: UITextView!
    @IBOutlet weak var translatedTextView: UITextView!
    
    let textViewPlaceholderText = "번역하고 싶은 문장을 작성해보세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userInputTextView.delegate = self
        
        userInputTextView.text = textViewPlaceholderText
        userInputTextView.textColor = .lightGray
        
        // 구조체나 열거형, 타입프로퍼티로 만들어서 사용!
        userInputTextView.font = UIFont(name: "CookieRunOTF-Regular", size: 17)
        
        translatedTextView.delegate = self
        
        translatedTextView.textColor = .black
        
        
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        
        guard let text = userInputTextView.text else { return }
        
        requestTranslateData(text: text)
        
    }
    
    func requestTranslateData(text: String) {
        
        let url = EndPoint.translateURL
        
        let patameter = ["source": "ko", "target": "en", "text": text]
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        //파라미터 위치는 일정함
        AF.request(url, method: .post, parameters: patameter ,headers: header).validate(statusCode: 200...500).responseJSON { response in //앞쪽 접두어 AF로 바꿔야 함
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                //통신이 잘 됐을 때
                if statusCode == 200 {
                    let result = json["message"]["result"]["translatedText"].stringValue
                    
                    self.translatedTextView.text = result
                } else {
                    self.translatedTextView.text = json["errorMessage"].stringValue
                }
                
                
                
                
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    


}

extension TranslateViewController: UITextViewDelegate {
    
    //텍스트뷰의 텍스트가 변할 때마다 호출
    func textViewDidChange(_ textView: UITextView) {
        //print(textView.text.count)
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
