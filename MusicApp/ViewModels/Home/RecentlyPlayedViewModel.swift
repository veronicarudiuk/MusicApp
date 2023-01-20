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
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func songInfo(indexPath: IndexPath, cellSong: inout UILabel, cellAlbum: inout UILabel, cellArtist: inout UILabel, cellTime: inout UILabel, imageURL: inout String) {
        let song = recentlyPlayedTracks[indexPath.row]
        cellSong.text = song.trackName
        cellAlbum.text = song.albumName
        cellArtist.text = song.artistName
//        cellTime.text = song.duration
        
        guard let songImage = song.imageUrl else { return }
        imageURL = songImage
    }
    
    mutating func loadTracks() {
        let request: NSFetchRequest<RecentlyPlayedTracks> = RecentlyPlayedTracks.fetchRequest()
        do{
            recentlyPlayedTracks = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
