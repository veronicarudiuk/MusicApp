//
//  TabBarVC.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 09/01/2023.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tabBar.backgroundColor = UIColor(named: K.BrandColors.tabBarBG)
        setupVCs()
    }
    
//TODO: - change images for SearchVC
    
    func setupVCs() {
        viewControllers = [
            createNavController(for: MainScreen(), image: UIImage(named: "HomeInactive")!, selectedImage: UIImage(named: "HomeActive")!),
            createNavController(for: FavoriteVC(), image: UIImage(named: "FavoriteInctive")!, selectedImage: UIImage(named: "FavoriteActive")!),
            createNavController(for: PlayVC(), image: UIImage(named: "PlayInactive")!, selectedImage: UIImage(named: "PlayActive")!),
            createNavController(for: SearchVC(), image: UIImage(named: "SearchInactive")!, selectedImage: UIImage(named: "SearchActive")!),
            createNavController(for: ProfileVC(), image: UIImage(named: "ProfileInctive")!, selectedImage: UIImage(named: "ProfileActive")!),
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, image: UIImage, selectedImage: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        navController.tabBarItem.selectedImage = selectedImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        return navController
    }
}

