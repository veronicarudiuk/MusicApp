//
//  ArtistData.swift
//  MusicApp
//
//  Created by Марс Мазитов on 15.01.2023.
//

import Foundation

struct ArtistData: Decodable {
    let external_urls: [String: String]
    let id: String
    let name: String
    let type: String
}
