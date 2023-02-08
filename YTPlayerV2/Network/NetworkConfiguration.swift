//
//  NetworkConfiguration.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation


struct Net {
    /// api url
    static let api_youtube: String = {
        guard let api = Bundle.main.object(forInfoDictionaryKey: "api_youtube") as? String else {
            fatalError()
        }
        return "\(api)"
    }()
    
    /// api key
    static let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "api_key") as? String else {
            fatalError()
        }
        return "\(key)"
    }()
    
    static let mainProfile = "UCyxvZQw2Os4LvdPkNqSB8nw"
    static let channelsIDs = ["UCUM2Q6aQXYex5y36sBej0Ng","minuitmachine",
                              "pleasuresymbols2594","LadytronMusic"]
    
}
