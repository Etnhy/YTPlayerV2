//
//  Network.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation
import Moya

// https://youtube.googleapis.com/youtube/v3/channels?part=statistics&part=snippet&id=UCUM2Q6aQXYex5y36sBej0Ng&key=[YOUR_API_KEY]

enum YoutubeAPI {
    case getTopChannels(channelId: String)
    case getPlaylists
    case getPlaylistItems(playlistId: String)
    
}

extension YoutubeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "\(Net.api_youtube)")!
    }

    var path: String {
        switch self {
        case .getPlaylists:
            return "playlists?part=snippet&channelId=\(Net.mainProfile)&key=\(Net.apiKey)"
            
        case .getPlaylistItems(playlistId: let playlistId):
            return "playlistItems?part=snippet&part=id&maxResults=10&playlistId=\(playlistId)&key=\(Net.apiKey)"
            
        case .getTopChannels(let channelId):
            return "channels?part=statistics&part=snippet&id=\(channelId)&key=\(Net.apiKey)"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
    
}
