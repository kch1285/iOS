//
//  StorageManager.swift
//  Thoughts
//
//  Created by chihoooon on 2021/08/11.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()
    
    private init() {
        
    }
    
    public func uploadUserProfilePicture(email: String, image: UIImage?, comletion: @escaping (Bool) -> Void) {
        
    }
    
    public func downloadUrlForProfilePicture(user: User, completion: @escaping (URL?) -> Void) {
        
    }
    
    public func uploadBlogHeaderImage(post: BlogPost, image: UIImage?, comletion: @escaping (Bool) -> Void) {
        
    }
    
    public func downloadUrlForPostHeader(post: BlogPost, completion: @escaping (URL?) -> Void) {
        
    }
}
