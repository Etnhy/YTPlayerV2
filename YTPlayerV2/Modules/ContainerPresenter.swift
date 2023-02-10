//
//  ContainerPresenter.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation
import Moya


class ContainerPresenter: ContainerViewProtocol {

    
    var provider = MoyaProvider<YoutubeAPI>{ target in
        return Endpoint(url: "\(target.baseURL)\(target.path)",
                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                        method: target.method, task: target.task, httpHeaderFields: target.headers)
    }
    
    
    weak var view: ContainerProtocol?

    var musicsId = [String]()
    var videosId = [String]()
    var videoData = [VideoData]()

    required init(view: ContainerProtocol) {
        self.view = view
        getPlaylistsId()
    }
    //// тянем плейлисты с канала
    func getPlaylistsId() {
        provider.request(.getPlaylists) { result in
            switch result {
            case .success(let response):
                if let result = try? response.map(ChannelsPlaylists.self) {
                    for id in result.items {
                        self.musicsId.append(id.id)
                    }
//                    print(self.musicsId)
                    self.view?.setPlaylistsNames(playlists: result)
                    self.getPlaylistItems(id: self.musicsId[0])
                    
                }
            case .failure(let error):
                print(error)
                self.view?.showError(error: error.localizedDescription)
            }
        }
    }
    
    func getPlaylistItems(id: String) {
        provider.request(.getPlaylistItems(playlistId: id)) { result in
            switch result {
            case .success(let response):

                if let result = try? response.map(Playlist.self) {
                    for id in result.items {
                        self.videosId.append(id.snippet.resourceId?.videoId ?? "")
                    }
                    print(self.videosId)
//                    print(result)
                    for id in self.videosId {
                        self.getVideoData(videoId: id)
                    }
                }
            case .failure(let error):
                print(error)
                self.view?.showError(error: error.localizedDescription)
            }
        }
    }
    func getVideoData(videoId: String) {
        DispatchQueue.main.async {
            
            self.provider.request(.getVideoData(videoId: videoId)) { result in
                switch result {
                case .success(let response):
                    let result = try? response.map(VideoData.self)
                    guard let result = result else { return }
                    self.videoData.append(result)
                    print(self.videoData.count)
                    if self.videoData.count >= 10 {
                        print("COMPLETED")
                    }
                    
                case .failure(let error):
                    self.view?.showError(error: error.localizedDescription)
                }
            }
        }

    }
    

    

    
    
}
