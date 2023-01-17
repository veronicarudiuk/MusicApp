//
//  RecentlyPlayedVC.swift
//  MusicApp
//
//  Created by vas on 16.01.2023.
//

import UIKit

class RecentlyPlayedVC: UIViewController {

  // MARK: - Properties
  private let recentlyplayed = UITableView()
  private let cellReuseIdentifier = "recentlyCell"
  private var musicData = testData
  private var cellView = RecentlyPlayCellView()

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpTableView()
    addTableViewConstraints()
  }

  // MARK: - TableView Delegate & DataSource
  private func setUpTableView() {
    recentlyplayed.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    recentlyplayed.dataSource = self
    recentlyplayed.delegate = self
    recentlyplayed.isScrollEnabled = false
    recentlyplayed.backgroundColor = .clear
    view.addSubview(recentlyplayed)
  }

  private func addTableViewConstraints() {
    recentlyplayed.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      recentlyplayed.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      recentlyplayed.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 13),
      recentlyplayed.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -13),
      recentlyplayed.heightAnchor.constraint(equalToConstant: 300)
    ])
  }
}

extension RecentlyPlayedVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return musicData.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
    let cellView = cell.viewWithTag(1) as? RecentlyPlayCellView ?? RecentlyPlayCellView()

    cellView.setData(musicData: musicData[indexPath.item])
    cell.contentView.addSubview(cellView)
    cell.contentView.backgroundColor = UIColor.gray
    cell.backgroundColor = UIColor.gray
    cell.clipsToBounds = true

    return cell
  }
}

extension RecentlyPlayedVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let verticalPadding: CGFloat = 10

    let maskLayer = CALayer()
    maskLayer.cornerRadius = 10
    maskLayer.backgroundColor = UIColor.black.cgColor
    maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
    cell.layer.mask = maskLayer
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 90
  }
}


