//
//  SearchVC.swift
//  MusicApp
//
//  Created by Марс Мазитов on 14.01.2023.
//

import UIKit

class SearchVC: UIViewController {
    
    private var searchController: UISearchController  = {
        let searchVC = UISearchController(searchResultsController: SearchResultsVC())
        searchVC.searchBar.placeholder = "Search music"
        searchVC.definesPresentationContext = true
        searchVC.searchBar.searchBarStyle = .minimal
        return searchVC
    }()
    
    private var  startLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
        label.text = "🎧 Let's start to search music"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.searchController = searchController
        navigationItem.searchController?.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.textColor = .white
        startLabel.center = view.center
        view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        view.addSubview(startLabel)
    }
    
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query != "" else { return }
        guard let resultsController = searchController.searchResultsController as? SearchResultsVC else { return }
        
        //resultsController.startLabel.text = query
        print(query)
        APIRequestManager.shared.searchTrack(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    resultsController.update(with: data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
}
