//
//  ChannelsPlaylists.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 09.02.2023.
//

import Foundation


 //MARK: - ChannelsPlaylists
struct ChannelsPlaylists: Codable {
    let items: [ChannelItems]
}
 //MARK: - ChannelItems
struct ChannelItems:Codable {
    let id: String
    let snippet: Snippet
}
