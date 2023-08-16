//
//  VideoCollectionViewCell.swift
//  Scrollable-Video-Player
//
//  Created by Mohammad Sameer on 14/08/23.
//

import UIKit

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
        
        watchBtn.setImage(UIImage(named: "playButton"), for: .normal)
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
        addBtn.setImage(UIImage(named: "addToList"), for: .normal)
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
        shareBtn.setImage(UIImage(named: "shareButton"), for: .normal)
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
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Spiderman arrives to rescue the town from Venom."
        label.numberOfLines = 2
        label.font = UIFont.notoSans(size: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var textContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bgImage)
        contentView.layer.addSublayer(gradientLayer)
        
        contentView.addSubview(optionsContainer)
        contentView.addSubview(textContainer)
        
        optionsContainer.addSubview(watchButton)
        optionsContainer.addSubview(watchButtonLabel)
        optionsContainer.addSubview(addToPlaylistButton)
        optionsContainer.addSubview(addToPlaylistButtonLabel)
        optionsContainer.addSubview(shareButton)
        optionsContainer.addSubview(shareButtonLabel)
        
        textContainer.addSubview(titleLabel)
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
            textContainer.trailingAnchor.constraint(greaterThanOrEqualTo: optionsContainer.leadingAnchor, constant: 20),
            textContainer.heightAnchor.constraint(equalToConstant: 102),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: 24),
            titleLabel.widthAnchor.constraint(equalToConstant: 262),
            titleLabel.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
}
