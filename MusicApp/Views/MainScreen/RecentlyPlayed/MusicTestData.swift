//
//  MusicTestData.swift
//  MusicApp
//
//  Created by vas on 16.01.2023.
//

import UIKit

struct MusicData {
  let songName: String
  let albumName: String
  let singerName: String
  let albumCover: UIImage?
  let songLength: Int
  var playedLength: Int
}

var testData = [
  MusicData(songName: "Latina", albumName: "Shakira album 1", singerName: "Shakira", albumCover: UIImage(named: "album"),songLength: 186, playedLength: 140),
  MusicData(songName: "Coolsong", albumName: "Ramasoti album 1", singerName: "Sting", albumCover: UIImage(named: "album"),songLength: 430, playedLength: 310),
  MusicData(songName: "Dr Dre", albumName: "Dre dre album2", singerName: "Eminem", albumCover: UIImage(named: "album"),songLength: 55, playedLength: 44)
]

var testData2 = [
  MusicData(songName: "Latina", albumName: "Shakira album 1", singerName: "Shakira", albumCover: UIImage(named: "album"),songLength: 186, playedLength: 140),
  MusicData(songName: "Coolsong", albumName: "Ramasoti album 1", singerName: "Sting", albumCover: UIImage(named: "album"),songLength: 430, playedLength: 310),
]

