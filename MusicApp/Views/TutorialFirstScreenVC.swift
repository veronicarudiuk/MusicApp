//
//  TutorialFirstScreenVC.swift
//  MusicApp
//
//  Created by Владислав on 11.01.2023.
//

import Foundation
import UIKit


class TutorialFirstScreenVC: UIViewController {
    
    private lazy var imageTutorialFirst: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "TutorImg1")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var welcomLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the world of music"
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
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "GreenGradientColor")
        button.setTitle("Next", for: .normal)
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
            imageTutorialFirst.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90)
        ])
        NSLayoutConstraint.activate([
            welcomLabel.topAnchor.constraint(equalTo: imageTutorialFirst.bottomAnchor, constant: 24),
            welcomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            welcomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: welcomLabel.bottomAnchor, constant: 8),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 41),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            nextButton.widthAnchor.constraint(equalToConstant: 68),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
    }
    
    @objc
    private func nextButtonTapped() {
        let tutorialLastPage = TutorialLastScreenVC()
        tutorialLastPage.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(tutorialLastPage, animated: false, completion: nil)
    }
    
    @objc
    private func skipButtonTapped() {
        UserDefaults.standard.set(true, forKey: "SEEN-TUTORIAL")
        print("Skip button tapped")
    }
}
