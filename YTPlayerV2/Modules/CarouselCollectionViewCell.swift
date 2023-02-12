//
//  CarouselCollectionViewCell.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit
import Alamofire
import SkeletonView

class CarouselCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CarouselCollectionViewCell"
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var subscribersCountLabel: UILabel!

    var id: String = ""
    
    let strokeTextAttributes: [NSAttributedString.Key : Any] = [
        .strokeColor : UIColor.black,
        .foregroundColor : UIColor.white,
        .strokeWidth : -3.0,
        ]

    override func awakeFromNib() {
        super.awakeFromNib()
        settings()
        self.authorImageView.isSkeletonable = true
    }
    
    fileprivate func settings () {
        self.authorImageView.backgroundColor = AppColors.backViewColor
        authorImageView.layer.cornerRadius = 8
        self.subscribersCountLabel.layer.cornerRadius = 10
        
        self.layer.cornerRadius = 8

    }

    public func configure(model: PlaylistItems) {
        guard let subs = model.statistics?.subscriberCount else { return }
        self.authorNameLabel.text = model.snippet.title
        self.subscribersCountLabel.text = "subs: \(subs)"
        guard let urlImage = URL(string: "\(model.snippet.thumbnails.high.url)") else { return }

            self.authorImageView.af.setImage(withURL: urlImage)
        
    }
}
