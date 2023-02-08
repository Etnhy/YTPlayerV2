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
    
    enum CodingKeys: String, CodingKey {
        case defaultChannelThumbnails = "default"
    }
}
 //MARK: - DefaultChannelThumbnails
struct DefaultChannelThumbnails: Codable {
    let url: String
    let width: Int
    let height: Int
}
/*
 {
     "kind": "youtube#channelListResponse",
     "etag": "VfmgUblnwO0aie9B2CiQ7uLzDBM",
     "pageInfo": {
         "totalResults": 1,
         "resultsPerPage": 5
     },
     "items": [
         {
             "kind": "youtube#channel",
             "etag": "d4e1sa66-5-VknpLNiRwRPcyJVk",
             "id": "UCUM2Q6aQXYex5y36sBej0Ng",
             "snippet": {
                 "title": "Lebanon Hanover",
                 "description": "",
                 "customUrl": "@mehrboysmitrouge",
                 "publishedAt": "2010-07-08T17:39:32Z",
                 "thumbnails": {
                     "default": {
                         "url": "https://yt3.ggpht.com/ytc/AL5GRJW9Pa70BvuohAcsFKSr9yrYa_VF-MGm3YoWjIab=s88-c-k-c0x00ffffff-no-rj-mo",
                         "width": 88,
                         "height": 88
                     },
                     "medium": {
                         "url": "https://yt3.ggpht.com/ytc/AL5GRJW9Pa70BvuohAcsFKSr9yrYa_VF-MGm3YoWjIab=s240-c-k-c0x00ffffff-no-rj-mo",
                         "width": 240,
                         "height": 240
                     },
                     "high": {
                         "url": "https://yt3.ggpht.com/ytc/AL5GRJW9Pa70BvuohAcsFKSr9yrYa_VF-MGm3YoWjIab=s800-c-k-c0x00ffffff-no-rj-mo",
                         "width": 800,
                         "height": 800
                     }
                 },
                 "localized": {
                     "title": "Lebanon Hanover",
                     "description": ""
                 }
             },
             "statistics": {
                 "viewCount": "62873623",
                 "subscriberCount": "184000",
                 "hiddenSubscriberCount": false,
                 "videoCount": "17"
             }
         }
     ]
 }
 */
