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
  var currentIcon: UIImage {
    isPlaying ? UIImage(named: "StopIcon")! : UIImage(named: "PlayIconActive")!
  }
  var isPlaying = false
}
