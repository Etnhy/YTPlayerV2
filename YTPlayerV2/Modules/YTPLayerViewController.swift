//
//  YTPLayerViewController.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit
import SnapKit
import WebKit
import RxSwift
import youtube_ios_player_helper

class YTPLayerViewController: UIViewController {
    static let identifier = "YTPLayerViewController"
    
    
    @IBOutlet weak var songProgress: UIProgressView!
    @IBOutlet weak var yotubeWebView: YTPlayerView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var listenersCountsLAbel: UILabel!
    @IBOutlet weak var backwardButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var showHideButton: UIButton!
        
    var isPlayed: Bool = false

    var playerData = [VideoItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings()
    }
    
    fileprivate func settings() {
        self.view.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: self.view.frame.width,height: 700))
        }
        self.view.layer.cornerRadius = 40
        self.yotubeWebView.layer.cornerRadius = 12
        
        self.showHideButton.layer.cornerRadius = 40
        self.playPauseButton.addTarget(self, action: #selector(playerPauseAction), for: .touchUpInside)
    }
    
    fileprivate func configure(id: Int,playerModel: [VideoItems]) {
        self.listenersCountsLAbel.text = "\(playerModel[id].statistics.viewCount ?? "views error") прослушиваний."
        self.songNameLabel.text = playerModel[id].snippet.title

        DispatchQueue.main.async {
            self.yotubeWebView.load(withVideoId: playerModel[id].id)
        }

    }
    
     //MARK: -  Actions
    
    
    @IBAction func backwardSong(_ sender: UIButton) {
    }
    
    @IBAction func forwardSong(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func playerPauseAction() {

        isPlayed.toggle()
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.image = isPlayed ? UIImage(systemName: "pause.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 34)) : UIImage(systemName: "play.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 34))
        buttonConfig.baseBackgroundColor = .clear
        buttonConfig.baseForegroundColor = .black
        playPauseButton.configuration = buttonConfig
    }
    
    @IBAction func playActionButton(_ sender: UIButton) {
        DispatchQueue.main.async {
            switch self.isPlayed {
            case true: self.yotubeWebView.playVideo()
            case false: self.yotubeWebView.pauseVideo()
            }
        }
    }
    
}

 //MARK: - YTPLayerViewController: SendDataToPlayerDelegate
extension YTPLayerViewController: SendDataToPlayerDelegate {
    func arrayToPlayer(indexPath: Int,data: [VideoItems]) {
        self.playerData = data
        self.configure(id: indexPath, playerModel: data)
    }
}
