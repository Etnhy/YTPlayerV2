//
//  ContainerPresenter.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation
import Moya
import RxSwift


class ContainerPresenter: ContainerViewProtocol {

    

    
    var provider = MoyaProvider<YoutubeAPI>{ target in
        return Endpoint(url: "\(target.baseURL)\(target.path)",
                        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                        method: target.method, task: target.task, httpHeaderFields: target.headers)
    }
    
    
    weak var view: ContainerProtocol?
    var dispose = DisposeBag()
    var musicsId = [String]()
    var videosId = [String]()
    var musicData = [VideoItems]()
    var videoData = [VideoItems]()


    required init(view: ContainerProtocol) {
        self.view = view
        getPlaylistsId()
    }
     //MARK: - Playlists
    func getPlaylistsId() {
        provider.rx.requestWithProgress(.getPlaylists)
            .subscribe { event in
                switch event {
                case .next(let response):
                    if let result = try? response.response?.map(ChannelsPlaylists.self) {
                        for id in result.items {
                            self.musicsId.append(id.id)
                        }
                        self.view?.setPlaylistsNames(playlists:result)
                    }
                case .error(let error):
                    self.view?.showError(error: error.localizedDescription)
                case .completed:
                    self.getMusicItems(id: self.musicsId[0])
                    self.getVideoItems(id: self.musicsId[1])
                }
            }.disposed(by: dispose)
    }
     //MARK: - Music -
    func getMusicItems(id: String) {
        provider.rx.requestWithProgress(.getPlaylistItems(playlistId: id))
            .subscribe { event in
                switch event {
                case .next(let response):
                    if let result = try? response.response?.map(Playlist.self) {
                        for id in result.items {
                            self.videosId.append(id.snippet.resourceId?.videoId ?? "")
                        }
                        print(self.videosId)
                    }
                case .error(let error):
                    print(error)
                        
                case .completed:
                    for id in self.videosId {
                        self.getMusicData(videoId: id)
                    }
                }
            }.disposed(by: dispose)

    }
    
    func getMusicData(videoId: String) {
        provider.rx.requestWithProgress(.getVideoData(videoId: videoId))
            .subscribe { event in
                switch event {
                case .next(let response):
                    let result = try? response.response?.map(VideoData.self)
                    guard let result = result else { return }
                    self.musicData.append(contentsOf: result.items)
                    print(self.musicData.count)
                case .error(let error):
                    self.view?.showError(error: error.localizedDescription)
                case .completed:
                    if self.musicData.count >= 10 {
                        print("COMPLETED - ")
                        self.view?.setMusic(data: self.musicData)
                    }
                }
            }.disposed(by: dispose)
    }
     //MARK: - Videos
    func getVideoItems(id: String) {
        ///
    }
    
    
    func getVideoData(videoId: String) {
        ///
    }
}
