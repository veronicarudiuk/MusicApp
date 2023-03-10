//
//  FavoriteTableViewCell.swift
//  MusicApp
//
//  Created by Даниил Симахин on 15.01.2023.
//

import UIKit
import CoreData


class FavoriteTableViewCell: UITableViewCell {

  var trackID: String?

  static var reuseIdentifier: String = String(describing: FavoriteTableViewCell.self)

  private lazy var trackName: UILabel = {
    let trackName = UILabel()
    trackName.adjustsFontForContentSizeCategory = true
    trackName.font = .preferredFont(forTextStyle: .headline)
    trackName.textColor = UIColor(named: K.BrandColors.greenGradientColor)
    trackName.setContentHuggingPriority(.defaultLow, for: .horizontal)
    trackName.translatesAutoresizingMaskIntoConstraints = false
    return trackName
  }()
  private lazy var artistName: UILabel = {
    let artistName = UILabel()
    artistName.adjustsFontForContentSizeCategory = true
    artistName.font = .preferredFont(forTextStyle: .subheadline)
    artistName.textColor = .white
    artistName.setContentHuggingPriority(.defaultLow, for: .horizontal)
    artistName.translatesAutoresizingMaskIntoConstraints = false
    return artistName
  }()
  
  lazy var playButton: UIButton = {
    let playButton = UIButton()
    playButton.setImage(UIImage(named: "PlayIconActive"), for: .normal)
    playButton.imageView?.contentMode = .scaleAspectFit
    playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    playButton.translatesAutoresizingMaskIntoConstraints = false
    playButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    return playButton
  }()

  var viewModel: FavoriteTableViewCellViewModel? {
    didSet {
      trackName.text = viewModel?.track
      artistName.text = viewModel?.artist
      playButton.setImage(viewModel?.currentIcon, for: .normal)
      trackID = viewModel?.trackID
    }
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
    
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private func

private extension FavoriteTableViewCell {
  func setup() {
    backgroundColor = .clear

    contentView.addSubview(playButton)
    NSLayoutConstraint.activate([
      playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      playButton.widthAnchor.constraint(equalToConstant: 25)
    ])

    contentView.addSubview(trackName)
    NSLayoutConstraint.activate([
      trackName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      trackName.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -10),
      trackName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
    ])

    contentView.addSubview(artistName)
    NSLayoutConstraint.activate([
      artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor, constant: 10),
      artistName.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -10),
      artistName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      artistName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
    ])
  }


  @objc func playButtonTapped(_ sender: UIButton!) {
    guard let trackID = trackID else { return }
    if (PlaybackManager.shared.isPlaying == true) && (PlaybackManager.shared.currentTrack?.id == trackID) {
      playButton.setImage(viewModel?.playIcon, for: .normal)
      PlaybackManager.shared.pause()
      return
    }
    APIRequestManager.shared.getTrack(id: trackID) { result in
        switch result {
        case .success(let model):
          PlaybackManager.shared.currentTrack = model
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      NotificationCenter.default.post(name: NSNotification.Name("reloadtable"), object: nil)
      NotificationCenter.default.post(name: NSNotification.Name("loadData"), object: nil)
    }
  }
}
