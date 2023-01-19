//
//  PlayVCViewModel.swift
//  MusicApp
//
//  Created by Марс Мазитов on 18.01.2023.
//

import UIKit

class PlayVCViewModel {
    
    var songName: String {
        return PlaybackManager.shared.currentTrack?.name ?? "Song name"
    }
    
    var songImage: String {
        return PlaybackManager.shared.currentTrack?.album.images[0].url ?? "https://www.publicdomainpictures.net/pictures/280000/velka/not-found-image-15383864787lu.jpg"
    }
    
    var artistName: String {
        var name = ""
        PlaybackManager.shared.currentTrack?.artists.forEach() { name += " \($0.name)"}
        return name
    }
    
    var albumName: String {
        return PlaybackManager.shared.currentTrack?.album.name ?? "Album name"
    }
    
    var isPlaying: Bool {
        return PlaybackManager.shared.isPlaying
    }
    
    var progress: Double {
        return PlaybackManager.shared.progress ?? 0
    }
    
    var currentTrackTime: String {
        guard let time = PlaybackManager.shared.currentPlayTime else { return "0" }
        if time < 10 {
            return "0:0\(String(describing: Int(time)))"
        }
        return "0:\(String(describing: Int(time)))"
    }
    
    var trackDuration: String? {
        guard let time = PlaybackManager.shared.trackDuration else { return "0"}
        
        if time < 10 {
            return "0:\(String(describing: Int(time)))"
        } else if time >= 0 {
            return "0:\(String(describing: Int(time)))"
        }
        return nil
    }
    
    func resume(for track: TrackData) {
    }
    
    func pause() {
        if isPlaying {
            PlaybackManager.shared.pause()
        } else {
            PlaybackManager.shared.play()
        }
    }
    
    func backTrack() {}
    func forwardTrack() {}
}
