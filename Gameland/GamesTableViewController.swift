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
    var searchText: String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Videojuegos"
        let videoGameNib = UINib(nibName: "VideoGameTableViewCell", bundle: nil)
        let searchNib = UINib(nibName: "LoadingTableViewCell", bundle: nil)
        self.tableView.register(videoGameNib, forCellReuseIdentifier: "gameCell")
        self.tableView.register(searchNib, forCellReuseIdentifier: "searchCell")
        
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
        
        if self.videogames.count == 0 {
            return 1
        }
        
        return self.videogames.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.videogames.count == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! LoadingTableViewCell
            cell.searchLabel.text = "Buscando \"\(self.searchText)\""
            cell.activityIndicator.startAnimating()
            
            return cell
        }
      
         return configureVideoGameCell(at:indexPath)
        
        
    }
    
    func configureVideoGameCell(at indexPath: IndexPath) -> VideoGameTableViewCell {
        
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
            if let err = error {
                print(err.localizedDescription)
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
        self.videogames = []
        self.tableView.reloadData()
        searchText = searchController.searchBar.text!
        self.task?.cancel()
        // Acceder a la API
        DispatchQueue.global(qos:.background).async {
            self.searchVideogamesBy(name:self.searchText)

        }
    }
}

extension GamesTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       searchBar.resignFirstResponder()
    }
    
}




