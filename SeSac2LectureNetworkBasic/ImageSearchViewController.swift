//
//  ImageSearchViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/08/03.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

struct ImageInfo {
    let imageUrl: String
}


class ImageSearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var imageSearchCollectionView: UICollectionView!
    
    var imageURLList = [ImageInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSearchCollectionView.delegate = self
        imageSearchCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 20
        
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 1.2 )
        
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        imageSearchCollectionView.collectionViewLayout = layout
        
        imageSearchCollectionView.backgroundColor = UIColor.systemGray4
        
        fetchImage(text: "과자")
        
    }
    
    //fetchImage, requestImage, callRequestImage, getImage ... > response에 따라 네이밍을 설정해주기도 함.
    //페이지네이션 : 많은 데이터를 적당한 리소스를 가져와서 통신하는 것(사용자가 어디까지 스크롤했는지 시점에 맞춰서 기능 구현)
    // 1. offset 페이지 네이션
    // 2. cursor 페이지 네이션 > 데이터가 겹치는 중복을 방지
    func fetchImage(text: String) {
        
        //한글로 변환
        let kText = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let kText = kText else { return }
        
        
        let url = EndPoint.imageSearchURL + "query=\(String(describing: kText))&display=30&start=31&sort=sim"
        
        let header: HTTPHeaders = ["X-Naver-Client-Id": APIKey.NAVER_ID, "X-Naver-Client-Secret": APIKey.NAVER_SECRET]
        
        //파라미터 위치는 일정함
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in //앞쪽 접두어 AF로 바꿔야 함
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["items"].arrayValue{
                    
                    let imageURL = item["link"].stringValue
                    
                    self.imageURLList.append(ImageInfo(imageUrl: imageURL))
                }
                
                self.imageSearchCollectionView.reloadData()
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageURLList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = imageSearchCollectionView.dequeueReusableCell(withReuseIdentifier: ImageSearchCollectionViewCell.identifier, for: indexPath) as? ImageSearchCollectionViewCell else { return UICollectionViewCell() }
        
        

        let imageUrl = URL(string: imageURLList[indexPath.item].imageUrl )
        
        cell.searchImageView.kf.setImage(with: imageUrl)
        
        return cell
    }
    
}
