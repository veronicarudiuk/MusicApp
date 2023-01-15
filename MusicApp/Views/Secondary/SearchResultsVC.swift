//
//  SearchResultsVC.swift
//  MusicApp
//
//  Created by Марс Мазитов on 15.01.2023.
//

import UIKit

class SearchResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var results: SearchData?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        tableView.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  UIColor(named: K.BrandColors.darkBG)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = results?.tracks.items[indexPath.row].name
        return cell
    }
    


}
