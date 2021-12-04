//
//  Comment.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 12/3/21.
//

import Firebase

struct Comment {
    let uid: String
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let commentText: String

    init(dictionary: [String: Any]) {
        uid = dictionary["uid"] as? String ?? ""
        username = dictionary["username"] as? String ?? ""
        profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        commentText = dictionary["comment"] as? String ?? ""
        timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
