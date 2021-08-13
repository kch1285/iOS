//
//  ConversationsModels.swift
//  Messenger
//
//  Created by chihoooon on 2021/07/31.
//

import Foundation

struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
