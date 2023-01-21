//
//  RecentlyPlayedViewModel.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 20/01/2023.
//

import UIKit
import CoreData

struct RecentlyPlayedViewModel {
    
    var recentlyPlayedTracks = [RecentlyPlayedTracks]()
    private var previousIndex: IndexPath?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func playTrack(indexPath: IndexPath) {
        guard let currentTrack = recentlyPlayedTracks[indexPath.row].preview_url else { return }
        print(currentTrack)
        guard let trackURL = URL(string: currentTrack) else { return }
        PlaybackManager.shared.play(track: trackURL)
    }
    
    func songInfo(indexPath: IndexPath, cellSong: inout UILabel, cellAlbum: inout UILabel, cellArtist: inout UILabel, cellTime: inout UILabel, imageURL: inout String) {
        let song = recentlyPlayedTracks[indexPath.row]
        cellSong.text = song.trackName
        cellAlbum.text = song.albumName
        cellArtist.text = song.artistName
        
        guard let songImage = song.imageUrl else { return }
        imageURL = songImage
    }
    
    mutating func loadTracks() {
        let request: NSFetchRequest<RecentlyPlayedTracks> = RecentlyPlayedTracks.fetchRequest()
        do{
            recentlyPlayedTracks = try context.fetch(request)
            recentlyPlayedTracks = recentlyPlayedTracks.reversed()
//            раскомментировать когда нужно удалить записи в кор дате
//            deleteAllFromCoreData()
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    func deleteAllFromCoreData() {
        for i in recentlyPlayedTracks{
            context.delete(i)
            print("delete \(i)")
        }
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
}
