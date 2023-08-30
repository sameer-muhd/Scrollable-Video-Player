//
//  VideoCollectionViewCell.swift
//  Scrollable-Video-Player
//
//  Created by Mohammad Sameer on 14/08/23.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    // Image assets declared as constants
    private let playButtonImg = "playButton"
    private let playButtonTappedImg = "playButtonTapped"
    private let addToListImg = "addToList"
    private let addToListTappedImg = "addToListTapped"
    private let shareButtonImg = "shareButton"
    private let shareButtonTappedImg = "shareButtonTapped"
    private let backButtonImg = "ChevronLeft"
    private let volumeLoudImg = "VolumeLoud"
    private let volumeMuteImg = "VolumeMute"
    private let backgroundImg = "TomHolland"

    // Options and title labels declared as constants
    private let watchButtonLabelText = "Watch"
    private let addToPlaylistButtonLabelText = "My List"
    private let shareButtonLabelText = "Share"
    private let titleText = "Spiderman arrives to rescue the town from Venom."
    private let subtitleText = "Spiderman: Homecoming • Action • U/A 7+"

    // All labels font size and weight declared as constants
    private let optionsLabelSize = CGFloat(12)
    private let optionsLabelWeight = UIFont.Weight.medium

    private let titleLabelSize = CGFloat(14)
    private let titleLabelWeight = UIFont.Weight.bold

    private let subtitleLabelSize = CGFloat(11)
    private let subtitleLabelWeight = UIFont.Weight.regular
    
    // Constraints declared as constants
    private let optionsContainerOffsetFromBottom = CGFloat(-24)
    private let optionsContainerOffsetFromTrailing = CGFloat(-24)
    private let optionsContainerWidth = CGFloat(42)
    private let optionsContainerHeight = CGFloat(206)
    
    private let optionsIconWidth = CGFloat(40)
    private let optionsIconHeight = CGFloat(40)
    private let optionsIntraGap = CGFloat(16)
    
    private let optionsLabelWidth = CGFloat(42)
    private let optionsLabelHeight = CGFloat(20)
    
    private let textContainerOffsetFromTrailing = CGFloat(24)
    private let textContainerHeight = CGFloat(102)
    
    private let titleLabelOffsetFromTop = CGFloat(16)
    private let titleLabelOffsetFromLeading = CGFloat(24)
    private let titleLabelHeight = CGFloat(42)
    
    private let subtitleLabelOffsetFromLeading = CGFloat(24)
    private let subtitleLabelHeight = CGFloat(16)
    
    private let topComponentsOffsetFromTop = CGFloat(16)
    private let topComponentOffsetFromLeading = CGFloat(16)
    private let topComponentsOffsetFromTrailing = CGFloat(-24)
    
    private let topComponentsWidth = CGFloat(30)
    private let topComponentsHeight = CGFloat(30)
    
    // Background views and layers - Background image and gradient layer
    private lazy var bgImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: backgroundImg))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.locations = [0.0, 0.5]
        
        return gradientLayer
    }()
    
    // Options views and labels - Options container, 3 buttons and their labels
    private var optionsContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private lazy var watchButton: UIButton = {
        let watchBtn = UIButton(type: .custom)
        
        watchBtn.setImage(UIImage(named: playButtonImg), for: .normal)
        watchBtn.setImage(UIImage(named: playButtonTappedImg), for: .highlighted)
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
        addBtn.setImage(UIImage(named: addToListTappedImg), for: .highlighted)
        addBtn.imageView?.contentMode = .scaleToFill
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return addBtn
    }()
    
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
        shareBtn.setImage(UIImage(named: shareButtonTappedImg), for: .highlighted)
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
    private var textContainer: UIView = {
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
        volumeBtn.imageView?.contentMode = .scaleToFill
        volumeBtn.adjustsImageWhenHighlighted = false
        volumeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return volumeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addBackgroundComponents()
        addOptionsComponents()
        addTextComponents()
        addTopComponents()
        
        addVolumeButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addBackgroundComponents() {
        contentView.addSubview(bgImage)
        contentView.layer.addSublayer(gradientLayer)
        
        gradientLayer.position = contentView.center
        bgImage.frame = contentView.bounds
        gradientLayer.frame = contentView.bounds
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
    
    private func addTopComponents() {
        contentView.addSubview(backButton)
        contentView.addSubview(volumeButton)
        
        NSLayoutConstraint.activate([
            // Back button constraints
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topComponentsOffsetFromTop),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: topComponentOffsetFromLeading),
            backButton.widthAnchor.constraint(equalToConstant: topComponentsWidth),
            backButton.heightAnchor.constraint(equalToConstant: topComponentsHeight),
            
            // Volume Button constraints
            volumeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topComponentsOffsetFromTop),
            volumeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: topComponentsOffsetFromTrailing),
            volumeButton.widthAnchor.constraint(equalToConstant: topComponentsWidth),
            volumeButton.heightAnchor.constraint(equalToConstant: topComponentsHeight),
        ])
    }
    
    private func addVolumeButtonAction() {
        volumeButton.addTarget(self, action: #selector(volumeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func volumeButtonTapped() {
        if volumeButton.currentImage == UIImage(named: volumeLoudImg) {
            volumeButton.setImage(UIImage(named: volumeMuteImg), for: .normal)
        } else {
            volumeButton.setImage(UIImage(named: volumeLoudImg), for: .normal)
        }
    }
}
