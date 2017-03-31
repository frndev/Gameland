//
//  WebsiteViewController.swift
//  Gameland
//
//  Created by Fran Navarro on 31/3/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import UIKit

class WebsiteViewController: UIViewController, UIWebViewDelegate {

    var urlString: String
    
    @IBOutlet weak var webView: UIWebView!
    
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName:nil,bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.allowsLinkPreview = false
        
        let request = URLRequest(url: URL(string: urlString)!)
        self.webView.loadRequest(request)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(exitWebsite(_:)))

        
    }
    
    func exitWebsite(_ sender: UIBarButtonItem) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if navigationType == .linkClicked {
            return false
        }
        
        return true
    }

    
}
