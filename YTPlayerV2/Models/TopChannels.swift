//
//  TopChannels.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 12.02.2023.
//

import Foundation

 //MARK: - TopChannels
struct TopChannels: Codable {
    let kind,etag: String
    let items: [PlaylistItems]
}
