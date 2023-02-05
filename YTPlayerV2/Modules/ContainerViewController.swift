//
//  ContainerViewController.swift
//  YTPlayerV2
//
//  Created by Евгений Маглена on 03.02.2023.
//

import UIKit
import SnapKit
import SkeletonView

 //MARK: - AIzaSyBhxXFXV7LH2TpcWMsn4Z2qb0ZWt-xHYt0
class ContainerViewController: UIViewController {
    static let identifier = "ContainerViewController"
    
    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var musicPlaylistCollectionView: UICollectionView!
    @IBOutlet weak var videoPlaylistCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!


    @IBOutlet weak var musicPlaylistLabel: UILabel!
    @IBOutlet weak var videoPlaylistLabel: UILabel!
    
    let playerViewController = UIStoryboard(name: YTPLayerViewController.identifier, bundle: nil).instantiateViewController(withIdentifier: YTPLayerViewController.identifier) as! YTPLayerViewController

    
    var presenter : ContainerViewProtocol?
    var network = Network()
    var playlistsIDs: PlaylistsList?
    var playerShow: Bool = false
    var newOffsetX: CGFloat = 0.0
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCVs()
        registerCell()
        setupYTPlayer()
    }

    
    fileprivate func setupCVs() {
        self.view.backgroundColor = AppColors.mainAppColor
        self.presenter = ContainerPresenter(view: self, network: network)
        carouselCollectionView.backgroundColor = .clear
        musicPlaylistCollectionView.backgroundColor = .clear
        videoPlaylistCollectionView.backgroundColor = .clear
        
        
    }
    
    fileprivate func setupYTPlayer() {
        self.addChild(playerViewController)
        self.view.addSubview(playerViewController.view)
        self.playerViewController.showHideButton.addTarget(self, action: #selector(showHidePlayerAction), for: .touchUpInside)
        playerViewController.view.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.snp.bottom).offset(650)
            make.leading.trailing.equalTo(self.view)
            
        }
    }
    
    fileprivate func registerCell() {
        self.carouselCollectionView.register(UINib(nibName: CarouselCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CarouselCollectionViewCell.reuseIdentifier)
        
        self.musicPlaylistCollectionView.register(UINib(nibName: MusicCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MusicCollectionViewCell.reuseIdentifier)
        
        self.videoPlaylistCollectionView.register(UINib(nibName: VideoCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: VideoCollectionViewCell.reuseIdentifier)
        
        
        
    }
    
    //MARK: - actions
    @objc private func showHidePlayerAction() {
        playerShow.toggle()
        UIView.animate(withDuration: 0.7, delay: 0.05, options: [.curveEaseOut]) { [self] in
            switch playerShow {
            case false:
                self.playerViewController.view.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view).offset(playerViewController.view.frame.height - 50)
                    make.leading.trailing.equalTo(self.view)
                }
            case true:
                playerViewController.view.snp.updateConstraints { make in
                    make.bottom.equalTo(self.view)
                    make.leading.trailing.equalTo(self.view)
                }
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension ContainerViewController: UICollectionViewDataSource, SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        switch skeletonView {
        case carouselCollectionView: return CarouselCollectionViewCell.reuseIdentifier
        default: return "cell"
            
        }
    }
    
    
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
    
    fileprivate func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
}

 //MARK: - (extension) UICollectionViewDelegateFlowLayout
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
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }

}


extension ContainerViewController: ContainerProtocol {
    func setPlaylistsUD(playlists: PlaylistsList) {
        self.playlistsIDs = playlists
//        print(self.playlistsIDs)
        self.musicPlaylistLabel.text = playlists.items[0].snippet.title
        self.videoPlaylistLabel.text = playlists.items[1].snippet.title
            }
    
    
}
