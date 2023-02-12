//
//  PlaylistItems.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 09.02.2023.
//

import Foundation

 //MARK: - Playlist
struct Playlist: Codable {
    let kind,etag: String
    let items: [PlaylistItems]
}

 //MARK: - PlaylistItems
struct PlaylistItems: Codable {
    let id: String
    let snippet: Snippet

}

