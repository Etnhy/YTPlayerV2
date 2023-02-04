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


class Network {
    static let shared = Network()
    
    func getPlaylists () -> Observable<PlaylistsList> {
        let url = "\(Net.api_youtube)playlists?channelId=UCyxvZQw2Os4LvdPkNqSB8nw&key=\(Net.apiKey)"
       return requestRx(url)
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
