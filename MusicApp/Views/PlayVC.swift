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
    
    private lazy var horisontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var lyricsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var horisontalСontentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lyricsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let lyrics = """
                    Imagine there's no heaven
                    It's easy if you try
                    No hell below us
                    Above us, only sky
                    Imagine all the people
                    Living for today
                    \n
                    """
        label.text = String(repeating: lyrics, count: 10)
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
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 2
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
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
    }
    
    //MARK: - playButtonAction
    @objc func playButtonPressed(_ sender: UIButton) {
        sender.isSelected = viewModel.isPlaying
        viewModel.pause()
    }
}

//MARK: - UIScrollView Delegate
extension PlayVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

//MARK: - Set up Views
extension PlayVC {
    private func setupViews(){
        view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        navigationController?.isNavigationBarHidden = true
        view.addSubview(titleLabel)
        view.addSubview(pageControl)
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
        view.addSubview(horisontalScrollView)
        
        horisontalScrollView.delegate = self
        
        horisontalScrollView.addSubview(horisontalСontentView)
        horisontalСontentView.addSubview(songImage)
        horisontalСontentView.addSubview(lyricsScrollView)
        lyricsScrollView.addSubview(lyricsLabel)
    }
}

//MARK: - Set up Constraints
extension PlayVC {
    func setupConstraints() {
        let scrollContentGuide = horisontalScrollView.contentLayoutGuide
        let scrollFrameGuide = horisontalScrollView.frameLayoutGuide
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            horisontalScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            horisontalScrollView.heightAnchor.constraint(equalToConstant: 396),
            horisontalScrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            horisontalScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            horisontalСontentView.leadingAnchor.constraint(equalTo: scrollContentGuide.leadingAnchor),
            horisontalСontentView.trailingAnchor.constraint(equalTo: scrollContentGuide.trailingAnchor),
            horisontalСontentView.topAnchor.constraint(equalTo: scrollContentGuide.topAnchor),
            horisontalСontentView.bottomAnchor.constraint(equalTo: scrollContentGuide.bottomAnchor),
            
            horisontalСontentView.widthAnchor.constraint(equalToConstant: (CGFloat(view.frame.width) * 2)),
            horisontalСontentView.topAnchor.constraint(equalTo: scrollFrameGuide.topAnchor),
            horisontalСontentView.bottomAnchor.constraint(equalTo: scrollFrameGuide.bottomAnchor),
            
            songImage.topAnchor.constraint(equalTo: horisontalСontentView.topAnchor),
            songImage.leadingAnchor.constraint(equalTo: horisontalСontentView.leadingAnchor, constant: 21),
            songImage.heightAnchor.constraint(equalTo: horisontalСontentView.heightAnchor),
            songImage.widthAnchor.constraint(equalToConstant: 343),
            
            lyricsScrollView.widthAnchor.constraint(equalTo: songImage.widthAnchor),
            lyricsScrollView.topAnchor.constraint(equalTo: horisontalСontentView.topAnchor),
            lyricsScrollView.bottomAnchor.constraint(equalTo: horisontalСontentView.bottomAnchor),
            lyricsScrollView.trailingAnchor.constraint(equalTo: horisontalСontentView.trailingAnchor, constant: -21),
            
            lyricsLabel.centerXAnchor.constraint(equalTo: lyricsScrollView.centerXAnchor),
            lyricsLabel.widthAnchor.constraint(equalTo: lyricsScrollView.widthAnchor),
            lyricsLabel.topAnchor.constraint(equalTo: lyricsScrollView.topAnchor),
            lyricsLabel.bottomAnchor.constraint(equalTo: lyricsScrollView.bottomAnchor),
            
            pageControl.topAnchor.constraint(equalTo: horisontalScrollView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            songNameLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
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
