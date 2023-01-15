//
//  SearchResultsVC.swift
//  MusicApp
//
//  Created by Марс Мазитов on 15.01.2023.
//

import UIKit

class SearchResultsVC: UIViewController {
    var  startLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 21))
        label.text = "🎧 d"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: K.BrandColors.darkBG)
        view.addSubview(startLabel)
        startLabel.center = view.center

        // Do any additional setup after loading the view.
    }
    


}
