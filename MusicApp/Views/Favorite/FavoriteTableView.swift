//
//  FavoriteTableView.swift
//  MusicApp
//
//  Created by Даниил Симахин on 15.01.2023.
//

import UIKit

class FavoriteTableView: UITableView {
    
    var viewModel: FavoriteTableViewViewModel?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -  Private func

private extension FavoriteTableView {
    func setup() {
        backgroundColor = .clear
        dataSource = self
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
        estimatedRowHeight = 100
        rowHeight = UITableView.automaticDimension
        register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource

extension FavoriteTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.sections?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.sections?[section].count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.sections?[indexPath.section][indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        cell.viewModel = cellViewModel
        return cell
    }
}
