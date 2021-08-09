//
//  Models.swift
//  Instagram
//
//  Created by chihoooon on 2021/08/04.
//

import Foundation

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postUrl: URL
    let caption: String?
    let likes: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
    let owner: User
}

struct User {
    let userName: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinedDate: Date
    let profilePicture: URL
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

enum Gender {
    case male, female, other
}

struct PostLike {
    let userName: String
    let postIdentifier: String
}

struct CommentLike {
    let userName: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let userName: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}

enum UserPostType: String {
    case photo = "사진", video = "동영상"
}
