//
//  SearchViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/07/27.
//

import UIKit

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
    
    
    
    
    @IBOutlet weak var searchTableView: UITableView!
    
    @IBOutlet weak var secondTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        
        //테이블뷰가 사용할 테이블 뷰 셀(XIB) 등록
        //XIB : xml interface builder <= NIB이라고 사용햇었음
        searchTableView.register(UINib(nibName: ListTableViewCell.reuseIdentifier , bundle: nil), forCellReuseIdentifier: ListTableViewCell.reuseIdentifier)
        
    }
    
    
    func configureView() {
        searchTableView.backgroundColor = .clear
        searchTableView.separatorColor = .clear
        searchTableView.rowHeight = 60
    }
    
    func configureLabel() {
         
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.reuseIdentifier, for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        cell.backgroundColor = .clear
        cell.listTableViewLabel.font = .boldSystemFont(ofSize: 22)
        cell.listTableViewLabel.text = "HELLO"
        
        return cell
    }
    
}
