//
//  RecentlyPlayedCell.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 19/01/2023.
//

import UIKit

final class RecentlyPlayedCell: UICollectionViewCell {
    
    static let reusedID = "RecentlyPlayedCell"
    
    lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DefaultAlbumIMG")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let playImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PlayIconInactive")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var songLabel: UILabel = {
        let label = UILabel()
        label.text = "Adiyee"
        label.textColor = .white
        label.font = UIFont(name: K.Fonts.interSemiBold, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bachelor"
        label.textColor = .white
        label.font = UIFont(name: K.Fonts.interRegular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var circleDividerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "circleDivider")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var musicianNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dhibu Ninan Thomas , Kapil Kapilan"
        label.textColor = .white
        label.font = UIFont(name: K.Fonts.interRegular, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "0:30"
//        ???????????????? ???? ????????????????
        label.textColor = UIColor(named: K.BrandColors.blueColor)
        label.font = UIFont(name: K.Fonts.interMedium, size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: K.BrandColors.grayBG)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        addSubview(songImageView)
        addSubview(playImage)
        addSubview(songLabel)
        addSubview(albumNameLabel)
        addSubview(circleDividerImage)
        addSubview(musicianNameLabel)
        addSubview(timeLabel)
        
        setAnchors()
    }
    
    func setAnchors() {
        NSLayoutConstraint.activate([
            songImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            songImageView.topAnchor.constraint(equalTo: topAnchor, constant: 9),
            songImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            songImageView.heightAnchor.constraint(equalToConstant: 71),
            songImageView.widthAnchor.constraint(equalToConstant: 72),
            
            playImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            playImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            playImage.heightAnchor.constraint(equalToConstant: 26),
            playImage.widthAnchor.constraint(equalToConstant: 26),
            
            songLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 12),
            songLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            songLabel.trailingAnchor.constraint(equalTo: playImage.leadingAnchor, constant: -8),
            
            albumNameLabel.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 4),
            albumNameLabel.leadingAnchor.constraint(equalTo: songImageView.trailingAnchor, constant: 12),
            albumNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),

            circleDividerImage.leadingAnchor.constraint(equalTo: albumNameLabel.trailingAnchor, constant: 8),
            circleDividerImage.centerYAnchor.constraint(equalTo: albumNameLabel.centerYAnchor),

            musicianNameLabel.leadingAnchor.constraint(equalTo: circleDividerImage.trailingAnchor, constant: 8),
            musicianNameLabel.topAnchor.constraint(equalTo: albumNameLabel.topAnchor),
            musicianNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            timeLabel.leadingAnchor.constraint(equalTo: songLabel.leadingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
