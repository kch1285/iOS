//
//  AuthManager.swift
//  Spotify
//
//  Created by chihoooon on 2021/08/14.
//

import Foundation

struct Constants {
    static let clientID = "49c41b6e730b4d8da439779638ed8041"
    static let clientSecret = "71d09de6d81a4bed9d7fa5df0d0b176a"
}

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {
        
    }
    
    public var signInUrl: URL? {
        let baseUrl = "https://accounts.spotify.com/authorize"
        let scope = "user-read-private"
        let redirectUri = "https://github.com/kch1285"
        let string = "\(baseUrl)?response_type=code&client_id=\(Constants.clientID)&scope=\(scope)&redirect_uri=\(redirectUri)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSigned: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
