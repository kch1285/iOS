//
//  AuthManager.swift
//  WooriDuri
//
//  Created by chihoooon on 2021/11/09.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    public func insertUser(with user: UserInfo, completion: @escaping (Bool) -> Void) {
        let object: [String: Any] = ["전화번호": user.phoneNumber]
        database.child(user.emailAddress).setValue(object) { error, _ in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
