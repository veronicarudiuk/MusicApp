//
//  SearchVCViewModel.swift
//  MusicApp
//
//  Created by Марс Мазитов on 18.01.2023.
//

import Foundation

class SearchVCViewModel {

    var tracks: SearchData?
    var indexPath: IndexPath?
    
    func numberOfRowsInSection() -> Int? {
        return tracks?.tracks.items.count
    }
    
    func playFromTrackList(index: Int) {
        PlaybackManager.shared.trackList = tracks?.tracks.items
        PlaybackManager.shared.playTrack(playIndex: index)
    }
    
    func fetchData(withQuery query: String, complition: @escaping() -> ())  {
        APIRequestManager.shared.searchTrack(with: query) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.tracks = data
                    complition()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
