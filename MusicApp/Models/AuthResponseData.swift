//
//  AuthResponse.swift
//  MusicApp
//
//  Created by Марс Мазитов on 13.01.2023.
//

import Foundation

struct AuthResponseData: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
    
}

