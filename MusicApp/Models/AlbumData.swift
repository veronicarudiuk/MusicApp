//
//  AlbumData.swift
//  MusicApp
//
//  Created by Марс Мазитов on 15.01.2023.
//

import Foundation

struct AlbumData: Decodable {
    let album_type: String
    let id: String
    let images: [ImageData]
    let name: String
    let artists: [ArtistData]
}
