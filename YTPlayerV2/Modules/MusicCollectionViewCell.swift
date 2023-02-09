//
//  MusicCollectionViewCell.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit
import AlamofireImage

class MusicCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MusicCollectionViewCell"
    
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicSongName: UILabel!
    @IBOutlet weak var listenersCountLabel: UILabel!
    
    public var songId: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settings()
    }
    fileprivate func settings() {
        self.musicImageView.backgroundColor = AppColors.backViewColor
        self.musicImageView.layer.cornerRadius = 8
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.blue.cgColor
        musicSongName.adjustsFontSizeToFitWidth = true
        musicSongName.minimumScaleFactor = 0.7
    }
    
    public func configure(with model: Item) {
        songId = model.id
        musicSongName.text = model.snippet.title
        
        guard let url = URL(string: "\(model.snippet.thumbnails.defaultThumbnails.url)") else { return }

        
        musicImageView.af.setImage(withURL: url)

        
    }

}
