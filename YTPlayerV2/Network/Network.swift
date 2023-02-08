//
//  Network.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation
import Alamofire

///https://www.googleapis.com/youtube/v3
//  'https://youtube.googleapis.com/youtube/v3/playlists?channelId=UCyxvZQw2Os4LvdPkNqSB8nw&key=[YOUR_API_KEY]' \
// https://youtube.googleapis.com/youtube/v3/playlistItems?maxResults=10&playlistId=PLNZta_SFvNjES8JspnOD2PIYV9X9CetcG&key=AIzaSyBhxXFXV7LH2TpcWMsn4Z2qb0ZWt-xHYt0

class Network {
    static let shared = Network()

        func getPlaylists(completion: @escaping (Result<PlaylistsList,AFError>) ->()) {
            let url = "\(Net.api_youtube)playlists?part=snippet&channelId=UCyxvZQw2Os4LvdPkNqSB8nw&key=\(Net.apiKey)"
            downloadJson(url: url, completion: completion)
        }
    
    func getPlaylistItems(playlistId: String,completion: @escaping (Result<PlaylistItems,AFError>) ->()) {
        let url = "\(Net.api_youtube)playlistItems?part=snippet&part=id&maxResults=10&playlistId=\(playlistId)&key=\(Net.apiKey)"
        print( url)
        downloadJson(url: url, completion: completion)
    }
    
    
    /*
     
     statistics videos
     https://youtube.googleapis.com/youtube/v3/videos?part=statistics&part=snippet&id=RgrVS49pras&key=[YOUR_API_KEY]
     */
    
    
    
    
    
        fileprivate func downloadJson<T:Decodable>(url: String, completion:@escaping(Result<T,AFError>)-> Void) {
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: {
                JSONResponse in
                JSONResponse.timeoutInterval = 10
            }).validate(statusCode: 200..<201).responseDecodable(of: T.self) { responseDecodable in
                switch responseDecodable.result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}

