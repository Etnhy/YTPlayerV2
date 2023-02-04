//
//  ContainerPresenter.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation

class ContainerPresenter: ContainerViewProtocol {

    

    
    var playlistsID: PlaylistsList?

    weak var view: ContainerProtocol?
    var network: Network!
    
    required init(view: ContainerProtocol, network: Network) {
        self.view = view
        self.network = network
        getPlaylists()
//        getMusicPlaylist(playlistID: "PLNZta_SFvNjES8JspnOD2PIYV9X9CetcG")
    }
    
    
    func getPlaylists() {
        network.getPlaylists { result in
            switch result {
            case .success(let succes):
                self.view?.setPlaylistsUD(playlists: succes)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMusicPlaylist(playlistID: String) {
        //PLNZta_SFvNjES8JspnOD2PIYV9X9CetcG
        network.getPlaylistItems(playlistId: playlistID) { result in
            switch result {
            case .success(let succes):
                print(succes)
            case .failure(let error):
                print(error)
            }
        }
//        network.getPlaylistItems(playlistId: playlistID)
//            .observe(on: MainScheduler.instance)
//            .subscribe { playlistItems in
//                print(playlistItems)
//            } onError: { error in
//                print(error)
//            }
//            .disposed(by: dispose)
    }
    
}
