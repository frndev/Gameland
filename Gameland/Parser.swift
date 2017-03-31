//
//  Parser.swift
//  Gameland
//
//  Created by Fran Navarro on 30/3/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import Foundation


struct Parser {
    
    typealias JSONObject = Any
    typealias JSONDictionary = [String : JSONObject]
    typealias JSONArray = [JSONDictionary]
    
    
    static func parse(videogames data: Data) -> [VideoGame] {
        
        var json : JSONDictionary!
        
        do {
            json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! JSONDictionary
            
            return decodeResults(json)
            
        }catch let error as NSError{
            print(error)
        }
        
        return []

    }
    
    static func decodeResults(_ json: JSONDictionary) -> [VideoGame] {
        
        guard let results = json["results"] as? JSONArray else{
            
            return []
            
        }
        
        var videogames : [VideoGame] = []
        
        for videogame: JSONDictionary in results {
            videogames.append(decode(videogame: videogame))
        }
        
        return videogames
        
    }
    
    static func decode(videogame v: JSONDictionary) -> VideoGame {
        
        let name = v["name"] as? String
        
        let deck = v["deck"] as? String
        
        let originalReleaseDate = v["original_release_date"] as? String
        let siteDetailUrl = v["site_detail_url"] as? String
        
        var platforms: [Platform] = []
        if let platformsArray = v["platforms"] as? JSONArray {
            for platform in platformsArray {
                platforms.append(decode(platform:platform))
            }
        }
        
        
        
        var gameImage: GameImage? = nil
        if let gameImageDictionary = v["image"] as? JSONDictionary {
            
            gameImage = decode(gameImage:gameImageDictionary)
        }
        
        
        return VideoGame(name: name, originalReleaseDate: originalReleaseDate, deck: deck, gameImage: gameImage, platforms: platforms, siteDetailUrl: siteDetailUrl)
        
    
    }
    
    static func decode(platform p: JSONDictionary) -> Platform {
        
        let name = p["name"] as? String
        let siteDetailUrl = p["site_detail_url"] as? String
        
        return Platform(name: name, siteDetailUrl: siteDetailUrl)
  
    }
    
    static func decode(gameImage g: JSONDictionary) -> GameImage {
        
        let iconUrl = g["icon_url"] as? String
        let mediumUrl = g["medium_url"] as? String
        let screenUrl = g["screen_url"] as? String
        let smallUrl = g["small_url"] as? String
        let superUrl = g["super_url"] as? String
        let thumbUrl = g["thumb_url"] as? String
        let tinyUrl = g["tiny_url"] as? String
        
        return GameImage(iconUrl: iconUrl, mediumUrl: mediumUrl, screenUrl: screenUrl, smallUrl: smallUrl, superUrl: superUrl, thumbUrl: thumbUrl, tinyUrl: tinyUrl)
        
    }
    
    
    
    
}
















