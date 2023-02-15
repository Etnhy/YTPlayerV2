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
    
    let youtubeQueue = DispatchQueue(label: "youtubePlay",qos: .userInitiated,attributes: .concurrent)
    
    var isPlayed: Bool = false
    
    private var playerModel: PlayerModel?
    
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
    
    fileprivate func configure(playerModel: PlayerModel) {
        DispatchQueue.main.async {
            self.listenersCountsLAbel.text = "\(playerModel.viewsCount) прослушиваний."
            self.songNameLabel.text = playerModel.title
        }
    }
    
     //MARK: -  Actions
    @objc fileprivate func playerPauseAction() {
        isPlayed.toggle()
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.image = isPlayed ? UIImage(systemName: "pause.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 34)) : UIImage(systemName: "play.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 34))
        buttonConfig.baseBackgroundColor = .clear
        buttonConfig.baseForegroundColor = .black
        playPauseButton.configuration = buttonConfig
        

    }
    
    @IBAction func playActionButton(_ sender: UIButton) {
        switch isPlayed {
        case true: self.yotubeWebView.playVideo()
        case false: self.yotubeWebView.pauseVideo()
        }
        
    }
    
}


extension YTPLayerViewController: SendDataToPlayerDelegate {
    func toPlayer(data: PlayerModel) {
        print("DATATAT --\(data)")
        self.playerModel = data
            guard let playerModel = self.playerModel else { return }
            self.configure(playerModel: playerModel)
            self.yotubeWebView.load(withVideoId: playerModel.videoId)
        
    }
    
    
}
