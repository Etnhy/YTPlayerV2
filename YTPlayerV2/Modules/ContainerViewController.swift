//
//  ContainerViewController.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit
import SnapKit

class ContainerViewController: UIViewController {
    static let identifier = "ContainerViewController"
    
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var musicPlaylistCollectionView: UICollectionView!
    @IBOutlet weak var videoPlaylistCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCarouselCV()
        registerCell()
    }
    
    
    fileprivate func setupCarouselCV() {
        carouselCollectionView.layer.cornerRadius = 10
        
        
        
    }
    
    fileprivate func registerCell() {
        self.carouselCollectionView.register(UINib(nibName: CarouselCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier)
        
        self.musicPlaylistCollectionView.register(UINib(nibName: MusicCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MusicCollectionViewCell.reuseIdentifier)
        
        self.videoPlaylistCollectionView.register(UINib(nibName: VideoCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: VideoCollectionViewCell.reuseIdentifier)
        
        
        
    }
    
}

extension ContainerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case carouselCollectionView     : return 4
        case musicPlaylistCollectionView: return 10
        case videoPlaylistCollectionView: return 10
        default : return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case carouselCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier, for: indexPath) as? CarouselCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case musicPlaylistCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.reuseIdentifier, for: indexPath) as? MusicCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case videoPlaylistCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseIdentifier, for: indexPath) as? VideoCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        default: return UICollectionViewCell()
        }
        
    }
}


extension ContainerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case carouselCollectionView:
            return CGSize(width: self.carouselCollectionView.frame.width, height: self.carouselCollectionView.frame.height)
            
        case musicPlaylistCollectionView:
            return CGSize(width: 170, height: self.musicPlaylistCollectionView.frame.height)
        case videoPlaylistCollectionView :
            return CGSize(width: 200, height: self.videoPlaylistCollectionView.frame.height)
        default: return CGSize(width: 100, height: 100)
            
        }
        
        
    }
}


