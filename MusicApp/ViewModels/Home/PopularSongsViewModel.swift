//
//  PopularSongsViewModel.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 21/01/2023.
//

import Foundation

class PopularSongsViewModel {
    var albumData = [AlbumData]()
    
     func fetchData() {
        APIRequestManager.shared.getNewReleases{ result in
            switch result {
            case .success(let data):
                self.getAllAlbums(newReleasesData: data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
     func getAllAlbums(newReleasesData: NewReleasesData) {
        let albumItems = newReleasesData.albums.items
        var line = 0
        for items in albumItems {
            getAlbum(id: items.id, line: line)
            line += 1
        }
    }
    
    func getAlbum(id: String, line: Int) {
        APIRequestManager.shared.getAlbum(id: id) { result in
            switch result {
            case .success(let data):
                self.albumData.append(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
