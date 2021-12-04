//
//  User.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 11/25/21.
//

import Firebase
import Foundation

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String

    var isFollowed = false
    var stats: UserStats!

    var isCurrentUser: Bool { Auth.auth().currentUser?.uid == uid }

    init(dictionary: [String: Any]) {
        email = dictionary["email"] as? String ?? ""
        fullname = dictionary["fullname"] as? String ?? ""
        profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        username = dictionary["username"] as? String ?? ""
        uid = dictionary["uid"] as? String ?? ""

        stats = UserStats(followers: 0, following: 0, posts: 0)
    }
}

struct UserStats {
    let followers: Int
    let following: Int
    let posts: Int
}
