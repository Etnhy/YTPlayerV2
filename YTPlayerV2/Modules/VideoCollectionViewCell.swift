//
//  VideoCollectionViewCell.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "VideoCollectionViewCell"

    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var listenersCounter: UILabel!
    var songId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        settings()
    }

    fileprivate func settings () {
        self.videoImageView.backgroundColor = AppColors.backViewColor
        self.videoImageView.layer.cornerRadius = 8
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.blue.cgColor
        videoNameLabel.adjustsFontSizeToFitWidth = true
        videoNameLabel.minimumScaleFactor = 0.7

    }
    
    public func configure(with model: VideoItems?) {
        guard let model = model else { return }
        guard let views = model.statistics.viewCount else { return }

        self.songId = model.id
        videoNameLabel.text = model.snippet.title
        listenersCounter.text = "\(views) views"
        
        guard let urlImage = URL(string: "\(model.snippet.thumbnails.high.url)") else { return }
        videoImageView.af.setImage(withURL: urlImage)
        
    }
}
