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

    }
}
