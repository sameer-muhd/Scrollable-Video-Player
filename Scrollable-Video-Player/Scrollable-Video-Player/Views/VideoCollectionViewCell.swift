//
//  VideoCollectionViewCell.swift
//  Scrollable-Video-Player
//
//  Created by Mohammad Sameer on 14/08/23.
//

import UIKit
import AVFoundation

// Protocol delegate method used to set global mute/unmute state of cells
protocol VideoCellDelegate: AnyObject {
    func didToggleWatchListState(for cell: VideoCollectionViewCell, videoID: String)
}

class VideoCollectionViewCell: UICollectionViewCell {
    // Image assets declared as constants
    private let playButtonImg = "playButton"
    private let addToListImg = "addToList"
    private let addToListSelectedImg = "addToListSelected"
    private let shareButtonImg = "shareButton"
    private let playButtonVideoImg = "playButtonVideo"

    // Options and title labels declared as constants
    private let watchButtonLabelText = "Watch"
    private let addToPlaylistButtonLabelText = "My List"
    private let shareButtonLabelText = "Share"
    private let titleText = "Spiderman arrives to rescue the town from Venom."
    private let subtitleText = "Spiderman: Homecoming • Action • U/A 7+"

    // All labels font size and weight declared as constants
    private let optionsLabelSize: CGFloat = 12
    private let optionsLabelWeight = UIFont.Weight.medium

    private let titleLabelSize: CGFloat = 18
    private let titleLabelWeight = UIFont.Weight.bold

    private let subtitleLabelSize: CGFloat = 14
    private let subtitleLabelWeight = UIFont.Weight.regular
    
    // Constraints declared as constants
    private let progressBarHeight: CGFloat = 4
    private let videoPlayButtonWidth: CGFloat = 60
    private let videoPlayButtonHeight: CGFloat = 60
    
    private let optionsContainerOffsetFromBottom: CGFloat = -24
    private let optionsContainerOffsetFromTrailing: CGFloat = -24
    private let optionsContainerWidth: CGFloat = 42
    private let optionsContainerHeight: CGFloat = 206
    
    private let optionsIconWidth: CGFloat = 40
    private let optionsIconHeight: CGFloat = 40
    private let optionsIntraGap: CGFloat = 16
    
    private let optionsLabelWidth: CGFloat = 42
    private let optionsLabelHeight: CGFloat = 20
    
    private let textContainerOffsetFromTrailing: CGFloat = 24
    private let textContainerHeight: CGFloat = 102
    
    private let titleLabelOffsetFromTop: CGFloat = 16
    private let titleLabelOffsetFromLeading: CGFloat = 24
    private let titleLabelHeight: CGFloat = 42
    
    private let subtitleLabelOffsetFromLeading: CGFloat = 24
    private let subtitleLabelHeight: CGFloat = 16
    
    // Background views and layers - Player container, AV Player, player layer, play button, progress bar and gradient layer
    private lazy var playerContainerView: UIView = {
        let playerView = UIView()
        playerView.backgroundColor = .clear
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        return playerView
    }()
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    private lazy var playButton: UIButton = {
        var playBtn = UIButton(type: .custom)
        playBtn.setImage(UIImage(named: playButtonVideoImg), for: .normal)
        playBtn.adjustsImageWhenHighlighted = false
        playBtn.isHidden = true
        
        return playBtn
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        
        progressView.progressTintColor = .progressFilled
        progressView.trackTintColor =  .progressEmpty
        
        return progressView
    }()
    
