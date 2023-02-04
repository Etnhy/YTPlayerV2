//
//  ContainerPresenter.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation
import RxSwift

class ContainerPresenter: ContainerViewProtocol {

    

    
    var playlistsID: PlaylistsList?

    weak var view: ContainerProtocol?
    var network: Network!
    
    var dispose = DisposeBag()
    required init(view: ContainerProtocol, network: Network) {
        self.view = view
        self.network = network
        getPlaylists()
//        getMusicPlaylist(playlistID: "PLNZta_SFvNjES8JspnOD2PIYV9X9CetcG")
    }
    
    
    func getPlaylists() {
        network.getPlaylists()
            .observe(on: MainScheduler.instance)
            .subscribe { playlists in
                self.playlistsID = playlists
                self.view?.setPlaylistsUD(playlists: playlists)
                print(playlists)
            } onError: { error in
                print(error)
            }
            .disposed(by: dispose)
    }
    
    func getMusicPlaylist(playlistID: String) {
        //PLNZta_SFvNjES8JspnOD2PIYV9X9CetcG
        network.getPlaylistItems(playlistId: playlistID)
            .observe(on: MainScheduler.instance)
            .subscribe { playlistItems in
                print(playlistItems)
            } onError: { error in
                print(error)
            }
            .disposed(by: dispose)
    }
    
}
