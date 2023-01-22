//
//  HomeVC.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 09/01/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    private lazy var titleLabelTop = UILabel()
    private lazy var titleLabelBottom = UILabel()
    
    private lazy var popularSongSectionTitle = UILabel()
    private lazy var popularSongsCollectionView = PopularSongsCollectionView()
    
    private lazy var recentlyPlaySectionTitle = UILabel()
    private lazy var recentlyPlayCollectionView = RecentlyPlayedCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        setUpTopSection()
        setupPopularSongCollecrionView()
        setupRecentlyPlaySection()
    }
    
    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.popularSongsCollectionView.reloadData()
            self.recentlyPlayCollectionView.reloadData()
        }
    }
    
    // MARK: - Setup UI
    
    private func setUpTopSection() {
        titleLabelTop.text = "Hello"
        APIRequestManager.shared.gerCurrentUserProfile { result in
            switch result {
            case .success(let model):
                let name = model.display_name
                DispatchQueue.main.async {
                    self.titleLabelTop.text = "Hello \(name)!"
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        titleLabelTop.textColor = .white
        titleLabelTop.font = UIFont(name: K.Fonts.interSemiBold, size: 16)
        
        titleLabelBottom.text = "What you want to hear today?"
        titleLabelBottom.textColor = .white
        titleLabelBottom.font = UIFont(name: K.Fonts.interRegular, size: 14)
        
        view.addSubview(titleLabelTop)
        view.addSubview(titleLabelBottom)
        titleLabelTop.translatesAutoresizingMaskIntoConstraints = false
        titleLabelBottom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabelTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabelTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            
            titleLabelBottom.topAnchor.constraint(equalTo: titleLabelTop.bottomAnchor, constant: 4),
            titleLabelBottom.leadingAnchor.constraint(equalTo: titleLabelTop.leadingAnchor)
        ])
    }
    
    private func setupPopularSongCollecrionView() {
        popularSongSectionTitle.text = "Trending now 🔥"
        popularSongSectionTitle.textColor = .white
        popularSongSectionTitle.font = UIFont(name: K.Fonts.interSemiBold, size: 16)
        
//        пока данные не подгрузятся будет видна загрузочная вью
        
        view.addSubview(popularSongSectionTitle)
        view.addSubview(popularSongsCollectionView)
        
        popularSongSectionTitle.translatesAutoresizingMaskIntoConstraints = false
        popularSongsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popularSongSectionTitle.topAnchor.constraint(equalTo: titleLabelBottom.bottomAnchor, constant: 32),
            popularSongSectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            
            popularSongsCollectionView.topAnchor.constraint(equalTo: popularSongSectionTitle.bottomAnchor, constant: 10),
            popularSongsCollectionView.leadingAnchor.constraint(equalTo: popularSongSectionTitle.leadingAnchor),
            popularSongsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularSongsCollectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupRecentlyPlaySection() {
        recentlyPlaySectionTitle.text = "Recently Played"
        recentlyPlaySectionTitle.textColor = .white
        recentlyPlaySectionTitle.font = UIFont(name: K.Fonts.interSemiBold, size: 16)
        
        view.addSubview(recentlyPlaySectionTitle)
        view.addSubview(recentlyPlayCollectionView)
        recentlyPlaySectionTitle.translatesAutoresizingMaskIntoConstraints = false
        recentlyPlayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyPlaySectionTitle.topAnchor.constraint(equalTo: popularSongsCollectionView.bottomAnchor, constant: 32),
            recentlyPlaySectionTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            
            recentlyPlayCollectionView.topAnchor.constraint(equalTo: recentlyPlaySectionTitle.bottomAnchor, constant: 10),
            recentlyPlayCollectionView.leadingAnchor.constraint(equalTo: recentlyPlaySectionTitle.leadingAnchor),
            recentlyPlayCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            recentlyPlayCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
