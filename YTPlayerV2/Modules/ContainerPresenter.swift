//
//  ContainerPresenter.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation

class ContainerPresenter: ContainerViewProtocol {

    var playlistList: PlaylistsList?
    var musicPlaylist: PlaylistItems?
    var playlistId = [String]()
    var network: Network!

    weak var view: ContainerProtocol?
    
    required init(view: ContainerProtocol, network: Network) {
        self.view = view
        self.network = network
        
        getPlaylists()
//        getMusicPlaylist(playlistID: self.playlistId)
    }


    func getPlaylists() {
            network.getPlaylists { result in
                switch result {
                case .success(let succes):
                    self.playlistList = succes
                    self.view?.setPlaylistsUD(playlists: self.playlistList)
                    for id in succes.items {
                        self.playlistId.append(id.id)
                    }
                    
                    self.getMusicPlaylist(playlistID: self.playlistId)
//                    print(self.playlistId)
                case .failure(let error):
                    print(error)
                }
                
            }
        }

    
    
    func getMusicPlaylist(playlistID: [String]) {
        //PLNZta_SFvNjES8JspnOD2PIYV9X9CetcG
//        print(playlistID.count)
        network.getPlaylistItems(playlistId: playlistID[0]) { result in
            switch result {
            case .success(let succes):
//                print(succes)
                self.view?.setMusicPlaylistItem(item: succes)
            case .failure(let error):
                print(error)
            }
        }

    }
    
}

