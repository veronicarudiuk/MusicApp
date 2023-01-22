//
//  PopularSongsViewModel.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 21/01/2023.
//

import UIKit

class PopularSongsViewModel {
    lazy var albumData = Box([AlbumData]())
    private var allTracks = [TrackData]()
    private var previousIndex: IndexPath?

//    логика проигрывания песни
    func playFromTrackList(index: IndexPath, for collection: UICollectionView) {
        let cell = collection.cellForItem(at: index) as! PopularSongCell
        PlaybackManager.shared.pause()
        
        if previousIndex != nil {
            if let previousCell = collection.cellForItem(at: previousIndex!) as? PopularSongCell {
                previousCell.playImage.image = UIImage(named: "PlayIconInactive")
            }
        }
        
        guard previousIndex != index else { previousIndex = nil; return }

        previousIndex = index
        PlaybackManager.shared.trackList = allTracks
        PlaybackManager.shared.playTrack(playIndex: index.row)
        cell.playImage.image = UIImage(named: "StopActive")
    }

    func chooseButtonIcon(index: Int) -> UIImage {
        if PlaybackManager.shared.isPlaying == true {
            if PlaybackManager.shared.currentTrack?.id == allTracks[index].id {
                return UIImage(named: "StopActive")!
            }
        }

        return UIImage(named: "PlayIconInactive")!

    }
    
//    делаю запрос на список новых альбомов
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
    
//    запрашиваю данные о каждом альбоме из списка новых альбомов
    func getAllAlbums(newReleasesData: NewReleasesData) {
        let albumItems = newReleasesData.albums.items
        for item in albumItems {
            getAlbum(album: item)
        }
    }
    
//    добавляю данные о первой песне в каждом альбоме в allTracks
    func getAlbum(album: AlbumData) {
        APIRequestManager.shared.getAlbum(id: album.id) { result in
            switch result {
            case .success(let data):
                guard (data.tracks?.items[0].preview_url) != nil else { return }
                self.albumData.value.append(data)
                var track = data.tracks?.items[0]
                track?.album = album
                if let track = track {
                    self.allTracks.append(track)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
