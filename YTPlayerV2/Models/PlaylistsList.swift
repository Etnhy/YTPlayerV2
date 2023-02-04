//
//  PlaylistsList.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation


// MARK: - PlaylistsList
struct PlaylistsList: Codable {
    let kind, etag: String
    let pageInfo: PageInfo
    let items: [Playlist]
}

// MARK: - Playlist
struct Playlist: Codable {
    let kind, etag, id: String
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int
}
