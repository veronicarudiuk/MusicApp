//
//  FavoriteVC.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 09/01/2023.
//

import UIKit
import CoreData

class FavoriteVC: UIViewController {

  private lazy var tableView: FavoriteTableView = {
    let tableView = FavoriteTableView()
    return tableView
  }()
  private lazy var headerView: FavoriteHeaderView = {
    let headerView = FavoriteHeaderView()
    headerView.frame = CGRect(x: 0, y: 0, width: 10, height: 120)
    headerView.center.x = tableView.center.x
    return headerView
  }()


  override func viewDidLoad() {
    super.viewDidLoad()
    setup()

  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated) // No need for semicolon
    loadData()
    tableView.reloadData()
  }

}

// MARK: - Private func

private extension FavoriteVC {
  func setup() {
    view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
    //без этого при скролле меняются цвета таб бара и нав. бара
//    let appearanceTabBar = UITabBarAppearance()
//    appearanceTabBar.configureWithOpaqueBackground()
//    appearanceTabBar.backgroundColor = UIColor(named: K.BrandColors.tabBarBG)
//    self.tabBarController?.tabBar.standardAppearance = appearanceTabBar;
//    let appearanceNavBar = UINavigationBarAppearance()
//    appearanceNavBar.configureWithOpaqueBackground()
//    appearanceNavBar.backgroundColor = UIColor(named: K.BrandColors.darkBG)
//    navigationController?.navigationBar.standardAppearance = appearanceNavBar
//    navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

    view.addSubview(tableView)
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
    ])

    tableView.tableHeaderView = headerView
  }

  func loadData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<LikedSongs> = LikedSongs.fetchRequest()
    var data: [LikedSongs] = []
    do {
      data = try context.fetch(request)
    } catch {
      print("Error fetching data from Core Data")
    }

    var sections: [[FavoriteTableViewCellViewModel]] = []
    for item in data {
      guard let artist = item.artistName, let track = item.trackName else { return }
      let playing_now = (PlaybackManager.shared.isPlaying == true) && (PlaybackManager.shared.currentTrack?.name == item.trackName)
      sections.append([FavoriteTableViewCellViewModel(artist: artist, track: track, isPlaying: playing_now)])
    }
    let viewModel = FavoriteTableViewViewModel(sections: sections, header: FavoriteHeaderViewViewModel(icon: UIImage(named: "TutorImg2")))
    tableView.viewModel = viewModel
    headerView.viewModel = viewModel.header
  }
}


