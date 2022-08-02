//
//  BeerDescriptionViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/08/02.
//

import UIKit

class BeerDescriptionViewController: UIViewController {

    var beerDescription: String?
    
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    static let identifier = "BeerDescriptionViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let beerDescription = beerDescription else {
            return
        }
        
        beerDescriptionLabel.numberOfLines = 0
        
        beerDescriptionLabel.text = beerDescription
        
    }
    

}
