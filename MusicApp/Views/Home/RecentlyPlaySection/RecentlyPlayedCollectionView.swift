//
//  RecentlyPlayedCollectionView.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 19/01/2023.
//

import UIKit

final class RecentlyPlayedCollectionView: UICollectionView, UICollectionViewDelegate {
    
    private var viewModel = RecentlyPlayedViewModel()
//    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
//
//        for i in viewModel.recentlyPlayedTracks{
//                   context.delete(i)
//               }
//               saveItems()
    }
    
//    func saveItems() {
//        do {
//           try context.save()
//        } catch {
//           print("Error saving context \(error)")
//        }
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

//MARK: - UICollectionViewDataSource
extension RecentlyPlayedCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.loadTracks()
        return viewModel.recentlyPlayedTracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RecentlyPlayedCell.reusedID, for: indexPath) as! RecentlyPlayedCell
        
        var imageURL = String()
        
        viewModel.songInfo(indexPath: indexPath, cellSong: &cell.songLabel, cellAlbum: &cell.albumNameLabel, cellArtist: &cell.musicianNameLabel, cellTime: &cell.timeLabel, imageURL: &imageURL)
        
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
    //    устанавливаю размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 90)
    }
}

//MARK: - ShowPecipeDataDelegate
 extension RecentlyPlayedCollectionView {
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          print("RecentlyPlayedCell did tap")
      }
  }
