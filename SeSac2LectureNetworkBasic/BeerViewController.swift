//
//  BeerViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/08/01.
//

import UIKit

import Alamofire
import SwiftyJSON
import Kingfisher

class BeerViewController: UIViewController {

    
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var beerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerDescriptionLabel.numberOfLines = 0
        
        beerNameLabel.textColor = .black
        beerNameLabel.font = .boldSystemFont(ofSize: 14)
        beerNameLabel.textAlignment = .center
        beerNameLabel.layer.borderWidth = 1
        beerNameLabel.text = "맥주 이름!"
        
        beerDescriptionLabel.textColor = .black
        beerDescriptionLabel.font = .systemFont(ofSize: 14)
        beerDescriptionLabel.textAlignment = .center
        beerDescriptionLabel.layer.borderWidth = 1
        beerDescriptionLabel.text = "맥주 설명!"
        
        searchButton.setTitle("맥주를 찾아보자!", for: .normal)
        searchButton.backgroundColor = .yellow
        searchButton.tintColor = .black
        
        beerImageView.layer.borderWidth = 1
    }
    
    func searchBeer(){
        
        let url = "https://api.punkapi.com/v2/beers/random"
        
        //AF: 200~299 status code 성공
        AF.request(url, method: .get).validate().responseJSON { response in //앞쪽 접두어 AF로 바꿔야 함
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                
                let imageURL = json[0]["image_url"].stringValue
                if imageURL == "" {
                    self.beerImageView.image = UIImage(systemName: "photo")
                }
                let beerImageUrl = URL(string: imageURL)
                self.beerImageView.kf.setImage(with: beerImageUrl)
                
                let beerName: String = json[0]["name"].stringValue
                self.beerNameLabel.text = beerName
               

                let beerDescription: String = json[0]["description"].stringValue
                self.beerDescriptionLabel.text = beerDescription
               

            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchBeer()
    }
    
    

}
