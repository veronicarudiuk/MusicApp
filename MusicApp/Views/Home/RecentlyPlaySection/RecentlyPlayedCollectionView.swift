//
//  RecentlyPlayedCollectionView.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 19/01/2023.
//

import UIKit

final class RecentlyPlayedCollectionView: UICollectionView, UICollectionViewDelegate {
    
    private var viewModel = RecentlyPlayedViewModel()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        register(RecentlyPlayedCell.self, forCellWithReuseIdentifier: RecentlyPlayedCell.reusedID)
        translatesAutoresizingMaskIntoConstraints = false
        
        //self.viewModel.loadTracks()
        //bindViewModel() 
        print("reloadTable")
    }

  func reloadAll() {
    self.viewModel.loadTracks()
    bindViewModel()
    print("reloadTable")
  }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel() {
        viewModel.allTracks.bind { _ in
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

//MARK: - UICollectionViewDataSource
extension RecentlyPlayedCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        self.viewModel.loadTracks()
//        updateTable()
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RecentlyPlayedCell.reusedID, for: indexPath) as! RecentlyPlayedCell
        
      var imageURL = String()
      let song = viewModel.allTracks.value[indexPath.row]
      cell.songLabel.text = song.name
      cell.albumNameLabel.text = song.album?.name
      cell.musicianNameLabel.text = song.artists[0].name
      imageURL = song.album!.images[0].url

        //viewModel.songInfo(indexPath: indexPath, cellSong: &cell.songLabel, cellAlbum: &cell.albumNameLabel, cellArtist: &cell.musicianNameLabel, cellTime: &cell.timeLabel, imageURL: &imageURL)
        
        cell.playImage.image = viewModel.chooseButtonIcon(index: indexPath.row)
        
        cachedImage(url: imageURL) { image in
            DispatchQueue.main.async {
                cell.songImageView.image = image
            }
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension RecentlyPlayedCollectionView: UICollectionViewDelegateFlowLayout {
    //    ???????????????????????? ???????????? ????????????
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 42
        return CGSize(width: width, height: 90)
    }
}

//MARK: - ShowPecipeDataDelegate
 extension RecentlyPlayedCollectionView {
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//          print(indexPath)
          viewModel.playFromTrackList(index: indexPath, for: collectionView)
//          viewModel.playTrack(indexPath: indexPath)
//          let cell = collectionView.cellForItem(at: indexPath) as! RecentlyPlayedCell
//          if  cell.playImage.image == UIImage(named: "StopActive") {
//              PlaybackManager.shared.pause()
//              cell.playImage.image = UIImage(named: "PlayIconInactive")
//          } else {
//              cell.playImage.image = UIImage(named: "StopActive")}
//          print("RecentlyPlayedCell did tap")
      }
  }
