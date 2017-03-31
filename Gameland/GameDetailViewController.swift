//
//  GameDetailViewController.swift
//  Gameland
//
//  Created by Fran Navarro on 30/3/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    let game : VideoGame
    
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameDeckTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    init(game: VideoGame) {
        self.game = game
        super.init(nibName:nil, bundle:nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = game.name
        self.gameDeckTextView.text = game.deck == nil ? "No description" : game.deck
        self.activityIndicator.isHidden = true
        
        if game.gameImage != nil {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()

            let url = URL(string: (game.gameImage?.mediumUrl)!)!
            
            DispatchQueue.global(qos:.userInitiated).async{
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.gameImageView.image = UIImage(data: data)
                        self.activityIndicator.stopAnimating()
                        
                    }
                } catch {
                    print(error)
                }
                
            }
            
        }else {
            self.gameImageView.image = UIImage(named: "thumbnail")
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        
        
    }

    @IBAction func userDidClickWeb(_ sender: UIButton) {
        
        let urlString = game.siteDetailUrl
        
        let webVC = WebsiteViewController(urlString: urlString!)
        let webNavVC = UINavigationController(rootViewController: webVC)
        
        self.navigationController?.present(webNavVC, animated: true, completion: nil)
        
        
    }


}
