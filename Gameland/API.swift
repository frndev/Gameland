//
//  API.swift
//  Gameland
//
//  Created by Fran Navarro on 30/3/17.
//  Copyright © 2017 frndev. All rights reserved.
//

import Foundation

struct API {
    // api_key=779aca1db8cddfb870fd74d7d7c2c6e4177d626c&format=json&filter=name:bandicoot&field_list=name,image,platforms,deck,site_detail_url,original_release_date
    
    static let apiKey = "779aca1db8cddfb870fd74d7d7c2c6e4177d626c"
    static let videoGameEndPoint = "https://www.giantbomb.com/api/games?"
    
    static func searchVideoGamesBy(name text: String, completionHandler handler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        
        let videoGameUrl = videoGameEndPoint + "api_key=779aca1db8cddfb870fd74d7d7c2c6e4177d626c&format=json&filter=name:\(text)&field_list=name,image,platforms,deck,site_detail_url,original_release_date"
        
        var request = URLRequest(url: URL(string: videoGameUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)!)
        request.httpMethod = "GET"
        
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request, completionHandler: handler)
        
        task.resume()
        
        return task
    }
    
}

