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
        cell.rightArrowImage.image = UIImage(named: "PlayIconInactive")
        
        // выбор иконки
        cell.rightArrowImage.image = viewModel?.chooseButtonIcon(index: indexPath.row)
        guard let album = viewModel?.tracks?.tracks.items[indexPath.row].album else { return cell }
        let dishImage = album.images[0].url
        cell.loadingSpinner.startAnimating()
        cell.albumImage.image = .none
        cachedImage(url: dishImage) { image in
            DispatchQueue.main.async {
                cell.albumImage.image = image
                cell.loadingSpinner.stopAnimating()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel?.playFromTrackList(index: indexPath, for: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
