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
        searchVC.searchBar.tintColor = .white
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
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        startLabel.center = view.center
        view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        view.addSubview(startLabel)

        //без этого при скролле меняются цвета таб бара и нав. бара
        let appearanceTabBar = UITabBarAppearance()
        appearanceTabBar.configureWithOpaqueBackground()
        appearanceTabBar.backgroundColor = UIColor(named: K.BrandColors.tabBarBG)
        self.tabBarController?.tabBar.standardAppearance = appearanceTabBar;
        let appearanceNavBar = UINavigationBarAppearance()
        appearanceNavBar.configureWithOpaqueBackground()
        appearanceNavBar.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        navigationController?.navigationBar.standardAppearance = appearanceNavBar
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query != "" else { return }
        guard let resultsController = searchController.searchResultsController as? SearchResultsVC else { return }
        
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
