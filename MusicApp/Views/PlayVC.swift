//
//  PlayVC.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 09/01/2023.
//

import UIKit

class PlayVC: UIViewController {
    var viewModel = PlayVCViewModel()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Playing Now"
        label.textColor = .white
        label.font = UIFont(name: K.Fonts.interSemiBold, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var songImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "DefaultSongMG")
        image.layer.cornerRadius = 9
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var songTextLabel: UILabel = {
        let label = UILabel()
        let repeatStr = String(repeating: "TextSong", count: 400)
        label.text = repeatStr
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: K.Fonts.interSemiBold, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Adiyee"
        label.textColor = .white
        label.font = UIFont(name: K.Fonts.interSemiBold, size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bachelor"
        label.textColor = .white
        label.font = UIFont(name: K.Fonts.interRegular, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var circleDividerImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "circleDivider")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var musicianNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Dhibu Ninan Thomas , Kapil Kapilan"
        label.textColor = .white
        label.font = UIFont(name: K.Fonts.interRegular, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "HeartIconInactive"), for: .normal)
        button.setImage(UIImage(named: "HeartIcon"), for: .selected)
        button.addTarget(target, action: #selector(heartButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.progressTintColor = UIColor(named: K.BrandColors.blueColor) //заменить на градиент
        progress.trackTintColor = UIColor(named: K.BrandColors.lightGray)
        progress.layer.masksToBounds = true
        progress.layer.cornerRadius = 3
        progress.progress = 0
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private lazy var timePassedLabel: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.textColor = .white
        label.font = UIFont(name: K.Fonts.interRegular, size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var timeLeftLabel: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.textColor = .white
        label.font = UIFont(name: K.Fonts.interRegular, size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var rewindButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "RewindIcon"), for: .normal)
        button.addTarget(target, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "StopIcon"), for: .normal)
        button.setImage(UIImage(named: "PlayIconActive"), for: .selected)
        button.addTarget(target, action: #selector(playButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var fastForwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "FastForwardIcon"), for: .normal)
        button.addTarget(target, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    private func updateView() {
        
        DispatchQueue.main.async {
            var _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                self.timePassedLabel.text = self.viewModel.currentTrackTime
                self.timeLeftLabel.text = self.viewModel.trackDuration
            }
            var _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                if self.viewModel.progress != 0 {
                    self.progressBar.progress = Float(self.viewModel.progress)
                }
            }
            
            self.songNameLabel.text = self.viewModel.songName
            self.albumNameLabel.text = self.viewModel.albumName
            self.musicianNameLabel.text = self.viewModel.artistName
            self.playButton.isSelected = !self.viewModel.isPlaying
            self.heartButton.isSelected = self.viewModel.isLikedTrack
        }
        self.cachedImage(url: self.viewModel.songImage) { [weak self] image in
            DispatchQueue.main.async {
                self?.songImage.image = image
            }
        }
        
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - backButtonPressed
    @objc func backButtonPressed(_ sender: UIButton) {
        viewModel.backTrack()
        updateView()
    }
    
    //MARK: - nextButtonPressed
    @objc func nextButtonPressed(_ sender: UIButton) {
        viewModel.nextTrack()
        updateView()
    }
    
  //MARK: - heartButtonAction
  @objc func heartButtonPressed(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    viewModel.heartButtonPressed()

  }
    
    //MARK: - playButtonAction
    @objc func playButtonPressed(_ sender: UIButton) {
        sender.isSelected = viewModel.isPlaying
        viewModel.pause()
    }
}

//MARK: - Set up Views
extension PlayVC {
    private func setupViews(){
        view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        navigationController?.isNavigationBarHidden = true
        view.addSubview(titleLabel)
        view.addSubview(songNameLabel)
        view.addSubview(albumNameLabel)
        view.addSubview(circleDividerImage)
        view.addSubview(musicianNameLabel)
        view.addSubview(heartButton)
        view.addSubview(progressBar)
        view.addSubview(timePassedLabel)
        view.addSubview(timeLeftLabel)
        view.addSubview(rewindButton)
        view.addSubview(playButton)
        view.addSubview(fastForwardButton)
        view.addSubview(songImage)
    }
}

//MARK: - Set up Constraints
extension PlayVC {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            songImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            songImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            songImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            songImage.heightAnchor.constraint(equalToConstant: 396),
            
            songNameLabel.topAnchor.constraint(equalTo: songImage.bottomAnchor, constant: 20),
            songNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            
            albumNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 10),
            albumNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            
            circleDividerImage.leadingAnchor.constraint(equalTo: albumNameLabel.trailingAnchor, constant: 8),
            circleDividerImage.centerYAnchor.constraint(equalTo: albumNameLabel.centerYAnchor),
            
            musicianNameLabel.topAnchor.constraint(equalTo: albumNameLabel.topAnchor),
            musicianNameLabel.leadingAnchor.constraint(equalTo: circleDividerImage.trailingAnchor, constant: 8),
            
            heartButton.topAnchor.constraint(equalTo: songNameLabel.topAnchor, constant: 14.5),
            heartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            progressBar.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 29),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            
            timePassedLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 8),
            timePassedLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            
            timeLeftLabel.topAnchor.constraint(equalTo: timePassedLabel.topAnchor),
            timeLeftLabel.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            
            playButton.topAnchor.constraint(equalTo: timePassedLabel.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            
            rewindButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            rewindButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -38),
            
            fastForwardButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            fastForwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 38)
        ])
    }
}
