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
    
    
    var playlistList: PlaylistsList?
    var musicPlaylist: PlaylistItems?
    var playlistId = [String]()
    
    weak var view: ContainerProtocol?
    
    required init(view: ContainerProtocol) {
        self.view = view
        
//        getPlaylists()
        getTopChannels(arrayId: Net.channelsIDs)
    }
    
    
    func getPlaylists() {
        provider.request(.getPlaylists) { result in
            switch result {
            case .success(let response):
                let json = try? response.map(PlaylistsList.self)
                guard let json = json else { return }
                self.view?.setPlaylistsUD(playlists: json)
                for id in json.items {
                    self.playlistId.append(id.id)
                }
                
                self.getMusicPlaylist(playlistID: self.playlistId)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    func getMusicPlaylist(playlistID: [String]) {
        provider.request(.getPlaylistItems(playlistId: playlistID[0])) { result in
            switch result {
            case .success(let response):
                let json = try? response.map(PlaylistItems.self)
                self.view?.setMusicPlaylistItem(item: json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTopChannels(arrayId: [String]) {
        var channelsData = [TopChannelsModel]()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            for id in arrayId {
                self.provider.request(.getTopChannels(channelId: id)) { result in
                    switch result {
                    case .success(let response):
                        let json = try? response.map(TopChannelsModel.self)
                        guard let json = json else { return }
//                        print(json)
        //                self.view?.setMusicPlaylistItem(item: json)

                        channelsData.append(json)
                        if channelsData.count == Net.channelsIDs.count {
//                            print(channelsData.count)
                            self.view?.setTopChannels(channels: channelsData)

                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }





    }
}

