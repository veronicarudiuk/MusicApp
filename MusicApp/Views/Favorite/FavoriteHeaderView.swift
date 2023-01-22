//
//  FavoriteHeaderView.swift
//  MusicApp
//
//  Created by Даниил Симахин on 16.01.2023.
//

import UIKit

class FavoriteHeaderView: UIStackView {
    
    var viewModel: FavoriteHeaderViewViewModel? {
        didSet {
            profileImage.image = viewModel?.icon
        }
    }
    
    private lazy var likeView: UIImageView = {
        let likeView = UIImageView()
        likeView.image = UIImage(named: "FavoriteSection")
        likeView.contentMode = .scaleAspectFit
        return likeView
    }()
    private lazy var settingsButton: UIButton = {
        let settingsButton = UIButton()
        settingsButton.setImage(UIImage(named: "SettingsSection"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        settingsButton.contentMode = .scaleAspectFit
        return settingsButton
    }()
    private lazy var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.contentMode = .scaleAspectFit
        return profileImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        applyConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private func

private extension FavoriteHeaderView {
    func setup() {
        distribution = .fillEqually
        axis = .horizontal
        alignment = .center
    }
    
    func applyConstraints() {
        addArrangedSubview(likeView)
        addArrangedSubview(profileImage)
        addArrangedSubview(settingsButton)
    }
  
    
    @objc func settingsButtonTapped(_ sender: UIButton!) {
        
    }
}
