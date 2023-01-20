//
//  SearchVCViewModel.swift
//  MusicApp
//
//  Created by Марс Мазитов on 18.01.2023.
//

import UIKit

class SearchVCViewModel {
    
    var tracks: SearchData?
    private var indexPath: IndexPath?
    private var previousIndex: IndexPath?
    
    func numberOfRowsInSection() -> Int? {
        return tracks?.tracks.items.count
    }
    
    func playFromTrackList(index: IndexPath, for table: UITableView) {
        
        let cell = table.cellForRow(at: index) as! SearchTableViewCell
        PlaybackManager.shared.pause()
        
        if previousIndex != nil {
            let previousCell = table.cellForRow(at: previousIndex!) as! SearchTableViewCell
            previousCell.rightArrowImage.image = UIImage(named: "PlayIconInactive")
        }
        
        guard previousIndex != index else { previousIndex = nil; return }

        previousIndex = index
        PlaybackManager.shared.trackList = tracks?.tracks.items
        PlaybackManager.shared.playTrack(playIndex: index.row)
        cell.rightArrowImage.image = UIImage(named: "StopActive")
    }
    
    func chooseButtonIcon(index: Int) -> UIImage {
            if PlaybackManager.shared.isPlaying == true {
                if PlaybackManager.shared.currentTrack?.id == tracks?.tracks.items[index].id {
                    return UIImage(named: "StopActive")!
                }
            }
     
            return UIImage(named: "PlayIconInactive")!

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
