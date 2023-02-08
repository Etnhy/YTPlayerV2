//
//  PlaylistItems.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation


// MARK: - PlaylistItems
struct PlaylistItems: Codable {
    let kind, etag: String
    let items: [Item]
//    let pageInfo: PageInfo
}

// MARK: - Item
struct Item: Codable {
    let kind: Kind
    let etag, id: String
    let snippet: ItemsSnippet
}

enum Kind: String, Codable {
    case youtubePlaylistItem = "youtube#playlistItem"
}

struct ItemsSnippet: Codable {
    let publishedAt: String
    let channelId: String
    let title: String
    let thumbnails: ItemsThumbnails
    let resourceId: ResourceId
}
struct ResourceId: Codable {
    let videoId: String
}

struct ItemsThumbnails: Codable {
    let defaultThumbnails: DefaultThumbnails
    
    enum CodingKeys: String, CodingKey {
        case defaultThumbnails = "default"
//        case medium
    }
}

/// DefaultThumbnails in PlaylistItems
struct DefaultThumbnails: Codable {
    let url: String
    let width: Int
    let height: Int
}

/// PlaylistItem Medium Thumbnails
struct MediumThumbnailsItems: Codable {
    let url: String
    let width: Int
    let height: Int

}