    private var progressUpdateTimer: Timer?
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0.0, 0.5]
        
        return gradientLayer
    }()
    
    // Options views and labels - Options container, 3 buttons and their labels
    private lazy var optionsContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private lazy var watchButton: UIButton = {
        let watchBtn = UIButton(type: .custom)
        
        watchBtn.setImage(UIImage(named: playButtonImg), for: .normal)
        watchBtn.adjustsImageWhenHighlighted = false
        watchBtn.imageView?.contentMode = .scaleToFill
        watchBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return watchBtn
    }()
    
    private lazy var watchButtonLabel: UILabel = {
        let label = UILabel()
        
        label.text = watchButtonLabelText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.notoSans(size: optionsLabelSize, weight: optionsLabelWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var addToPlaylistButton: UIButton = {
        let addBtn = UIButton(type: .custom)
        
        addBtn.setImage(UIImage(named: addToListImg), for: .normal)
        addBtn.setImage(UIImage(named: addToListSelectedImg), for: .selected)
        addBtn.adjustsImageWhenHighlighted = false
        addBtn.imageView?.contentMode = .scaleToFill
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return addBtn
    }()
    
    private var videoID: String?
    weak var watchListDelegate: VideoCellDelegate?
    
    private lazy var addToPlaylistButtonLabel: UILabel = {
        let label = UILabel()
        
        label.text = addToPlaylistButtonLabelText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.notoSans(size: optionsLabelSize, weight: optionsLabelWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var shareButton: UIButton = {
        let shareBtn = UIButton(type: .custom)
        
        shareBtn.setImage(UIImage(named: shareButtonImg), for: .normal)
        shareBtn.adjustsImageWhenHighlighted = false
        shareBtn.imageView?.contentMode = .scaleToFill
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return shareBtn
    }()
    
    private lazy var shareButtonLabel: UILabel = {
        let label = UILabel()
        
        label.text = shareButtonLabelText
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.notoSans(size: optionsLabelSize, weight: optionsLabelWeight)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // Text views and labels - Text Container and labels
    private lazy var textContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = titleText
        label.numberOfLines = 2
        label.font = UIFont.notoSans(size: titleLabelSize, weight: titleLabelWeight)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        
        label.text = subtitleText
        label.numberOfLines = 1
        label.font = UIFont.notoSans(size: subtitleLabelSize, weight: subtitleLabelWeight)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        
        addBackgroundComponents()
        addOptionsComponents()
        addTextComponents()
        
        addPlayerTappedAction()
        addToPlaylistTappedAction()
    }
    
    private func addBackgroundComponents() {
        // Need to add player container view, player layer, gradient layer, play button and progress bar view
        player = AVPlayer()
        playerLayer = AVPlayerLayer(player: player)
        playerLayer!.videoGravity = .resizeAspectFill
        playerContainerView.layer.addSublayer(playerLayer!)
        
        contentView.addSubview(playerContainerView)
        contentView.layer.addSublayer(gradientLayer)
        contentView.addSubview(playButton)
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            // Player container constraints
            playerContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            playerContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playerContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            playerContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        playerLayer?.frame = contentView.bounds
        
        gradientLayer.position = contentView.center
        gradientLayer.frame = contentView.bounds
        
        playButton.frame = CGRect(x: 0, y: 0, width: videoPlayButtonWidth, height: videoPlayButtonHeight)
        playButton.center = contentView.center
        
        progressView.frame = CGRect(x: 0, y: contentView.frame.height - progressBarHeight, width: contentView.frame.width, height: progressBarHeight)
    }
    
    private func addPlayerTappedAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(videoViewTapped))
        playerContainerView.addGestureRecognizer(tapGesture)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    @objc func playButtonTapped() {
        videoViewTapped()
    }
    
    @objc func videoViewTapped() {
        if let player = player {
            if player.rate != 0 {
                // Video is playing, pause it
                player.pause()
                playButton.isHidden = false
            } else {
                // Video is paused, play it
                player.play()
                playButton.isHidden = true
            }
        }
    }
    
    private func addToPlaylistTappedAction() {
        addToPlaylistButton.addTarget(self, action: #selector(playListButtonTapped), for: .touchUpInside)
    }
    
    @objc func playListButtonTapped() {
        watchListDelegate?.didToggleWatchListState(for: self, videoID: self.videoID!)
    }
    
    private func addOptionsComponents() {
        optionsContainer.addSubview(watchButton)
        optionsContainer.addSubview(watchButtonLabel)
        optionsContainer.addSubview(addToPlaylistButton)
        optionsContainer.addSubview(addToPlaylistButtonLabel)
        optionsContainer.addSubview(shareButton)
        optionsContainer.addSubview(shareButtonLabel)
        
        contentView.addSubview(optionsContainer)
        
        NSLayoutConstraint.activate([
            // Options Container constraints
            optionsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: optionsContainerOffsetFromBottom),
            optionsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: optionsContainerOffsetFromTrailing),
            optionsContainer.widthAnchor.constraint(equalToConstant: optionsContainerWidth),
            optionsContainer.heightAnchor.constraint(equalToConstant: optionsContainerHeight),
            
            // Watch button constraints
            watchButton.topAnchor.constraint(equalTo: optionsContainer.topAnchor),
            watchButton.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            watchButton.widthAnchor.constraint(equalToConstant: optionsIconWidth),
            watchButton.heightAnchor.constraint(equalToConstant: optionsIconHeight),
            
            // Watch button label constraints
            watchButtonLabel.topAnchor.constraint(equalTo: watchButton.bottomAnchor),
            watchButtonLabel.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            watchButtonLabel.widthAnchor.constraint(equalToConstant: optionsLabelWidth),
            watchButtonLabel.heightAnchor.constraint(equalToConstant: optionsLabelHeight),
            
            // Add to playlist button constraints
            addToPlaylistButton.topAnchor.constraint(equalTo: watchButtonLabel.bottomAnchor, constant: optionsIntraGap),
            addToPlaylistButton.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            addToPlaylistButton.widthAnchor.constraint(equalToConstant: optionsIconWidth),
            addToPlaylistButton.heightAnchor.constraint(equalToConstant: optionsIconHeight),
            
            // Add to playlist button label constraints
            addToPlaylistButtonLabel.topAnchor.constraint(equalTo: addToPlaylistButton.bottomAnchor),
            addToPlaylistButtonLabel.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            addToPlaylistButtonLabel.widthAnchor.constraint(equalToConstant: optionsLabelWidth),
            addToPlaylistButtonLabel.heightAnchor.constraint(equalToConstant: optionsLabelHeight),
            
            // Share Button constraints
            shareButton.topAnchor.constraint(equalTo: addToPlaylistButtonLabel.bottomAnchor, constant: optionsIntraGap),
            shareButton.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: optionsIconWidth),
            shareButton.heightAnchor.constraint(equalToConstant: optionsIconHeight),
            
            // Share Button label constraints
            shareButtonLabel.topAnchor.constraint(equalTo: shareButton.bottomAnchor),
            shareButtonLabel.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            shareButtonLabel.widthAnchor.constraint(equalToConstant: optionsLabelWidth),
            shareButtonLabel.heightAnchor.constraint(equalToConstant: optionsLabelHeight)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Release the player and any associated resources
        player?.pause()
        playButton.isHidden = true
    }
    
    func configureVideoPlayer(with asset: Asset, watchListState: Bool) {
        print("Currently playing: ", asset)
        let videoURLString = asset.videoDetails.videoUri.avcUri
        let title = asset.videoDetails.title
        let description = asset.videoDetails.description
        let videoID = asset.videoDetails.id
        
        titleLabel.text = title
        subtitleLabel.text = description
        self.videoID = videoID
        
        if let videoURL = URL(string: videoURLString) {
            player?.replaceCurrentItem(with: AVPlayerItem(url: videoURL))
            player?.pause()
        } else {
            print("Error: Unable to use given URL")
        }
        
        updateWatchListButtonState(isVideoAdded: watchListState)
    }

    private func addTextComponents() {
        textContainer.addSubview(titleLabel)
        textContainer.addSubview(subtitleLabel)
        
        contentView.addSubview(textContainer)
        
        NSLayoutConstraint.activate([
            // Text cotainer constraints
            textContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textContainer.trailingAnchor.constraint(equalTo: optionsContainer.leadingAnchor, constant: textContainerOffsetFromTrailing),
            textContainer.heightAnchor.constraint(equalToConstant: textContainerHeight),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: titleLabelOffsetFromTop),
            titleLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: titleLabelOffsetFromLeading),
            titleLabel.widthAnchor.constraint(equalTo: textContainer.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
            
            // Subtitle label constraints
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: subtitleLabelOffsetFromLeading),
            subtitleLabel.widthAnchor.constraint(equalTo: textContainer.widthAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: subtitleLabelHeight)
        ])
    }
    
    func updateProgress() {
        guard let player = player, let currentItem = player.currentItem else { return }
        
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let duration = CMTimeGetSeconds(currentItem.duration)
        
        let progress = Float(currentTime / duration)
        progressView.progress = progress
    }
    
    func startVideoPlayback(with isMuted: Bool) {
        if isMuted {
            player?.isMuted = true
        } else {
            player?.isMuted = false
        }
        
        playButton.isHidden = true
        player?.seek(to: .zero)
        player?.play()
        // Notification used to restart the video once it ends
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinishPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        // Notification used to change video mute state when button is pressed in view controller
        NotificationCenter.default.addObserver(self, selector: #selector(updateMuteState), name: Notification.Name("MuteStateChanged"), object: nil)
        
        progressUpdateTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateProgress()
            }
        }
    }
    
    @objc func updateMuteState(_ notification: Notification) {
        if let isMuted = notification.userInfo?["isMuted"] as? Bool {
            player?.isMuted = isMuted
        }
    }
    
    func pauseVideoPlayback() {
        player?.pause()
        playButton.isHidden = false
        NotificationCenter.default.removeObserver(self)
        progressUpdateTimer?.invalidate()
        progressUpdateTimer = nil
    }
    
    func updateWatchListButtonState(isVideoAdded: Bool) {
        addToPlaylistButton.isSelected = isVideoAdded
    }
    
    @objc func videoDidFinishPlaying(_ notification: Notification) {
        player?.seek(to: CMTime.zero)
        player?.play()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        progressUpdateTimer?.invalidate()
        progressUpdateTimer = nil
    }
}
