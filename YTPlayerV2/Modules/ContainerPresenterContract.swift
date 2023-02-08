//
//  ContainerPresenterContract.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation

protocol ContainerProtocol: AnyObject {
    func setTopChannels(channels: [ChannelsItems])
    func setPlaylistsUD(playlists: PlaylistsList?)
    func setMusicPlaylistItem(item: PlaylistItems?)
    
}
protocol ContainerViewProtocol: AnyObject  {
    init(view:ContainerProtocol)
    var playlistList: PlaylistsList? {get set}
    func getPlaylists()
    func getMusicPlaylist(playlistID: [String])
    func getTopChannels(arrayId: [String])
}
