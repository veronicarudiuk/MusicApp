//
//  RecentlyPlayedCollectionView.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 19/01/2023.
//

import UIKit

final class RecentlyPlayedCollectionView: UICollectionView, UICollectionViewDelegate {
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

//MARK: - UICollectionViewDataSource
extension RecentlyPlayedCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RecentlyPlayedCell.reusedID, for: indexPath) as! RecentlyPlayedCell

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
