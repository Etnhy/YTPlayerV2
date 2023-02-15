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
        self.listenersCountsLAbel.text = "\(playerModel.viewsCount) прослушиваний."
        self.songNameLabel.text = playerModel.title

        DispatchQueue.main.async {
            //FIXME: вызывает две фиолетовые ошибки с потками
            ///// This method should not be called on the main thread as it may lead to UI unresponsiveness.
            
            self.yotubeWebView.load(withVideoId: playerModel.videoId)
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
        DispatchQueue.main.async {
            switch self.isPlayed {
            case true: self.yotubeWebView.playVideo()
            case false: self.yotubeWebView.pauseVideo()
            }
        }

        
    }
    
}


extension YTPLayerViewController: SendDataToPlayerDelegate {
    func toPlayer(data: PlayerModel) {
        self.configure(playerModel: data)
        
    }
    
    
}
