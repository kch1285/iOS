//
//  StorageManager.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/01.
//

import Foundation
import FirebaseStorage

public struct UserPost {
    let postType: UserPostType
}

enum UserPostType {
    case photo, video
}

public class StorageManager {
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    enum IGStorageManagerError: Error {
        case failedToDownload
    }
    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with references: String, completion: @escaping (Result<URL, Error>) -> Void) {
        bucket.child(references).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(IGStorageManagerError.failedToDownload))
                return
            }
            
            completion(.success(url))
        })
    }
}
