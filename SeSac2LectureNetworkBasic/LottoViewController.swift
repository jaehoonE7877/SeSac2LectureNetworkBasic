//
//  LottoViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/07/28.
//

import UIKit
// 1. 라이브러리 import
import Alamofire
import SwiftyJSON

enum lotto: String {
    case drwtNo1
}

class LottoViewController: UIViewController {
    
    
    
    @IBOutlet weak var numberTextField: UITextField!
//    @IBOutlet weak var lottoPickerView: UIPickerView!
    
    @IBOutlet var lottoNumberLabelCollection: [UILabel]!
    
    var lottoPickerView = UIPickerView()
    //코드로 뷰를 만드는 기능이 훨씬 더 많이 남아있슴!!
    
    let numberList: [Int] = Array(1...1025).reversed()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메시지 앱에서 인증번호를 자동으로 넣어주는 앱
        numberTextField.textContentType = .oneTimeCode
        
        numberTextField.tintColor = .clear
        numberTextField.inputView = lottoPickerView
        
        lottoPickerView.delegate = self
        lottoPickerView.dataSource = self
        
        designLabel(lottoNumberLabelCollection)
        
        requestLotto(number: 1025)
        
        
        for i in 1...6 {
            lottoNumberLabelCollection[i].tag = i
        }
        
    }
    
    func designLabel(_ labelCollection: [UILabel]){
        
        for item in labelCollection {
            item.font = UIFont.boldSystemFont(ofSize: 30)
            item.textColor = .black
            item.textAlignment = .center
            item.layer.cornerRadius = 20
            item.clipsToBounds = true
            item.backgroundColor = UIColor.init(red: 77/255, green: 120/255, blue: 140/255, alpha: 0.8)
        }
    }
    
    func requestLotto(number: Int){
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        //AF: 200~299 status code 성공
        AF.request(url, method: .get).validate().responseJSON { response in //앞쪽 접두어 AF로 바꿔야 함
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let bonus = json["bnusNo"].intValue
                print(bonus)
                
                let date = json["drwNoDate"].stringValue
                print(date)
                
                self.numberTextField.text = date
                
                
                for i in 1...6 {
                    self.lottoNumberLabelCollection[i-1].text = String(json["drwtNo\(self.lottoNumberLabelCollection[i].tag)"].intValue)
                }
                self.lottoNumberLabelCollection[6].text = String(json["bnusNo"].intValue)
                
                
            case .failure(let error):
                print(error)
            }
        }
        
    }

}

// 안에 들어가는 객체에 대한 확장은 밑에서 주로 한다.
extension LottoViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        requestLotto(number: numberList[row])
        //numberTextField.text = "\(numberList[row])회차"
        
        
        }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(numberList[row])회차"
    }
}
