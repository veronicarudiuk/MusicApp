//
//  SearchResultsVC.swift
//  MusicApp
//
//  Created by Марс Мазитов on 15.01.2023.
//
import AVFoundation
import UIKit

class SearchResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var results: SearchData?
    var player: AVPlayer?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
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
        //setupUI()
        tableView.frame = view.bounds
    }
    
    func update(with results: SearchData) {
        self.results = results
        //guard let safeResults = self.results else { return }
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.tracks.items.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { fatalError() }
        cell.trackNameLabel.text = results?.tracks.items[indexPath.row].name
        cell.artistNameLabel.text = results?.tracks.items[indexPath.row].artists[0].name
        cell.backgroundColor = .clear
        
        guard let dishImage = results?.tracks.items[indexPath.row].album.images[0].url else { return cell }
        
        cachedImage(url: dishImage) { image in
            DispatchQueue.main.async {
                cell.albumImage.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: results?.tracks.items[indexPath.row].preview_url ?? "") else { return }
        print(url)
        player?.pause()
        player = AVPlayer(url: url)
        player?.play()
        player?.volume = 1
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
