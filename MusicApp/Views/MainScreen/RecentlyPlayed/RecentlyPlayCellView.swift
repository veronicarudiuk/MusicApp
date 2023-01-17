//
//  RecentlyPlayCellView.swift
//  MusicApp
//
//  Created by vas on 16.01.2023.
//

import UIKit

class RecentlyPlayCellView: UIView {

  func setData(musicData: MusicData) {
    songName.text = musicData.songName
    albumNameArtistName.text = "\(musicData.albumName) • \(musicData.singerName)"
  }

  // MARK: - Properties
  lazy var playButton: UIButton = {
    let button = UIButton(type: .custom)
    button.frame = CGRect(x: 315, y: 30, width: 26, height: 26)
    button.backgroundColor = UIColor.cyan
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.setImage(UIImage(systemName: "play.fill"), for: .normal)
    button.tintColor = .white
    return button
  }()

  lazy var albumCoverImage: UIImageView = {
    let contentView = UIImageView(frame: CGRect(x: 10, y: 10, width: 70, height: 70))
    contentView.image = UIImage(named: "DefaultAlbumIMG")
    contentView.layer.cornerRadius = 5
    contentView.layer.masksToBounds = true
    return contentView
  }()

  lazy var songName: UILabel = {
    let songTitle = UILabel(frame: CGRect(x: 110, y: 0, width: 300, height: 40))
    songTitle.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    songTitle.text = "Latina"
    songTitle.textColor = .white
    return songTitle
  }()

  lazy var albumNameArtistName: UILabel = {
    let album = UILabel(frame: CGRect(x: 110, y: 20, width: 300, height: 40))
    album.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    album.text = "Waco Waco • Shakira"
    album.textColor = .white
    return album
  }()

  lazy var playedLength: UILabel = {
    let played = UILabel(frame: CGRect(x: 110, y: 40, width: 300, height: 40))
    played.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    played.text = "2:50 / "
    played.textColor = .white
    return played
  }()

  lazy var songLength: UILabel = {
    let songl = UILabel(frame: CGRect(x: 150, y: 40, width: 300, height: 40))
    songl.font = UIFont.systemFont(ofSize: 12, weight: .medium)
    songl.text = "3:50"
    songl.textColor = .cyan
    return songl
  }()

  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }

  // MARK: - Setup View
  private func setupView() {
    addSubview(albumCoverImage)
    addSubview(songName)
    addSubview(albumNameArtistName)
    addSubview(playedLength)
    addSubview(songLength)
    addSubview(playButton)
  }
}

