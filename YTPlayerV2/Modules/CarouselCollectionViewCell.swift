//
//  CarouselCollectionViewCell.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CarouselCollectionViewCell"
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var subscribersCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        settings()
    }
    fileprivate func settings () {
        authorImageView.layer.cornerRadius = 8
        self.layer.cornerRadius = 8

    }

}
