//
//  ContainerPresenterContract.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation

protocol ContainerProtocol: AnyObject {
    func setPlaylistsUD(playlists: PlaylistsList)
}
protocol ContainerViewProtocol: AnyObject  {
    init(view:ContainerProtocol,network: Network)
    var playlistsID: PlaylistsList? {get set}
    func getPlaylists()
}
