//
//  FavoriteVC.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 09/01/2023.
//

import UIKit

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
        loadData()
    }
}

// MARK: - Private func

private extension FavoriteVC {
    func setup() {
        view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        
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
        let data = FavoriteTableViewViewModel(sections: [[FavoriteTableViewCellViewModel(artist: "1", track: "2"),
                                                          FavoriteTableViewCellViewModel(artist: "11", track: "22"),
                                                          FavoriteTableViewCellViewModel(artist: "111", track: "222"),
                                                          FavoriteTableViewCellViewModel(artist: "1111", track: "2222"),]],
        header: FavoriteHeaderViewViewModel(icon: UIImage(named: "TutorImg2")))
        tableView.viewModel = data
        headerView.viewModel = data.header
    }
}


