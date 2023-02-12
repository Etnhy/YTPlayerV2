//
//  VideoData.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 10.02.2023.
//

import Foundation

 //MARK: - VideoData
struct VideoData: Codable {
    let kind,etag: String
    let items: [VideoItems]
    
}

 //MARK: - VideoItems
struct VideoItems: Codable {
    let kind,etag,id: String
    let snippet: Snippet
    let statistics: VideoStatistics
}
