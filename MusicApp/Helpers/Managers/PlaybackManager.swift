//
//  PlaybackManager.swift
//  MusicApp
//
//  Created by Марс Мазитов on 18.01.2023.
//

import AVFoundation
import UIKit


class PlaybackManager {
    static var shared = PlaybackManager()
    
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
