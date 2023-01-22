//
//  RecentlyPlayedViewModel.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 20/01/2023.
//

import UIKit
import CoreData

class RecentlyPlayedViewModel {
    
    //    lazy var shortLastTracks = Box([RecentlyPlayedTracks]())
     var shortLastTracks = [RecentlyPlayedTracks]()
    
//    private var allTracks = [TrackData]()
    lazy var allTracks = Box([TrackData]())
    
    private var previousIndex: IndexPath?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func numberOfItemsInSection() -> Int {
        return allTracks.value.count
    }
    
    //    логика проигрывания песни
    func playFromTrackList(index: IndexPath, for collection: UICollectionView) {
        let cell = collection.cellForItem(at: index) as! RecentlyPlayedCell
        PlaybackManager.shared.pause()
        
        if previousIndex != nil {
            if let previousCell = collection.cellForItem(at: previousIndex!) as? RecentlyPlayedCell {
                previousCell.playImage.image = UIImage(named: "PlayIconInactive")
            }
        }
        
        guard previousIndex != index else { previousIndex = nil; return }
        
        previousIndex = index
        PlaybackManager.shared.trackList = allTracks.value
        PlaybackManager.shared.playTrack(playIndex: index.row)
        cell.playImage.image = UIImage(named: "StopActive")
        
        //       проверяю есть ли айдишка трека
//        guard let currentTrack = allTracks.value[index.row].preview_url else { return }
//        print(currentTrack)
    }
    
    func chooseButtonIcon(index: Int) -> UIImage {
        if PlaybackManager.shared.isPlaying == true {
            if PlaybackManager.shared.currentTrack?.id == allTracks.value[index].id {
                return UIImage(named: "StopActive")!
            }
        }
        return UIImage(named: "PlayIconInactive")!
    }
    
    func songInfo(indexPath: IndexPath, cellSong: inout UILabel, cellAlbum: inout UILabel, cellArtist: inout UILabel, cellTime: inout UILabel, imageURL: inout String) {
        let song = allTracks.value[indexPath.row]
        cellSong.text = song.name
        cellAlbum.text = song.album?.name
        cellArtist.text = song.artists[0].name
        
        guard let songImage = song.album?.images[0].url else { return }
        imageURL = songImage
//        let song = shortLastTracks[indexPath.row]
//        cellSong.text = song.trackName
//        cellAlbum.text = song.albumName
//        cellArtist.text = song.artistName
//
//        guard let songImage = song.imageUrl else { return }
//        imageURL = songImage
    }
    
    func loadTracks() {
        let request: NSFetchRequest<RecentlyPlayedTracks> = RecentlyPlayedTracks.fetchRequest()
        do{
            shortLastTracks = try context.fetch(request)
            shortLastTracks = shortLastTracks.reversed()
            if shortLastTracks.count >= 99 {
                shortLastTracks = Array(shortLastTracks[0...9])
            }
            self.allTracks.value.removeAll()
            fetchData()
            //            раскомментировать когда нужно удалить записи в кор дате
            //            deleteAllFromCoreData()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func fetchData() {
        for track in shortLastTracks {
            guard let trackID = track.trackId else { return }
            APIRequestManager.shared.getTrack(id: trackID) { result in
                switch result {
                case .success(let track):
                    self.allTracks.value.append(track)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    //    func deleteAllFromCoreData() {
    //        for i in recentlyPlayedTracks{
    //            context.delete(i)
    //            print("delete \(i)")
    //        }
    //        do {
    //            try context.save()
    //        } catch {
    //            print("Error saving context \(error)")
    //        }
    //    }
}
