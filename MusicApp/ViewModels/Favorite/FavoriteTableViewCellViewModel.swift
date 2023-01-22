//
//  FavoriteTableViewCellViewModel.swift
//  MusicApp
//
//  Created by Даниил Симахин on 16.01.2023.
//

import UIKit

struct FavoriteTableViewCellViewModel {
  let artist: String
  let track: String
  let trackID: String
  let stopIcon = UIImage(named: "StopActive")
  let playIcon = UIImage(named: "PlayIconInactive")
  var currentIcon: UIImage {
    isPlaying ? stopIcon! : playIcon!
  }
  var isPlaying = false
}
