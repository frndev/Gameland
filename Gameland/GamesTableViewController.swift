//
//  GamesTableViewController.swift
//  Gameland
//
//  Created by Fran Navarro on 21/3/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import UIKit

class GamesTableViewController: UITableViewController {
    
    var videogames: [VideoGame] = []
    let searchController = UISearchController(searchResultsController: nil)
    var task : URLSessionTask?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Videojuegos"
        let nib = UINib(nibName: "VideoGameTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "gameCell")
        
        
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self

        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        
        self.searchVideogamesBy(name: "")
        
        
        

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return videogames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // No carga en memoria las 1000 celdas
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell") as! VideoGameTableViewCell
        
        let game = videogames[indexPath.row]
        
        cell.gameNameLabel.text = game.name
        cell.accessoryType = .disclosureIndicator
        cell.activityIndicator.isHidden = true
        if game.gameImage != nil {
            cell.activityIndicator.isHidden = false
            cell.activityIndicator.startAnimating()
            let url = URL(string: (game.gameImage?.thumbUrl)!)!
            
            DispatchQueue.global(qos:.userInitiated).async{
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        cell.gameIconImageView.image = UIImage(data: data)
                        cell.activityIndicator.stopAnimating()
                    }
                } catch {
                    print(error)
                }
                
            }

        }else {
            cell.gameIconImageView.image = UIImage(named: "thumbnail")
        }
        
        return cell
    }

    func searchVideogamesBy(name text: String) {
        
        self.task = API.searchVideoGamesBy(name: text, completionHandler: { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            
            self.videogames = Parser.parse(videogames:data!)
            // Recargar tabla
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
        
    }
    
}


extension GamesTableViewController: UISearchResultsUpdating {
    
    
    public func updateSearchResults(for searchController: UISearchController) {
        
        // Comprobar la cantidad de caracteres introducidos
        
        let text = searchController.searchBar.text!
        
        if !text.isEmpty{
            self.task?.cancel()
            // Acceder a la API
            DispatchQueue.global(qos:.background).async {
                self.searchVideogamesBy(name:text)

            }
            
           

            
        }
        
    }

    
}

extension GamesTableViewController: UISearchBarDelegate {


    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.searchBar.text = searchBar.text
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       searchBar.resignFirstResponder()
    }
    
    
    
}




