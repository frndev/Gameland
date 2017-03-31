//
//  VideoGameTableViewController+UITableViewDelegate.swift
//  Gameland
//
//  Created by Fran Navarro on 30/3/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import UIKit


extension GamesTableViewController {
    
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = self.videogames[indexPath.row]
        
        
        let gameDetailVC = GameDetailViewController(game: game)
        
        
        self.navigationController?.pushViewController(gameDetailVC, animated: true)
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
