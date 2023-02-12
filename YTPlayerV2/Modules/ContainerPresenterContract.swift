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
    func setVideos(data: [VideoItems]?)
    func setTopCHannels(data: [PlaylistItems])
}

protocol ContainerViewProtocol: AnyObject {
    init(view: ContainerProtocol)
    func getPlaylistsId()
    func getTopChannels(channels: [String])
    
}

protocol GetMusic: AnyObject {
    func getMusicItems(id: String)
    func getMusicData(videoId: String)

}

protocol GetVideo: AnyObject {
    func getVideoItems(id: String)
    func getVideoData(videoId: String)
}

