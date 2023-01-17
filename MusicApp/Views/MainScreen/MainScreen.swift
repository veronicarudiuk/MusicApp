//
//  MainScreen.swift
//  MusicApp
//
//  Created by vas on 16.01.2023.
//

import UIKit

class MainScreen: UIViewController, TabsDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  // MARK: - Properties

  let tabsView = TabsView()
  let recentlyplayed = RecentlyPlayedVC()
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.backgroundColor = .clear
    return cv
  }()

  var currentIndex = 0

  var backcolor: [UIColor] = [.red, .green, .yellow, .blue]


  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupTabsView()

    setupRecentlyPlayedTableView()

    setupCollectionView()
  }

  // MARK: - Setup UI

  private func setupTabsView() {
    view.addSubview(tabsView)
    tabsView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tabsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tabsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
      tabsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      tabsView.heightAnchor.constraint(equalToConstant: 50)
    ])

    tabsView.tabs = [
      Tab(title: "Recomendation", apiID: 1),
      Tab(title: "Trending", apiID: 2),
      Tab(title: "Beauty", apiID: 3),
      Tab(title: "Business", apiID: 4)
    ]

    tabsView.titleColor = .white
    tabsView.indicatorColor = .green
    tabsView.titleFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
    tabsView.delegate = self
    tabsView.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
  }

  private func setupRecentlyPlayedTableView() {
    view.addSubview(recentlyplayed.view)
    recentlyplayed.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      recentlyplayed.view.topAnchor.constraint(equalTo: tabsView.bottomAnchor, constant: 400),
      recentlyplayed.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      recentlyplayed.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      recentlyplayed.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }


  private func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.showsHorizontalScrollIndicator = false
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: tabsView.bottomAnchor, constant: 30),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 15),
      collectionView.heightAnchor.constraint(equalToConstant: 180)
    ])
  }

  // MARK: - UICollectionViewDataSource

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }


  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = backcolor[currentIndex]
    return cell
  }

  // MARK: - UICollectionViewDelegateFlowLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//    return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
    return CGSize(width: 165, height: 165)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 25
  }

  // MARK: - TabsDelegate

  func tabsViewDidSelectItemAt(position: Int) {
    print(tabsView.tabs[position].apiID)

    currentIndex = position
    collectionView.reloadData()
  }
}
