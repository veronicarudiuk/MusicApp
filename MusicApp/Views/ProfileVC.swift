//
//  ProfileVC.swift
//  MusicApp
//
//  Created by Veronica Rudiuk on 09/01/2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    var userImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.borderColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 0.29).cgColor
        image.layer.borderWidth = 3
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var userNickname: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: K.Fonts.interSemiBold, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userPersonalInfo: UILabel = {
        let label = UILabel()
        label.text = "Personal Information:"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: K.Fonts.interSemiBold, size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var userName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: K.Fonts.interRegular, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var userEmail: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: K.Fonts.interRegular, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
  private lazy var privacyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy Policy", for: .normal)
        button.titleLabel?.font = UIFont(name: K.Fonts.interSemiBold, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(privacyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLayoutSubviews() {
        userImage.layer.cornerRadius = userImage.frame.width / 2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(signOut))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        setupViews()
        setConstraints()
        loadProfilePic()
        testAPI()
    }
    
    private func setupViews(){
        view.backgroundColor = UIColor(red: 0.082, green: 0.082, blue: 0.129, alpha: 1)
        view.addSubview(userImage)
        view.addSubview(userNickname)
        view.addSubview(userPersonalInfo)
        view.addSubview(userName)
        view.addSubview(userEmail)
        view.addSubview(privacyButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            userImage.heightAnchor.constraint(equalToConstant: 85),
            userImage.widthAnchor.constraint(equalToConstant: 85),
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            userNickname.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 16),
            userNickname.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 105),
            userNickname.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -105),
            
            userPersonalInfo.topAnchor.constraint(equalTo: userNickname.bottomAnchor, constant: 30),
            userPersonalInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userPersonalInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -160),
            
            userName.topAnchor.constraint(equalTo: userPersonalInfo.bottomAnchor, constant: 26),
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -252),
            
            userEmail.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 18),
            userEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            userEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -190),
            
            privacyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            privacyButton.widthAnchor.constraint(equalToConstant: 155),
            privacyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    @objc
    func privacyButtonTapped() {
        let alertController:UIAlertController = UIAlertController(title: "Music App Privacy Policy", message: Privacy.privacy, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
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
        APIRequestManager.shared.gerCurrentUserProfile { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.userNickname.text = model.display_name
                    self.userName.text = "Name: \(model.display_name)"
                    self.userEmail.text = "Email: \(model.email)"
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        
//        APIRequestManager.shared.getTrack(id: "11dFghVXANMlKmJXsNCbNl") { result in
//            switch result {
//            case .success(let model):
//                print(model.display_name)
//                break
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func loadProfilePic() {
        
        APIRequestManager.shared.gerCurrentUserProfile { result in
            switch result {
            case .success(let model):
                guard let imageURL = model.images.first?.url else {
                    print("No image found for user")
                    return
                }
                self.cachedImage(url: imageURL) { image in
                    DispatchQueue.main.async {
                        self.userImage.image = image
                    }
                }
            case .failure(let error):
                print("Error loading profile: \(error.localizedDescription)")
            }
        }
    }
    
}
