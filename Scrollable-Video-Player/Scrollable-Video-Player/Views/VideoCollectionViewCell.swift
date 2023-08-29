//
//  VideoCollectionViewCell.swift
//  Scrollable-Video-Player
//
//  Created by Mohammad Sameer on 14/08/23.
//

import UIKit

// Image assets declared as constants
let playButtonImg = "playButton"
let playButtonTappedImg = "playButtonTapped"
let addToListImg = "addToList"
let addToListTappedImg = "addToListTapped"
let shareButtonImg = "shareButton"
let shareButtonTappedImg = "shareButtonTapped"
let backButtonImg = "ChevronLeft"
let volumeLoudImg = "VolumeLoud"
let volumeMuteImg = "VolumeMute"

class VideoCollectionViewCell: UICollectionViewCell {
    private let bgImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TomHolland"))
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
    
    private var watchButton: UIButton = {
        let watchBtn = UIButton(type: .custom)
        
        watchBtn.setImage(UIImage(named: playButtonImg), for: .normal)
        watchBtn.setImage(UIImage(named: playButtonTappedImg), for: .highlighted)
        watchBtn.imageView?.contentMode = .scaleToFill
        watchBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return watchBtn
    }()
    
    private var watchButtonLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Watch"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.notoSans(size: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var addToPlaylistButton: UIButton = {
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: addToListImg), for: .normal)
        addBtn.setImage(UIImage(named: addToListTappedImg), for: .highlighted)
        addBtn.imageView?.contentMode = .scaleToFill
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return addBtn
    }()
    
    private var addToPlaylistButtonLabel: UILabel = {
        let label = UILabel()
        
        label.text = "My List"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.notoSans(size: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var shareButton: UIButton = {
        let shareBtn = UIButton(type: .custom)
        shareBtn.setImage(UIImage(named: shareButtonImg), for: .normal)
        shareBtn.setImage(UIImage(named: shareButtonTappedImg), for: .highlighted)
        shareBtn.imageView?.contentMode = .scaleToFill
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return shareBtn
    }()
    
    private var shareButtonLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Share"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.notoSans(size: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var optionsContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Spiderman arrives to rescue the town from Venom."
        label.numberOfLines = 2
        label.font = UIFont.notoSans(size: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Spiderman: Homecoming • Action • U/A 7+"
        label.numberOfLines = 1
        label.font = UIFont.notoSans(size: 11, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var textContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    private var backButton: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: backButtonImg), for: .normal)
        backBtn.imageView?.contentMode = .scaleToFill
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return backBtn
    }()
    
    private var volumeButton: UIButton = {
        let volumeBtn = UIButton(type: .custom)
        volumeBtn.setImage(UIImage(named: volumeLoudImg), for: .normal)
        volumeBtn.imageView?.contentMode = .scaleToFill
        volumeBtn.adjustsImageWhenHighlighted = false
        volumeBtn.translatesAutoresizingMaskIntoConstraints = false
        
        return volumeBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bgImage)
        contentView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(optionsContainer)
        contentView.addSubview(textContainer)
        contentView.addSubview(backButton)
        contentView.addSubview(volumeButton)
        
        optionsContainer.addSubview(watchButton)
        optionsContainer.addSubview(watchButtonLabel)
        optionsContainer.addSubview(addToPlaylistButton)
        optionsContainer.addSubview(addToPlaylistButtonLabel)
        optionsContainer.addSubview(shareButton)
        optionsContainer.addSubview(shareButtonLabel)
        
        textContainer.addSubview(titleLabel)
        textContainer.addSubview(subtitleLabel)
        
        volumeButton.addTarget(self, action: #selector(volumeButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = contentView.bounds
        gradientLayer.position = contentView.center
        bgImage.frame = contentView.bounds
        
        NSLayoutConstraint.activate([
            // Back button constraints
            backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Volume Button constraints
            volumeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            volumeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            volumeButton.widthAnchor.constraint(equalToConstant: 30),
            volumeButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Options Container constraints
            optionsContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            optionsContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            optionsContainer.widthAnchor.constraint(equalToConstant: 42),
            optionsContainer.heightAnchor.constraint(equalToConstant: 206),
            
            // Watch button constraints
            watchButton.topAnchor.constraint(equalTo: optionsContainer.topAnchor),
            watchButton.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            watchButton.widthAnchor.constraint(equalToConstant: 40),
            watchButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Watch button label constraints
            watchButtonLabel.topAnchor.constraint(equalTo: watchButton.bottomAnchor),
            watchButtonLabel.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            watchButtonLabel.widthAnchor.constraint(equalToConstant: 40),
            watchButtonLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // Add to playlist button constraints
            addToPlaylistButton.topAnchor.constraint(equalTo: watchButtonLabel.bottomAnchor, constant: 16),
            addToPlaylistButton.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            addToPlaylistButton.widthAnchor.constraint(equalToConstant: 40),
            addToPlaylistButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Add to playlist button label constraints
            addToPlaylistButtonLabel.topAnchor.constraint(equalTo: addToPlaylistButton.bottomAnchor),
            addToPlaylistButtonLabel.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            addToPlaylistButtonLabel.widthAnchor.constraint(equalToConstant: 42),
            addToPlaylistButtonLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // Share Button constraints
            shareButton.topAnchor.constraint(equalTo: addToPlaylistButtonLabel.bottomAnchor, constant: 16),
            shareButton.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            shareButton.widthAnchor.constraint(equalToConstant: 40),
            shareButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Share Button label constraints
            shareButtonLabel.topAnchor.constraint(equalTo: shareButton.bottomAnchor),
            shareButtonLabel.centerXAnchor.constraint(equalTo: optionsContainer.centerXAnchor),
            shareButtonLabel.widthAnchor.constraint(equalToConstant: 40),
            shareButtonLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // Text cotainer constraints
            textContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textContainer.trailingAnchor.constraint(equalTo: optionsContainer.leadingAnchor, constant: 24),
            textContainer.heightAnchor.constraint(equalToConstant: 102),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: 24),
            titleLabel.widthAnchor.constraint(equalTo: textContainer.widthAnchor, multiplier: 1.0),
            titleLabel.heightAnchor.constraint(equalToConstant: 42),
            
            // Subtitle label constraints
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            subtitleLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: 24),
            subtitleLabel.widthAnchor.constraint(equalTo: textContainer.widthAnchor, multiplier: 1.0),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    @objc func volumeButtonTapped() {
        if volumeButton.currentImage == UIImage(named: volumeLoudImg) {
            volumeButton.setImage(UIImage(named: volumeMuteImg), for: .normal)
        } else {
            volumeButton.setImage(UIImage(named: volumeLoudImg), for: .normal)
        }
    }
}
