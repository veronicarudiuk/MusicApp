//
//  TabsView.swift
//  MusicApp
//
//  Created by vas on 16.01.2023.
//

import UIKit

protocol TabsDelegate {
  func tabsViewDidSelectItemAt(position: Int)
}

struct Tab {
  var title: String
  var apiID: Int

}

class TabsView: UIView {
  var tabs: [Tab] = [] {
    didSet {
      self.collectionView.reloadData()
    }
  }

  var titleColor: UIColor = .black {
    didSet {
      self.collectionView.reloadData()
    }
  }

  var titleFont: UIFont = UIFont.systemFont(ofSize: 10, weight: .regular) {
    didSet {
      self.collectionView.reloadData()
    }
  }


  var indicatorColor: UIColor = .black {
    didSet {
      self.collectionView.reloadData()
    }
  }

  var collectionView: UICollectionView!

  var delegate: TabsDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    createView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    createView()
  }

  private func createView() {
    // Create Flow Layout
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal

    // Create CollectionView
    collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .clear
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(TabCell.self, forCellWithReuseIdentifier: "TabCell")
    addSubview(collectionView)

    // ColletionView Constraints
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: self.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ])
  }
}

extension TabsView: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tabs.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCell", for: indexPath) as? TabCell else {
      return UICollectionViewCell()
    }
    cell.tabViewModel = Tab(title: tabs[indexPath.item].title, apiID: tabs[indexPath.item].apiID)


    // Change Title Color
    cell.tabTitle.font = titleFont
    cell.tabTitle.textColor = titleColor
    cell.indicatorColor = indicatorColor
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.tabsViewDidSelectItemAt(position: indexPath.item)
  }
}

extension TabsView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.frame.width / CGFloat(tabs.count), height: self.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
}

