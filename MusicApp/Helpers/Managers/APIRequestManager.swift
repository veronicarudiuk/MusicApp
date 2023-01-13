//
//  APIRequestManager.swift
//  MusicApp
//
//  Created by Марс Мазитов on 13.01.2023.
//

import Foundation

final class APIRequestManager {
    static let shared = APIRequestManager()
    
    private init () {}
    
    public func getTrack(id: String, completion: @escaping (Result<UserProfileData, Error>) -> Void) {
        createRequest(with: URL(string: K.API.baseAPIURL + "/tracks/\(id)"), type: .GET) { baseRequest in
            URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(result)
                    //completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }.resume()
        }
    }
    
    public func gerCurrentUserProfile(completion: @escaping (Result<UserProfileData, Error>) -> Void) {
        createRequest(with: URL(string: K.API.baseAPIURL + "/me"), type: .GET) { baseRequest in
            URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfileData.self, from: data)
                    completion(.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }.resume()
        }
    }
    
    //MARK - Private
    enum APIError: Error {
        case failedToGetData
    }
    enum HTTPMethod: String {
        case GET
        case POST
    }
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else { return }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
        
    }
}
