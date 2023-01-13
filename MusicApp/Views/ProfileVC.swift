//
//  ProfileVC.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 09/01/2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(signOut))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        testAPI()
    }
    
    @objc func signOut() {
        UserDefaults.standard.removeObject(forKey: "access_token")
        self.dismiss(animated: true)
        DispatchQueue.main.async {
            let vc = LoginVC()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    //MARK - Test API
    func testAPI() {
        APIRequestManager.shared.getTrack(id: "11dFghVXANMlKmJXsNCbNl") { result in
            switch result {
            case .success(let model):
                print(model.display_name)
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
