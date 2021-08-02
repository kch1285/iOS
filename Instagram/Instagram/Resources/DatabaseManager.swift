//
//  DatabaseManager.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    // MARK: - Public
    
    public func canCreateNewUser(with email: String, userName: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(with email: String, userName: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": userName], withCompletionBlock: { error, _ in
            if error == nil {
                completion(true)
                return
            }
            
            completion(false)
            return
        })
    }
    
    // MARK: - Private

}
