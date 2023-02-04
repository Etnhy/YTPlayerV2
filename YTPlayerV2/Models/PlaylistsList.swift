//
//  PlaylistsList.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation



//MARK: -  Playlist List
struct PlaylistsList: Codable {
    let kind,etag: String
    let items: [Items]
}
 //MARK: - Items
struct Items: Codable {
    let kind, etag, id: String
    let snippet: Snippet
    
}
//MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: String
    let channelId: String
    let title : String
    let description: String?
    let thumbnails: Thumbnails
}
//MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault: Default
    let medium: Medium
    
    
    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium
    }
}
//MARK: - Default
struct Default: Codable {
    let url: String
    let width: Int
    let height: Int
}
//MARK: - Medium
struct Medium: Codable {
    let url: String
    let width: Int
    let height: Int
}
