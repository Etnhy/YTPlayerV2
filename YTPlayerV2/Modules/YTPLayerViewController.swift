//
//  YTPLayerViewController.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit
import WebKit
class YTPLayerViewController: UIViewController {
    static let identifier = "YTPLayerViewController"
    
    
    @IBOutlet weak var songProgress: UIProgressView!
    @IBOutlet weak var yotubeWebView: WKWebView!
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
    
    @objc fileprivate func playerPauseAction() {
        isPlayed.toggle()
       var buttonConfig = UIButton.Configuration.filled()
       buttonConfig.image = isPlayed ? UIImage(systemName: "pause.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 34)) : UIImage(systemName: "play.fill")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 34))
       buttonConfig.baseBackgroundColor = .clear
        buttonConfig.baseForegroundColor = .black
       playPauseButton.configuration = buttonConfig
    }
    }


