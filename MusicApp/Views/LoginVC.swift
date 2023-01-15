//
//  LoginVC.swift
//  MusicApp
//
//  Created by Марс Мазитов on 12.01.2023.
//

import UIKit

class LoginVC: UIViewController {
    
    private let authButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemGreen
        button.setTitle("Sign In with Spotify (включи VPN)", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 20)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: K.BrandColors.grayBG)
        view.addSubview(authButton)
        
        authButton.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
        authButton.frame =  CGRect(x: view.frame.size.width/2-150, y: view.frame.size.height-150, width: 300, height: 50)
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        let startColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        gradient.colors = [startColor, endColor]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    @objc func SignIn() {
        let vc = AuthVC()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        present(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Error", message: "Signing with Spotify fails", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alert, animated: true)
            return
        }
        
        DispatchQueue.main.async {
            let vc = TabBarVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        self.dismiss(animated: true)
        
    }
}
