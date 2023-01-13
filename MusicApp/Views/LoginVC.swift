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
        button.backgroundColor = .systemGreen
        button.setTitle("Spotify Sign In", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: K.BrandColors.grayBG)
        view.addSubview(authButton)
        authButton.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
        authButton.frame =  CGRect(x: view.frame.size.width/4, y: view.frame.size.height/2, width: 200, height: 50)
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
