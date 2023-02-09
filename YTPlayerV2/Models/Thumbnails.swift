//
//  Thumbnails.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 09.02.2023.
//

import Foundation

 //MARK: - Thumbnails
struct Thumbnails: Codable {
    let defaultThumbnails : DefaultThumbnails
    let high: HighThumbnails
    
    enum CodingKeys: String, CodingKey {
        case defaultThumbnails = "default"
        case high
    }
}

 //MARK: - HighTopChannelThumbnails
struct HighThumbnails: Codable {
    let url: String
    let width: Int
    let height: Int
}

 //MARK: - DefaultChannelThumbnails
struct DefaultThumbnails: Codable {
    let url: String
    let width: Int
    let height: Int
}

