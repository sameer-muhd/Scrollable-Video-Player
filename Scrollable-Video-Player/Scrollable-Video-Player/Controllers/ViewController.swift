//
//  ViewController.swift
//  Scrollable-Video-Player
//
//  Created by Mohammad Sameer on 14/08/23.
//

import UIKit
import CoreData
import AVFoundation

class ViewController: UIViewController {
    // Constraints values declared as constants
    private let minimumCellSpacing: CGFloat = .zero
    private let topBarHeight: CGFloat = 50
    private let bottomBarHeight: CGFloat = 56
    private let videoCellIdentifier = "VideoCell"
    
    private let backButtonImg = "ChevronLeft"
    private let volumeLoudImg = "VolumeLoud"
    private let volumeMuteImg = "VolumeMute"
    
    private let topComponentsOffsetFromTop: CGFloat = 16
    private let topComponentOffsetFromLeading: CGFloat = 16
    private let topComponentsOffsetFromTrailing: CGFloat = -24
    
    private let topComponentsWidth: CGFloat = 30
    private let topComponentsHeight: CGFloat = 30
    
    private var isGlobalMute: Bool = false
    
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
    
    // Backbutton and volume button
    private lazy var backButton: UIButton = {
        let backBtn = UIButton(type: .custom)
        
        backBtn.setImage(UIImage(named: backButtonImg), for: .normal)
        backBtn.imageView?.contentMode = .scaleToFill
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return backBtn
    }()
    
    private lazy var volumeButton: UIButton = {
        let volumeBtn = UIButton(type: .custom)
        
        volumeBtn.setImage(UIImage(named: volumeLoudImg), for: .normal)
        volumeBtn.setImage(UIImage(named: volumeMuteImg), for: .selected)
        volumeBtn.imageView?.contentMode = .scaleToFill
        volumeBtn.adjustsImageWhenHighlighted = false
        volumeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return volumeBtn
    }()

    private let networkManager = NetworkManager.shared
    private var assetDetails: [Asset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataFromAPI()
        
        setupTopBar()
        setupBottomBar()
        setupCollectionView()
        addTopComponents()
        
        addVolumeButtonAction()
    }
    
    private func fetchDataFromAPI() {
        networkManager.fetchVideos { [weak self] (assets, error) in
            if let error = error {
                print("Error fetching videos: \(error)")
                return
            }

            if let assets = assets {
                DispatchQueue.main.async {
                    self?.assetDetails = assets
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    private func fetchDataFromAPI() {
        networkManager.fetchVideos { [weak self] (assets, error) in
            if let error = error {
                print("Error fetching videos: \(error)")
                return
            }

            if let assets = assets {
                DispatchQueue.main.async {
                    self?.assetDetails = assets
                    self?.collectionView.reloadData()
                }
            }
        }
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
    
    private func addTopComponents() {
        view.addSubview(backButton)
        view.addSubview(volumeButton)
        
        NSLayoutConstraint.activate([
            // Back button constraints
            backButton.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: topComponentsOffsetFromTop),
            backButton.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: topComponentOffsetFromLeading),
            backButton.widthAnchor.constraint(equalToConstant: topComponentsWidth),
            backButton.heightAnchor.constraint(equalToConstant: topComponentsHeight),
            
            // Volume Button constraints
            volumeButton.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: topComponentsOffsetFromTop),
            volumeButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: topComponentsOffsetFromTrailing),
            volumeButton.widthAnchor.constraint(equalToConstant: topComponentsWidth),
            volumeButton.heightAnchor.constraint(equalToConstant: topComponentsHeight),
        ])
    }
    
    private func addVolumeButtonAction() {
        volumeButton.addTarget(self, action: #selector(volumeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func volumeButtonTapped() {
        // Check the current state of button and toggle it
        if !volumeButton.isSelected {
            isGlobalMute = true
            volumeButton.isSelected = true
        } else {
            isGlobalMute = false
            volumeButton.isSelected = false
        }
        
        // Send notification to cell to update the mute state
        NotificationCenter.default.post(name: Notification.Name("MuteStateChanged"), object: nil, userInfo: ["isMuted": isGlobalMute])
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCellIdentifier, for: indexPath) as? VideoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.globalMuteStateDelegate = self
        let currentAsset = assetDetails[indexPath.item]
        let videoID = currentAsset.videoDetails.id
        cell.configureVideoPlayer(with: currentAsset, watchListState: isAddedToWatchList(videoID: videoID))
        
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
    
    func didToggleWatchListState(for cell: VideoCollectionViewCell, videoID: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let watchListEntity = NSEntityDescription.entity(forEntityName: "WatchList", in: managedContext)!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WatchList")
        fetchRequest.predicate = NSPredicate(format: "videoID == %@", videoID)

        do {
            let matchingVideos = try managedContext.fetch(fetchRequest)
            if let video = matchingVideos.first {
                // The video with the specified videoID is in Core Data
                // Since it already in Core Data, we removed it and change watchlist button image to default
                
                managedContext.delete(video as! NSManagedObject)
                try managedContext.save()
                
                cell.updateWatchListButtonState(isVideoAdded: false)
                print("Removed video with ID: \(videoID)")
            } else {
                // The video is not in Core Data
                // Since it is not in Core Data, we add it and change watchlist button image to added
                
                let video = NSManagedObject(entity: watchListEntity, insertInto: managedContext)
                video.setValue(videoID, forKey: "videoID")
                try managedContext.save()
                
                cell.updateWatchListButtonState(isVideoAdded: true)
                print("Added video with ID: \(videoID)")
            }
        } catch {
            print("Error in Core Data: \(error)")
        }
    }
    
    private func isAddedToWatchList(videoID: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WatchList")
        fetchRequest.predicate = NSPredicate(format: "videoID == %@", videoID)

        do {
            let matchingVideos = try managedContext.fetch(fetchRequest)
            if matchingVideos.first != nil {
                return true
            } else {
                return false
            }
        } catch {
            print("Error in Core Data: \(error)")
        }
        
        return false
    }
}
