//
//  Thumbnails.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 09.02.2023.
//

import Foundation


// MARK: - PlaylistItemsThumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high: PlaylistItemsDefault
    let standard, maxres: PlaylistItemsDefault?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault
        case medium, high, standard, maxres
    }
}

// MARK: - PlaylistItemsDefault
struct PlaylistItemsDefault: Codable {
    let url: String
    let width, height: Int
}
//struct Thumbnails: Codable {
//
//    let standard: ThumbnailsStandart
//    let maxres: ThumbnailsMaxres
//
//    enum CodingKeys: String, CodingKey {
//        case standard, maxres
//    }
//
//}
//struct ThumbnailsStandart: Codable {
//    let url: String
//    let width: Int
//    let height: Int
//}
//
//struct ThumbnailsMaxres: Codable {
//    let url: String
//    let width: Int
//    let height: Int
//}

