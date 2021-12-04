//
//  Notification.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 12/4/21.
//

import Firebase

enum NotificationType: Int {
    case like
    case follow
    case comment

    var notificationMessage: String {
        switch self {
        case .like:
            return " liked your post."
        case .follow:
            return " started following you."
        case .comment:
            return " commented on your post."
        }
    }
}

struct Notification {
    let uid: String
    var postImageUrl: String?
    var postId: String?
    let timestamp: Timestamp
    let type: NotificationType
    let id: String
    let userProfileImageUrl: String
    let username: String
    var userIsFollowed = false

    init(dictionary: [String: Any]) {
        uid = dictionary["uid"] as? String ?? ""
        postImageUrl = dictionary["postImageUrl"] as? String ?? ""
        postId = dictionary["postId"] as? String ?? ""
        id = dictionary["id"] as? String ?? ""
        timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        userProfileImageUrl = dictionary["userProfileImageUrl"] as? String ?? ""
        username = dictionary["username"] as? String ?? ""
    }
}
