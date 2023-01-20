//
//  SearchTableViewCell.swift
//  MusicApp
//
//  Created by Марс Мазитов on 15.01.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = "SearchResultCell"

    var id: Int?
    
    let loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        return spinner
    }()
    
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
    
//    let rightArrowImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "play.display")
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.cornerRadius = 5
//        return imageView
//    }()
    private lazy var rightArrowButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.setImage(UIImage(named: "pause.circle.fill"), for: .selected)
        button.tintColor = .white
        button.addTarget(target, action: #selector(rightArrowButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //accessoryType = .disclosureIndicator
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - rightArrowButton
    @objc func rightArrowButton(_ sender: UIButton) {
        print(123)

        sender.isSelected = !sender.isSelected
        
    }
    
    //MARK: - Private UI setup methods
    private func setupCell() {
        [albumImage, trackNameLabel, artistNameLabel, rightArrowButton, loadingSpinner].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            albumImage.topAnchor.constraint(equalTo: topAnchor),
            albumImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            albumImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            albumImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -290),
            
            loadingSpinner.topAnchor.constraint(equalTo: topAnchor),
            loadingSpinner.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            loadingSpinner.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            loadingSpinner.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -290),
            
            trackNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 29),
            trackNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            trackNameLabel.trailingAnchor.constraint(equalTo: rightArrowButton.leadingAnchor, constant: -5),
            
            artistNameLabel.leadingAnchor.constraint(equalTo: albumImage.trailingAnchor, constant: 29),
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 10),
            
            rightArrowButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightArrowButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22)
            
            
        ])
    }
}
