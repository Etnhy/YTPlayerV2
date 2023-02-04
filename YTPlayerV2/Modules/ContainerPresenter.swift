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
    }
    
    
    func getPlaylists() {
        network.getPlaylists()
            .observe(on: MainScheduler.instance)
            .subscribe { playlists in
                self.playlistsID = playlists
                self.view?.setPlaylistsUD(playlists: playlists)
            } onError: { error in
                print(error)
            }
            .disposed(by: dispose)
    }
    
    
}
