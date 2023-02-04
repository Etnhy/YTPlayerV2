//
//  PlaylistItems.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation


// MARK: - Welcome
struct PlaylistItems: Codable {
    let kind, etag: String
    let items: [Item]
//    let pageInfo: PageInfo
}

// MARK: - Item
struct Item: Codable {
    let kind: Kind
    let etag, id: String
}

enum Kind: String, Codable {
    case youtubePlaylistItem = "youtube#playlistItem"
}

//// MARK: - PageInfo
//struct PageInfo: Codable {
//    let totalResults, resultsPerPage: Int
//}
