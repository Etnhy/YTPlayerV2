//
//  Network.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation
import Alamofire
import RxSwift

///https://www.googleapis.com/youtube/v3
//  'https://youtube.googleapis.com/youtube/v3/playlists?channelId=UCyxvZQw2Os4LvdPkNqSB8nw&key=[YOUR_API_KEY]' \
// https://youtube.googleapis.com/youtube/v3/playlistItems?maxResults=10&playlistId=PLNZta_SFvNjES8JspnOD2PIYV9X9CetcG&key=AIzaSyBhxXFXV7LH2TpcWMsn4Z2qb0ZWt-xHYt0

class Network {
    static let shared = Network()
    
    func getPlaylists () -> Observable<PlaylistsList> {
        let url = "\(Net.api_youtube)playlists?part=snippet&channelId=UCyxvZQw2Os4LvdPkNqSB8nw&key=\(Net.apiKey)"
        print(url)
       return requestRx(url)
    }
    
    func getPlaylistItems (playlistId: String) -> Observable<PlaylistItems> {
        let url = "\(Net.api_youtube)playlistItems?maxResults=10&playlistId=\(playlistId)&key=\(Net.apiKey)"
        print(url)

        return requestRx(url)
    }
    
    fileprivate func requestRx<T:Codable>(_ urlConvertible:String) -> Observable<T>{
        return Observable<T>.create { observer  in
            let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
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



//    func testreq() {
//        let url = "\(Net.api_youtube)playlists?channelId=UCyxvZQw2Os4LvdPkNqSB8nw&key=\(Net.apiKey)"
//        AF.request(url).responseJSON { response in
//            switch response.result {
//            case .success(let result):
//                print(url)
//                print(result)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
