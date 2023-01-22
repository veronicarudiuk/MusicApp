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

  var  startLabel: UILabel = {
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
    label.text = "🎧 Your favorite songs are stored here"
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont(name: "Roboto-Regular", size: 18)
    label.isHidden = false
    return label
  }()
  

  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name("loadData"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(reloadtable), name: NSNotification.Name("reloadtable"), object: nil)
    loadProfilePic()
    setup()

  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated) // No need for semicolon
    loadData()
    tableView.reloadData()
  }
  @objc func loadData() {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let request: NSFetchRequest<LikedSongs> = LikedSongs.fetchRequest()
    var data: [LikedSongs] = []
    do {
      data = try context.fetch(request)
    } catch {
      print("Error fetching data from Core Data")
    }

    startLabel.isHidden = !data.isEmpty
    var sections: [[FavoriteTableViewCellViewModel]] = []
    for item in data {
      guard let artist = item.artistName, let track = item.trackName, let trackID = item.trackId else { return }
      let playing_now = (PlaybackManager.shared.isPlaying == true) && (PlaybackManager.shared.currentTrack?.name == item.trackName)
      sections.append([FavoriteTableViewCellViewModel(artist: artist, track: track, trackID: trackID, isPlaying: playing_now)])
    }
    let viewModel = FavoriteTableViewViewModel(sections: sections, header: FavoriteHeaderViewViewModel(icon: self.headerView.viewModel?.icon ))
    tableView.viewModel = viewModel
    headerView.viewModel = viewModel.header
  }

  @objc func reloadtable() {
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

    tableView.tableHeaderView = headerView
    view.addSubview(tableView)
    view.addSubview(startLabel)

    startLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),

      startLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      startLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      startLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width - 20),
    ])

  }

  func loadProfilePic() {

    APIRequestManager.shared.gerCurrentUserProfile { result in
      switch result {
      case .success(let model):
        guard let imageURL = model.images.first?.url else {
          print("No image found for user")
          return
        }
        self.cachedImage(url: imageURL) { image in
          DispatchQueue.main.async {
            self.headerView.viewModel?.icon = image
          }
        }
      case .failure(let error):
        print("Error loading profile: \(error.localizedDescription)")
      }
    }
  }

}


