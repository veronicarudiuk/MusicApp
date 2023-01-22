//
//  SearchVC.swift
//  MusicApp
//
//  Created by Марс Мазитов on 14.01.2023.
//

import UIKit

class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel = SearchVCViewModel()
    var recentSearch = [String]()
    var lastReques: String?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        tableView.isHidden = true
        tableView.largeContentTitle = "Recent search"
        return tableView
    }()
    
    private var searchController: UISearchController  = {
        let searchVC = UISearchController(searchResultsController: SearchResultsVC())
        searchVC.searchBar.placeholder = "Search music"
        searchVC.definesPresentationContext = true
        searchVC.searchBar.searchBarStyle = .minimal
        searchVC.searchBar.tintColor = UIColor(named: K.BrandColors.greenGradientColor)
        searchVC.searchBar.searchTextField.backgroundColor = .systemGray6
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
    
    private lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.addTarget(self, action: #selector(clearButton(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 150, y: 100, width: 100, height: 40)
        button.isHidden = true

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "savedResults")
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
    }
    
    private func setupUI() {
        navigationItem.searchController = searchController
        //searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        startLabel.center = view.center
        view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        view.addSubview(startLabel)
        tableView.frame = view.bounds
        view.addSubview(tableView)
        view.addSubview(clearButton)
        
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
    
    @objc func clearButton(_ sender: UIButton) {
        UserDefaults.standard.set([], forKey: "recentSearch")
        recentSearch = []
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "savedResults", for: indexPath)
        cell.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        cell.textLabel?.text = recentSearch[indexPath.row]
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchController.searchBar.text = tableView.cellForRow(at: indexPath)?.textLabel?.text
    }
    
    
}

extension SearchVC: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text, query != "" else { return }
        self.lastReques = query
        guard let resultsController = searchController.searchResultsController as? SearchResultsVC else { return }
        print(query)
        viewModel.fetchData(withQuery: query) { [weak self] in
            DispatchQueue.main.async {
                resultsController.viewModel = self?.viewModel
            }
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = false
        clearButton.isHidden = false
        recentSearch = UserDefaults.standard.object(forKey: "recentSearch") as? [String] ?? []
        recentSearch.reverse()
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableView.isHidden = true
        clearButton.isHidden = true
        guard let lastReques = lastReques else { return }
        recentSearch.append(lastReques)
        UserDefaults.standard.set(recentSearch, forKey: "recentSearch")
        print(recentSearch)

    }
    
}
