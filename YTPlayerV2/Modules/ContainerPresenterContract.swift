//
//  ContainerPresenterContract.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 04.02.2023.
//

import Foundation

 //MARK: - protocol ContainerProtocol
protocol ContainerProtocol: AnyObject {
    func showError(error: String)
    func setPlaylistsNames(playlists: ChannelsPlaylists)
    func setMusic(data: [VideoItems]?)
    func setVideos(data: [VideoItems]?)
    func setTopCHannels(data: [PlaylistItems])
}

 //MARK: - protocol ContainerViewProtocol
protocol ContainerViewProtocol: AnyObject {
    init(view: ContainerProtocol)
    func getPlaylistsId()
    func getTopChannels(channels: [String])
    
}

 //MARK: - protocol GetMusic
protocol GetMusic: AnyObject {
    func getMusicItems(id: String)
    func getMusicData(videoId: String)

}

 //MARK: - protocol GetVideo
protocol GetVideo: AnyObject {
    func getVideoItems(id: String)
    func getVideoData(videoId: String)
}

 //MARK: - send to player delegate
protocol SendDataToPlayerDelegate: AnyObject {
    func arrayToPlayer(indexPath: Int,data: [VideoItems])
}
