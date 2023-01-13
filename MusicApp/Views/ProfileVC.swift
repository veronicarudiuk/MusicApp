//
//  ProfileVC.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 09/01/2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    private let signOutButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Sign out", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: K.BrandColors.grayBG)
        view.addSubview(signOutButton)
        signOutButton.addTarget(self, action: #selector(SignOut), for: .touchUpInside)
        signOutButton.frame =  CGRect(x: view.frame.size.width/4, y: view.frame.size.height/2, width: 200, height: 50)
    }
    
    @objc func SignOut() {
        UserDefaults.standard.removeObject(forKey: "access_token")
        self.dismiss(animated: true)
        DispatchQueue.main.async {
            let vc = LoginVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
}
