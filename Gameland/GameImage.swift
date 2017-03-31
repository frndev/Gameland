//
//  GameImage.swift
//  Gameland
//
//  Created by Fran Navarro on 30/3/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import Foundation


class GameImage {
    
    var iconUrl: String?
    var mediumUrl: String?
    var screenUrl: String?
    var smallUrl: String?
    var superUrl: String?
    var thumbUrl: String?
    var tinyUrl: String?
    
    init(iconUrl: String?, mediumUrl: String?, screenUrl: String?, smallUrl: String?, superUrl: String?, thumbUrl: String?, tinyUrl: String?) {
        
        self.iconUrl = iconUrl
        self.mediumUrl = mediumUrl
        self.screenUrl = screenUrl
        self.smallUrl = smallUrl
        self.superUrl = superUrl
        self.thumbUrl = thumbUrl
        self.tinyUrl = tinyUrl
        
    }
    
    
}
