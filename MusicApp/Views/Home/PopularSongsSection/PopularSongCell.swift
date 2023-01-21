//
//  PopularSongCell.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 19/01/2023.
//

import UIKit

final class PopularSongCell: UICollectionViewCell {
    
    static let reusedID = "PopularSongCell"
    
    lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "DefaultAlbumIMG")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 9
        imageView.layer.masksToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: 177, height: 173)
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor(named: K.BrandColors.purpleGradientColor)?.cgColor ?? UIColor.clear.cgColor
        gradient.colors = [startColor, endColor]
        imageView.layer.insertSublayer(gradient, at: 0)
        
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(songImageView)
        addSubview(playImage)
        addSubview(songLabel)
        addSubview(albumNameLabel)
        
        setAnchors()
    }
    
    func setAnchors() {
        NSLayoutConstraint.activate([
            songImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            songImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            songImageView.topAnchor.constraint(equalTo: topAnchor),
            songImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            playImage.topAnchor.constraint(equalTo: topAnchor, constant: 122),
            playImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            playImage.heightAnchor.constraint(equalToConstant: 20.5),
            playImage.widthAnchor.constraint(equalToConstant: 20.5),
            
            songLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            songLabel.topAnchor.constraint(equalTo: topAnchor, constant: 116),
            songLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 100),
            
            albumNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            albumNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            albumNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 110)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
