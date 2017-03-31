//
//  HomeViewController.swift
//  Gameland
//
//  Created by Fran Navarro on 21/3/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(userDidTapOnImageView(_:)))
        
        self.logoImageView.addGestureRecognizer(tap)
        self.logoImageView.isUserInteractionEnabled = true
        
        animateInfoLabelWith(alpha:0)
        
    }

    func userDidTapOnImageView(_ sender: UITapGestureRecognizer) {
        
        let gamesTVC = GamesTableViewController()
        
        let navController = UINavigationController(rootViewController: gamesTVC)
        
        self.present(navController, animated: true, completion: nil)
        
    }
    
    func animateInfoLabelWith(alpha a: CGFloat) {
        
        UIView.animate(withDuration: 0.85, animations: {
            self.infoLabel.alpha = a
            }) { (finished) in
                self.animateInfoLabelWith(alpha: a == 0 ? 1 : 0)
        }
        
    }
    
  
    
    
    
}


