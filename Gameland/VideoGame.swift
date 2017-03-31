//
//  VideoGame.swift
//  Gameland
//
//  Created by Fran Navarro on 30/3/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import Foundation


class VideoGame {
    
    var name: String?
    var originalReleaseDate: String?
    var deck: String?
    var gameImage: GameImage?
    var platforms: [Platform]?
    var siteDetailUrl: String?
    
    
    init(name: String?, originalReleaseDate: String?, deck: String?, gameImage: GameImage?, platforms: [Platform], siteDetailUrl: String?) {
        
        self.name = name
        self.originalReleaseDate = originalReleaseDate
        self.deck = deck
        self.gameImage = gameImage
        self.platforms = platforms
        self.siteDetailUrl = siteDetailUrl
        
    }
    
    
}
