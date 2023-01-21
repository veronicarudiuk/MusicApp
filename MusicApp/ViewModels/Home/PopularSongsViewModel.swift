//
//  PopularSongsViewModel.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 21/01/2023.
//

import UIKit

class PopularSongsViewModel {
    var albumData = [AlbumData]()
    private var allTracks = [TrackData]()
    private var previousIndex: IndexPath?
    private var treckID: Int?


    
    func playFromTrackList(index: IndexPath, for collection: UICollectionView) {
        PlaybackManager.shared.pause()

        if previousIndex != index {
            previousIndex = index
            PlaybackManager.shared.trackList = allTracks
            PlaybackManager.shared.playTrack(playIndex: index.row)
        }
       
        collection.reloadData()
    }

    func chooseButtonIcon(index: Int) -> UIImage {
        if PlaybackManager.shared.isPlaying == true {
            if PlaybackManager.shared.currentTrack?.id == allTracks[index].id {
                return UIImage(named: "StopActive")!
            }
        }

        return UIImage(named: "PlayIconInactive")!

    }
    
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
        for item in albumItems {
            getAlbum(album: item)
        }
    }
    
    func getAlbum(album: AlbumData) {
        APIRequestManager.shared.getAlbum(id: album.id) { result in
            switch result {
            case .success(let data):
                self.albumData.append(data)
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
