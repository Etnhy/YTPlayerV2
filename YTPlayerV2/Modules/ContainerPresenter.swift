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
    var playlistsId = [String]()
    
    var musicItemsId = [String]()
    var videoItemsId = [String]()
    
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
                            self.playlistsId.append(id.id)
                        }
                        self.view?.setPlaylistsNames(playlists:result)
                    }
                case .error(let error):
                    self.view?.showError(error: error.localizedDescription)
                case .completed:
                    self.getMusicItems(id: self.playlistsId[0])
                    self.getVideoItems(id: self.playlistsId[1])
                }
            }.disposed(by: dispose)
    }
    
}

//MARK: extension - GetMusic
extension ContainerPresenter: GetMusic {
   func getMusicItems(id: String) {
       provider.rx.requestWithProgress(.getPlaylistItems(playlistId: id))
           .subscribe { event in
               switch event {
               case .next(let response):
                   if let result = try? response.response?.map(Playlist.self) {
                       for id in result.items {
                           self.musicItemsId.append(id.snippet.resourceId?.videoId ?? "")
                       }
                       print(self.musicItemsId)
                   }
               case .error(let error):
                   print(error)
                       
               case .completed:
                   for id in self.musicItemsId {
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
               case .error(let error):
                   self.view?.showError(error: error.localizedDescription)
               case .completed:
                   if self.musicData.count >= 10 {
                       self.view?.setMusic(data: self.musicData)
                   }
               }
           }.disposed(by: dispose)
   }

}

//MARK: extension - GetVideo

extension ContainerPresenter: GetVideo {
   
   func getVideoData(videoId: String) {
       provider.rx.requestWithProgress(.getVideoData(videoId: videoId))
           .subscribe { event in
               switch event {
               case .next(let response):
                   let result = try? response.response?.map(VideoData.self)
                   guard let result = result else { return }
                   self.videoData.append(contentsOf: result.items)
               case .error(let error):
                   self.view?.showError(error: error.localizedDescription)
               case .completed:
                   if self.videoData.count >= 10 {
                       self.view?.setVideos(data: self.videoData)
                   }
               }
           }.disposed(by: dispose)

   }

    func getVideoItems(id: String) {
        provider.rx.requestWithProgress(.getPlaylistItems(playlistId: id))
            .subscribe { event in
                switch event {
                case .next(let response):
                    if let result = try? response.response?.map(Playlist.self) {
                        for id in result.items {
                            self.videoItemsId.append(id.snippet.resourceId?.videoId ?? "")
                        }
                    }
                case .error(let error):
                    self.view?.showError(error: error.localizedDescription)
                case .completed:
                    print("completed - getVideoItems")
                    for id in self.videoItemsId {
                        self.getVideoData(videoId: id)
                    }                }
            }.disposed(by: dispose)
    }

}
