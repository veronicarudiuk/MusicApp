//
//  SearchTableViewCell.swift
//  MusicApp
//
//  Created by Марс Мазитов on 15.01.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchResultCell"

    let trackNameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont(name: "Inter-Regular", size: 16)
        return label
    }()
    
    let albumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    let rightArrowImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "RightArrow")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //accessoryType = .disclosureIndicator
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - Private UI setup methods
    private func setupCell() {
        [albumImage, trackNameLabel, artistNameLabel, rightArrowImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            albumImage.topAnchor.constraint(equalTo: topAnchor),
            albumImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            albumImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            albumImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -290),
            
            trackNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 29),
            trackNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            trackNameLabel.trailingAnchor.constraint(equalTo: rightArrowImage.leadingAnchor, constant: -5),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 29),
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 10),
            
            rightArrowImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightArrowImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22)
            
            
        ])
    }
}
