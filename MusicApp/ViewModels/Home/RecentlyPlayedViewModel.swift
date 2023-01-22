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
    
    var newTracks = [TrackData]()
    
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
        var allTracksReversed = [TrackData](allTracks.value.reversed())
        let song = allTracksReversed[indexPath.row]
        cellSong.text = song.name
        cellAlbum.text = song.album?.name
        cellArtist.text = song.artists[0].name
        
        guard let songImage = song.album?.images[0].url else { return }
        imageURL = songImage
    }
    
    func loadTracks() {
        let request: NSFetchRequest<RecentlyPlayedTracks> = RecentlyPlayedTracks.fetchRequest()
        do{
            print("FFFFFFFFFFFF")
            shortLastTracks = try context.fetch(request)
                self.fetchData()
                self.allTracks.value = self.newTracks
                self.newTracks = []
            
            //            раскомментировать когда нужно удалить записи в кор дате
//                        deleteAllFromCoreData()
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
                    self.newTracks.append(track)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
//        func deleteAllFromCoreData() {
//            for i in shortLastTracks{
//                context.delete(i)
//                print("delete \(i)")
//            }
//            do {
//                try context.save()
//            } catch {
//                print("Error saving context \(error)")
//            }
//        }
}
