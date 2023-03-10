//
//  TutorialLastScreenVC.swift
//  MusicApp
//
//  Created by Владислав on 12.01.2023.
//

import Foundation
import UIKit

class TutorialScreenVC: UIViewController {
    
    var tutorualPage = 0
    
    enum Constants {
        static let firstScreenImage: String = "TutorImg1"
        static let secondScreenImage: String = "TutorImg2"
        
        static let welcomLabel: String = "Welcome to the world of music"
        static let downloadLabel: String = "Download and save your Favourit Music"
        
        static let firstText: String = "An application that will help you feel the world of music."
        static let lastText: String = "Get ready and press Start."
        
        static let nextButton: String = "Next"
        static let startButton: String = "Start"
    }
    
    private lazy var imageTutorialFirst: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.firstScreenImage)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var welcomLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.welcomLabel
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: K.Fonts.poppinsSemiBold, size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.firstText
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont(name: K.Fonts.poppinsRegular, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: K.BrandColors.greenGradientColor)
        button.setTitle(Constants.nextButton, for: .normal)
        button.titleLabel?.font = UIFont(name: K.Fonts.robotoRegular, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: K.Fonts.robotoRegular, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        setupViews()
        setConstraints()
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 21 / 255, green: 21 / 255, blue: 33 / 255, alpha: 1)
        view.addSubview(imageTutorialFirst)
        view.addSubview(welcomLabel)
        view.addSubview(textLabel)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageTutorialFirst.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            imageTutorialFirst.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90),
            imageTutorialFirst.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            
            welcomLabel.topAnchor.constraint(equalTo: imageTutorialFirst.bottomAnchor, constant: 24),
            welcomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            welcomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            textLabel.topAnchor.constraint(equalTo: welcomLabel.bottomAnchor, constant: 8),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            nextButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 41),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            nextButton.widthAnchor.constraint(equalToConstant: 68),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
    
    @objc
    private func nextButtonTapped() {
        imageTutorialFirst.image = UIImage(named: Constants.secondScreenImage)
        welcomLabel.text = Constants.downloadLabel
        textLabel.text = Constants.lastText
        nextButton.setTitle(Constants.startButton, for: .normal)
        skipButton.alpha = 0
        tutorualPage += 1
        
        if nextButton.currentTitle == Constants.startButton {
            UserDefaults.standard.set(true, forKey: "SEEN-TUTORIAL")
            if tutorualPage == 2 {
                DispatchQueue.main.async {
                    let vc = AuthManager.shared.choosePresentingVC()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
        }
    }
    
    
    
    @objc
    private func skipButtonTapped() {
        UserDefaults.standard.set(true, forKey: "SEEN-TUTORIAL")
        DispatchQueue.main.async {
            let vc = AuthManager.shared.choosePresentingVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        self.dismiss(animated: true)
        print("Skip button tapped")
    }
}
