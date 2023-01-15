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
    let iconPlayPassive = UIImage(named: "PlayIconInactive")
    let iconPlayActive = UIImage(named: "PlayIconActive")
    var isPlayed = false
}
