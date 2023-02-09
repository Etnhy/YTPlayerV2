//
//  Network.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation
import Moya


enum YoutubeAPI {
    case getTopChannels(channelId: String)
    case getPlaylists
    case getPlaylistItems(playlistId: String)
    
    case getVideoItems(videoId: String)
    
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
            
        case .getVideoItems(videoId: let id):
            return "videos?part=statistics&part=snippet&id=\(id)&key=\(Net.apiKey)"
        }
        
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        print("\(baseURL)\(path)")
        return .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
    
}
