//
//  AuthManager.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - Public
    public func registerNewUser(userName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.canCreateNewUser(with: email, userName: userName, completion: { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard result != nil, error == nil else {
                        completion(false)
                        return
                    }
                    
                    DatabaseManager.shared.insertNewUser(with: email, userName: userName, completion: { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        
                        completion(false)
                        return
                    })
                }
            }
            else {
                completion(false)
            }
        })
    }
    
    public func loginUser(userName: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                
                completion(true)
            }
        }
        else if let userName = userName {
            
        }
    }
    
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
}
