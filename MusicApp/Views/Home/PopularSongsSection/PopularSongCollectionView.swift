//
//  PopularSongCollectionView.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 19/01/2023.
//

import UIKit

final class PopularSongsCollectionView: UICollectionView, UICollectionViewDelegate {
    
    var viewModel = PopularSongsViewModel()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
//        self.viewModel.fetchData()
//        DispatchQueue.main.async {
            self.delegate = self
            self.dataSource = self
//        }
        
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        register(PopularSongCell.self, forCellWithReuseIdentifier: PopularSongCell.reusedID)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

//MARK: - UICollectionViewDataSource
extension PopularSongsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.albumData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: PopularSongCell.reusedID, for: indexPath) as! PopularSongCell

        let album = viewModel.albumData[indexPath.row]
        cell.albumNameLabel.text = album.name
        cell.songLabel.text = album.tracks?.items[0].name
        cell.playImage.image = viewModel.chooseButtonIcon(index: indexPath.row)
        let imageURL = album.images[0].url
        cachedImage(url: imageURL) { image in
            DispatchQueue.main.async {
                cell.songImageView.image = image
            }
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PopularSongsCollectionView: UICollectionViewDelegateFlowLayout {
    //    устанавливаю размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 160)
    }
}

//MARK: - ShowPecipeDataDelegate
 extension PopularSongsCollectionView {
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          print("PopularSongsCell did tap")
          print(indexPath)
          viewModel.playFromTrackList(index: indexPath, for: collectionView)
      }
  }
