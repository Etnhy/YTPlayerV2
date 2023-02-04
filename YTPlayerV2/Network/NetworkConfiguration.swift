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
}
