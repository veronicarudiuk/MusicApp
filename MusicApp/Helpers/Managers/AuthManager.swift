//
//  AuthManager.swift
//  MusicApp
//
//  Created by Марс Мазитов on 11.01.2023.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    // Почта и пароль от Спотифай для теста
    //gronse7@gmail.com
    //MusicApp112!
    private init () {}
    
    public var signInURL: URL? {
        let scopes = "user-read-private"
        let apiBase = "https://accounts.spotify.com/authorize"
        let string = "\(apiBase)?response_type=code&client_id=\(K.Auth.clientId)&scope=\(scopes)&redirect_uri=\(K.Auth.redirectURI)&show_dialog=true"
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(code: String, complection: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: K.Auth.tokenApiURL) else { return }
        var components = URLComponents()
        var request = URLRequest(url: url)
        let basicToken = K.Auth.clientId+":"+K.Auth.clientSecret
        let data = basicToken.data(using: .utf8)
        
        guard let base64Token = data?.base64EncodedString() else {
            print("Fail to get base64Token")
            complection(false)
            return
            
        }
        
        components.queryItems = [
        URLQueryItem(name: "grant_type", value: "authorization_code"),
        URLQueryItem(name: "code", value: code),
        URLQueryItem(name: "redirect_uri", value: K.Auth.redirectURI)
        ]
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64Token)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                complection(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponseData.self, from: data)
                self?.cacheToken(result: result)
                complection(true)
            } catch {
                print(error.localizedDescription)
                complection(false)
            }
        }.resume()
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken(result: AuthResponseData) {
        UserDefaults.standard.set(result.access_token, forKey: "access_token")
        UserDefaults.standard.set(result.refresh_token, forKey: "refresh_token")
        UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
}
