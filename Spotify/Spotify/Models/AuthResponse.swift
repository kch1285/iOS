//
//  AuthResponse.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/18.
//

import Foundation

struct AuthResponse: Codable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type: String
}
