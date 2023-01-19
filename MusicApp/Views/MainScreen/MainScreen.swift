//
//  MainScreen.swift
//  MusicApp
//
//  Created by vas on 16.01.2023.
//

import UIKit

class MainScreen: UIViewController, TabsDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    private lazy var titleLabelTop = UILabel()
    private lazy var titleLabelBottom = UILabel()
    private lazy var tabsView = TabsView()
    private lazy var recentlyplayed = RecentlyPlayedVC()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()
    
    private lazy var currentIndex = 0
    
    private lazy var backcolor: [UIColor] = [.red, .green, .yellow, .blue]
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        setUpTopSection()
        setupTabsView()
        
        setupRecentlyPlayedTableView()
        
        setupCollectionView()
    }
    
    // MARK: - Setup UI
    
    private func setUpTopSection() {
        var name = ""
        APIRequestManager.shared.gerCurrentUserProfile { result in
            switch result {
            case .success(let model):
                name = model.display_name
                print(name)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        titleLabelTop.text = "Hello \(name),"
        titleLabelTop.textColor = .white
        titleLabelTop.font = UIFont(name: K.Fonts.interSemiBold, size: 16)
        titleLabelTop.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabelBottom.text = "What you want to hear today?"
        titleLabelBottom.textColor = .white
        titleLabelBottom.font = UIFont(name: K.Fonts.interRegular, size: 14)
        titleLabelBottom.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabelTop)
        view.addSubview(titleLabelBottom)
        NSLayoutConstraint.activate([
            titleLabelTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabelTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            titleLabelBottom.topAnchor.constraint(equalTo: titleLabelTop.bottomAnchor, constant: 4),
            titleLabelBottom.leadingAnchor.constraint(equalTo: titleLabelTop.leadingAnchor)
        ])
}

private func setupTabsView() {
    view.addSubview(tabsView)
    tabsView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        tabsView.topAnchor.constraint(equalTo: titleLabelBottom.bottomAnchor, constant: 12),
        tabsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
        tabsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
        tabsView.heightAnchor.constraint(equalToConstant: 38)
    ])
    
    tabsView.tabs = [
        Tab(title: "Recomendation", apiID: 1),
        Tab(title: "Trending", apiID: 2),
        Tab(title: "Beauty", apiID: 3),
        Tab(title: "Business", apiID: 4)
    ]
    
    tabsView.titleColor = .white
    tabsView.indicatorColor = UIColor(named: K.BrandColors.blueColor) ?? .red
    tabsView.titleFont =  UIFont(name: K.Fonts.interMedium, size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .semibold)
    tabsView.delegate = self
    tabsView.collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .left)
}

private func setupCollectionView() {
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.showsHorizontalScrollIndicator = false
    NSLayoutConstraint.activate([
        collectionView.topAnchor.constraint(equalTo: tabsView.bottomAnchor, constant: 20),
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 21),
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 21),
        collectionView.heightAnchor.constraint(equalToConstant: 173)
    ])
}

    private func setupRecentlyPlayedTableView() {
        view.addSubview(recentlyplayed.view)
        recentlyplayed.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recentlyplayed.view.topAnchor.constraint(equalTo: tabsView.bottomAnchor, constant: 400),
            recentlyplayed.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recentlyplayed.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recentlyplayed.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
// MARK: - UICollectionViewDataSource

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
}


func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = backcolor[currentIndex]
    return cell
}

// MARK: - UICollectionViewDelegateFlowLayout

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //    return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height)
    return CGSize(width: 165, height: 165)
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 25
}

// MARK: - TabsDelegate

func tabsViewDidSelectItemAt(position: Int) {
    print(tabsView.tabs[position].apiID)
    
    currentIndex = position
    collectionView.reloadData()
}
}
