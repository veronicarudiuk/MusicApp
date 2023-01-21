//
//  PlaybackManager.swift
//  MusicApp
//
//  Created by Марс Мазитов on 18.01.2023.
//

import AVFoundation
import UIKit
import CoreData


class PlaybackManager {
    static var shared = PlaybackManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var currentTrackIndex: Int? {
        didSet {
            playFromTrackList()
        }
    }
    
    var trackList: [TrackData]? {
        didSet {
            playFromTrackList()
        }
    }
    
    private func playFromTrackList() {
        guard let list = trackList else { return }
        currentTrack = list[currentTrackIndex ?? 0]
        
        guard let currentTrack = currentTrack else {return}
        print(currentTrack.name)
        addTrackToRecentlyPlayed(currentTrack)
    }
    
    var delegateVC: UIViewController?
    
    private var player: AVPlayer?
    
    var isPlaying = false
    
    var currentTrack: TrackData? {
        didSet {
            guard let currentTrack = currentTrack?.preview_url else { return }
            guard let trackURL = URL(string: currentTrack) else { return }
            play(track: trackURL)
        }
    }
    
    var progress: Double? {
        guard let currentPlayTime = currentPlayTime else { return nil }
        guard let trackDuration = trackDuration else { return nil }
        guard isPlaying == true else { return nil }
        return currentPlayTime/trackDuration
    }
    
    //текущая секунда
    var currentPlayTime: Double? {
        guard let time = player?.currentTime().seconds else { return nil}
        return time
    }
    
    //продолжительность трека
    var trackDuration: Double? {
        guard let time = player?.currentItem?.duration.seconds else { return nil}
        return time
    }
    
    //перейти в начало трека
    func toStartTrack() {
        player?.seek(to: CMTimeMakeWithSeconds(0, preferredTimescale: 1))
    }
    
    func playTrack(playIndex: Int) {
        guard playIndex != trackList?.count else { return }

        currentTrackIndex = playIndex
    }
    
    func setTrack(_ set: TrackData) {
        currentTrack = set
        
    }
  

  func addTrackToLikedSongs(_ trackData: TrackData) {
    let newTrack = LikedSongs(context: self.context)
    newTrack.trackId = trackData.id
    newTrack.trackName = trackData.name
    newTrack.albumName = trackData.album.name
    newTrack.artistName = trackData.artists[0].name
    newTrack.imageUrl = trackData.album.images[0].url
    saveItems()

  }

    
//    сохраняем трек в контекст кор даты
    func addTrackToRecentlyPlayed(_ trackData: TrackData) {
        let newTrack = RecentlyPlayedTracks(context: self.context)
        newTrack.trackId = trackData.id
        newTrack.trackName = trackData.name
        newTrack.albumName = trackData.album.name
        newTrack.artistName = trackData.artists[0].name
//        if let time = trackDuration {
//            newTrack.duration = "0:\(String(describing: Int(time)))"
//        }
        newTrack.imageUrl = trackData.album.images[0].url
        saveItems()
    }
    
//    сохраняем контекст кор даты
    func saveItems() {
        do {
           try context.save()
        } catch {
           print("Error saving context \(error)")
        }
    }
    
    func pause() {
        isPlaying = false
        player?.pause()
    }
    
    func play() {
        isPlaying = true
        player?.play()
    }
    
    
    
    private func play(track: URL) {
        player = AVPlayer(url: track)
        player?.pause()
        player?.play()
        player?.volume = 1
        isPlaying = true
    }
    
    
}
