//
//  TutorialLastScreenVC.swift
//  MusicApp
//
//  Created by Владислав on 12.01.2023.
//

import Foundation
import UIKit

class TutorialLastScreenVC: UIViewController {
    
    private lazy var imageTutorialLast: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "TutorImg2")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var downloadLabel: UILabel = {
        let label = UILabel()
        label.text = "Download and save your Favourit Music"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Poppins SemiBold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore."
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont(name: "Poppins Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "GreenGradientColor")
        button.setTitle("Start", for: .normal)
        button.titleLabel?.font = UIFont(name: K.Fonts.robotoRegular, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        setupViews()
        setConstraints()
    }
    
    func setupViews(){
        view.backgroundColor = UIColor(red: 21 / 255, green: 21 / 255, blue: 33 / 255, alpha: 1)
        view.addSubview(imageTutorialLast)
        view.addSubview(downloadLabel)
        view.addSubview(textLabel)
        view.addSubview(startButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageTutorialLast.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            imageTutorialLast.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            imageTutorialLast.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90)
        ])
        NSLayoutConstraint.activate([
            downloadLabel.topAnchor.constraint(equalTo: imageTutorialLast.bottomAnchor, constant: 24),
            downloadLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            downloadLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -29)
        ])
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: downloadLabel.bottomAnchor, constant: 8),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 41),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            startButton.widthAnchor.constraint(equalToConstant: 68),
            startButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc
    private func startButtonTapped() {
        UserDefaults.standard.set(true, forKey: "SEEN-TUTORIAL")
        print("Start button tapped")
    }
}
