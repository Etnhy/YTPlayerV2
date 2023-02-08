//
//  TopChannelsModel.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 08.02.2023.
//

import Foundation

 //MARK: - TopChannelsModel
struct TopChannelsModel: Codable {
    let kind,etag: String
    let items: [ChannelsItems]
}

 //MARK: - ChannelsItems
struct ChannelsItems: Codable {
    let kind,etag,id: String
    let snippet: ChannelsSnippet
    let statistics: Statistics
}
 //MARK: - Statistics
struct Statistics: Codable {
    let viewCount: String
    let subscriberCount: String
    let videoCount: String

}


 //MARK: - ChannelsSnippet
struct ChannelsSnippet: Codable {
    let title: String
    let thumbnails : ChannelThumbnails
}
 //MARK: - ChannelThumbnails
struct ChannelThumbnails: Codable {
    let defaultChannelThumbnails : DefaultChannelThumbnails
    let high: HighTopChannelThumbnails
    
    enum CodingKeys: String, CodingKey {
        case defaultChannelThumbnails = "default"
        case high
    }
}
 //MARK: - HighTopChannelThumbnails
struct HighTopChannelThumbnails: Codable {
    let url: String
    let width: Int
    let height: Int
}
 //MARK: - DefaultChannelThumbnails
struct DefaultChannelThumbnails: Codable {
    let url: String
    let width: Int
    let height: Int
}
