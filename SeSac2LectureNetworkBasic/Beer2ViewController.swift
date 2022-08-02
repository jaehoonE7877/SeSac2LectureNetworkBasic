//
//  Beer2ViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/08/02.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class Beer2ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let identifier = "Beer2ViewController"
    
    @IBOutlet weak var beerCollectionView: UICollectionView!
    
    static var descArr = [String]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //연결고리 작업: 테이블뷰가 해야 할 역할 > 뷰 컨트롤러에게 요청
        beerCollectionView.delegate = self
        beerCollectionView.dataSource = self
        
        
        //테이블뷰가 사용할 테이블 뷰 셀(XIB) 등록
        //XIB : xml interface builder <= NIB이라고 사용햇었음
        //beerCollectionView.register(UINib(nibName: Beer2CollectionViewCell.identifier , bundle: nil), forCellWithReuseIdentifier: Beer2CollectionViewCell.identifier)
        
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 20
        
        let width = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 1.2 )
        
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        beerCollectionView.collectionViewLayout = layout
        
        beerCollectionView.backgroundColor = UIColor.systemGray4
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = beerCollectionView.dequeueReusableCell(withReuseIdentifier: Beer2CollectionViewCell.identifier, for: indexPath) as? Beer2CollectionViewCell else { return UICollectionViewCell() }
        
        
        cell.backgroundColor = .systemGray4
        
        func requestBeer() {
            
            let url = EndPoint.beerUrl
            
            
            AF.request(url, method: .get).validate().responseJSON { response in //앞쪽 접두어 AF로 바꿔야 함
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
                    let imageURL = json[indexPath.row]["image_url"].stringValue
                    let beerImageUrl = URL(string: imageURL)
                    let beerName = json[indexPath.row]["name"].stringValue
                    
                    
                    Beer2ViewController.descArr.append(json[indexPath.row]["description"].stringValue)
                
                    cell.beerNameLabel.text = beerName
                    cell.beerImageView.kf.setImage(with: beerImageUrl)
                    
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        requestBeer()
        
        cell.beerNameLabel.textColor = .black
        cell.beerNameLabel.font = .boldSystemFont(ofSize: 14)
        cell.beerNameLabel.textAlignment = .center
        cell.beerNameLabel.layer.borderWidth = 1

        
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: BeerDescriptionViewController.identifier) as! BeerDescriptionViewController
        
        
        vc.beerDescription = Beer2ViewController.descArr[indexPath.row]
        
        self.present(vc, animated: true)
    }
    
}
