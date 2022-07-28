//
//  WebViewViewController.swift
//  SeSac2LectureNetworkBasic
//
//  Created by Seo Jae Hoon on 2022/07/28.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var webView: WKWebView!
    
    //App Transport Scurity Settings
    //http X
    var destinationURL: String = "https://www.apple.com"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        openWebPage(url: destinationURL)
        searchBar.delegate = self
    }
    
    func openWebPage(url: String){
        guard let url = URL(string: url) else {
            print("Invalid URl")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }

    
    @IBAction func goBackButtonTapped(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func reloadButtonGTapped(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func goForwardButtonTapped(_ sender: Any) {
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    
}



extension WebViewViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        openWebPage(url: searchBar.text!)
    }
}
