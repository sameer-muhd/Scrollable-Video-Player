//
//  ViewController.swift
//  Scrollable-Video-Player
//
//  Created by Mohammad Sameer on 14/08/23.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // Constraints values declared as constants
    private let minimumCellSpacing: CGFloat = .zero
    private let topBarHeight: CGFloat = 50
    private let bottomBarHeight: CGFloat = 56
    private let videoCellIdentifier = "VideoCell"
    
    private var isGlobalMute: Bool = false
    
    private var videoURLs: [String] = [
        "https://zshorts-dev.zee5.com/zshorts/file1/index.m3u8",
        "https://zshorts-dev.zee5.com/zshorts/file2/index.m3u8",
        "https://zshorts-dev.zee5.com/zshorts/file3/index.m3u8",
        "https://zshorts-dev.zee5.com/zshorts/file4/index.m3u8",
        "https://zshorts-dev.zee5.com/zshorts/file5/index.m3u8",]
    
    private lazy var topBar: UIView = {
        let view = UIView()
        view.backgroundColor = .surfacePrimary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .surfacePrimary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = minimumCellSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .surfacePrimary
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: videoCellIdentifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopBar()
        setupBottomBar()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomBar.topAnchor)
        ])
    }
    
    private func setupTopBar() {
        view.addSubview(topBar)
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: topBarHeight)
        ])
    }
    
    private func setupBottomBar() {
        view.addSubview(bottomBar)
        
        NSLayoutConstraint.activate([
            bottomBar.heightAnchor.constraint(equalToConstant: bottomBarHeight),
            bottomBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomBar.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, VideoCellDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCellIdentifier, for: indexPath) as? VideoCollectionViewCell else {
            return VideoCollectionViewCell()
        }
        
        cell.globalMuteStateDelegate = self
        let videoURL = videoURLs[indexPath.item]
        cell.configureVideoPlayer(with: videoURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoCollectionViewCell {
            videoCell.startVideoPlayback(with: isGlobalMute)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoCollectionViewCell {
            videoCell.pauseVideoPlayback()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func didToggleMuteState(for cell: VideoCollectionViewCell) {
        // Update global mute state, so that whenever next cells is displayed, they use this mute state
        isGlobalMute.toggle()
    }
}
