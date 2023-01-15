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
    // gronse7@gmail.com
    // MusicApp112!
    private init () {}
    
    private var refreshingToken = false //токен в процессе обновления
    
    public var signInURL: URL? {
        let apiBase = "https://accounts.spotify.com/authorize"
        let string = "\(apiBase)?response_type=code&client_id=\(K.Auth.clientId)&scope=\(K.Auth.scopes)&redirect_uri=\(K.Auth.redirectURI)&show_dialog=true"
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
    
    public func exchangeCodeForToken(code: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: K.Auth.tokenApiURL) else { return }
        var components = URLComponents()
        var request = URLRequest(url: url)
        let basicToken = K.Auth.clientId+":"+K.Auth.clientSecret
        let data = basicToken.data(using: .utf8)
        
        guard let base64Token = data?.base64EncodedString() else {
            print("Fail to get base64Token")
            completion(false)
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
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponseData.self, from: data)
                self?.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }.resume()
    }
    
    private var onRefreshBlocks = [((String) -> Void)]()
    
    public func withValidToken(completion: @escaping (String) -> Void) {
        guard !refreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken {
            refreshAccessToken { [weak self] success in
                if let token = self?.accessToken, success {
                    completion(token)
                }
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    public func refreshAccessToken(completion: @escaping (Bool) -> Void) {
        guard !refreshingToken else {
            return
        }
        guard shouldRefreshToken else { completion(true); return } //refresh only if neded
        guard let refreshToken = self.refreshToken else { return }
        
        guard let url = URL(string: K.Auth.tokenApiURL) else { return }
        
        var components = URLComponents()
        var request = URLRequest(url: url)
        let basicToken = K.Auth.clientId+":"+K.Auth.clientSecret
        let data = basicToken.data(using: .utf8)
        
        refreshingToken = true

        guard let base64Token = data?.base64EncodedString() else {
            print("🟥🟥 Fail to get base64Token")
            completion(false)
            return
            
        }
        
        components.queryItems = [
        URLQueryItem(name: "grant_type", value: "refresh_token"),
        URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Basic \(base64Token)", forHTTPHeaderField: "Authorization")
        request.httpBody = components.query?.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            self?.refreshingToken = false
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponseData.self, from: data)
                self?.onRefreshBlocks.forEach { $0(result.access_token)}
                self?.onRefreshBlocks.removeAll()
                print("🟩🟩 Token refreshed")
                self?.cacheToken(result: result)
                completion(true)
            } catch {
                print("🟥🟥 \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
    }
    
    private func cacheToken(result: AuthResponseData) {
        UserDefaults.standard.set(result.access_token, forKey: "access_token")
        UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
        
        if let refreshTokenIs = result.refresh_token {
            UserDefaults.standard.set(refreshTokenIs, forKey: "refresh_token")
        }
    }
}
