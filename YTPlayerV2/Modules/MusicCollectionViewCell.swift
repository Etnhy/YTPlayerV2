//
//  MusicCollectionViewCell.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "MusicCollectionViewCell"
    
    @IBOutlet weak var musicImageView: UIImageView!
    @IBOutlet weak var musicSongName: UILabel!
    @IBOutlet weak var listenersCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .yellow
        // Initialization code
    }

}
