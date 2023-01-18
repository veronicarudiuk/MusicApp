//
//  SearchResultsVC.swift
//  MusicApp
//
//  Created by Марс Мазитов on 15.01.2023.
//
import AVFoundation
import UIKit

class SearchResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: SearchVCViewModel?
    {
        willSet {
            tableView.reloadData()
        }
    }
    
    var player: AVPlayer?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor =  UIColor(named: K.BrandColors.darkBG)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { fatalError() }
        cell.trackNameLabel.text = viewModel?.tracks?.tracks.items[indexPath.row].name
        cell.artistNameLabel.text = viewModel?.tracks?.tracks.items[indexPath.row].artists[0].name
        cell.backgroundColor = .clear
        
        guard let dishImage = viewModel?.tracks?.tracks.items[indexPath.row].album.images[0].url else { return cell }
        
        cachedImage(url: dishImage) { image in
            DispatchQueue.main.async {
                cell.albumImage.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let track = viewModel?.tracks?.tracks.items[indexPath.row] else { return }
        PlaybackManager.shared.setTrack(track)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

//MARK: - Private UI setup methods
//extension SearchResultsVC {
//    private func setupUI() {
//        view.addSubview(tableView)
//        tableView.separatorStyle = .none
//        tableView.allowsSelection = true
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//}
