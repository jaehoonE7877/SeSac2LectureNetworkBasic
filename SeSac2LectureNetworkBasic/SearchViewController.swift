//
//  SearchViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/07/27.
//

import UIKit

import Alamofire
import SwiftyJSON
/*
 Swift Protocol
 - Delegate
 - Datasource
 
 1. 왼팔/오른팔 프로토콜 가져오기
 2. 테이블 뷰 아웃렛 연결
 3. 1 + 2를 뷰딛로드에서 연결해줌
 
 */

extension UIViewController {
    
    func setBackgroundColor() {
        view.backgroundColor = .red
    }
}


class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let dateFormatter = DateFormatter()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var secondTableView: UITableView!
    
    //BoxOffice 배열
    var list: [BoxOfficeModel] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        
        //테이블뷰가 사용할 테이블 뷰 셀(XIB) 등록
        //XIB : xml interface builder <= NIB이라고 사용햇었음
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier , bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
        requestBoxOffice(text: "20220801")

        searchBar.delegate = self
    }
    
    func getYesterday(text: String?) -> String {
        
        guard let text = text else { return "날짜를 잘못 입력하셨습니다."}
        
        dateFormatter.dateFormat = "yyyyMMdd"
        let currentDate = dateFormatter.date(from: text)!
        let rawYesterday = currentDate - 86400
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)    // 1은 내일 -1은 어제
        
        return dateFormatter.string(from: rawYesterday)
    }
    
    
    func requestBoxOffice(text: String){
        
        list.removeAll() //로딩바를 띄워주기
        
        let url = "\(EndPoint.boxOfficeURL)key=\(APIKey.BOXOFFICE)&targetDt=\(text)"

        // 네트워크 통신: 서버 점검 등에 대한 예외 처리
        // 네트워크 통신이 느린 환경 테스트 시 컨디션 조절 가능
        // 살가가 태수투 사 condition 조절 가능!
        // 시뮬레이터에서도 가능! (추가 설치)
        AF.request(url, method: .get).validate().responseJSON { response in //앞쪽 접두어 AF로 바꿔야 함
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
//                self.list.removeAll()
                
                // 원래 arrayvalue가 아닌 -> array로 처리해서 옵셔널 처리 해야됨
                for movie in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    
                    let movieNm = movie["movieNm"].stringValue
                    let openDt = movie["openDt"].stringValue
                    let audiAcc = movie["audiAcc"].stringValue
                    
                    let data = BoxOfficeModel(movieTitle: movieNm, releaseDate: openDt, totalCount: audiAcc)
                    
                    self.list.append(data)
                }
                
                print(self.list)
                
                // reloadData 진짜 중요함(테이블뷰 갱신)
                self.searchTableView.reloadData()
                
                print(self.list)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
//    func configureLabel() {
//
//    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.listTableViewLabel.font = .boldSystemFont(ofSize: 22)
        cell.listTableViewLabel.text = "\(list[indexPath.row].movieTitle): \(list[indexPath.row].releaseDate)"
        
        
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    //강제 해제 연산자 제거, 8글자, 숫자, 날짜로 변경 시 유효한 형태의 값인 지 등
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        requestBoxOffice(text: getYesterday(text: searchBar.text))
    }
}
