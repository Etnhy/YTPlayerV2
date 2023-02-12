//
//  ContainerPresenterContract.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation

protocol ContainerProtocol: AnyObject {
    func showError(error: String)
    func setPlaylistsNames(playlists: ChannelsPlaylists)
    func setMusic(data: [VideoItems]?)
}

protocol ContainerViewProtocol: AnyObject {
    init(view: ContainerProtocol)
    func getPlaylistsId()
    
    func getMusicItems(id: String)
    func getMusicData(videoId: String)
    
    func getVideoItems(id: String)
    func getVideoData(videoId: String)
}
