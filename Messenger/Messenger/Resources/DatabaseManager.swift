//
//  DatabaseManager.swift
//  Messenger
//
//  Created by chihoooon on 2021/07/16.
//

import Foundation
import FirebaseDatabase


final class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
}

// MARK: - Account Management

extension DatabaseManager{
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)){
        database.child(email).observeSingleEvent(of: .value, with: { snapShot in
            guard snapShot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    /// Inserts new user to DB
    public func insertUser(with user: ChatAppUser){
        database.child(user.emailAddress).setValue([
            "First name": user.firstName,
            "Last name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
}
