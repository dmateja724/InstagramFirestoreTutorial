//
//  Post.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 12/1/21.
//

import Firebase
import Foundation

struct Post {
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    let postId: String
    let ownerImageUrl: String
    let ownerUsername: String

    init(postId: String, dictionary: [String: Any]) {
        caption = dictionary["caption"] as? String ?? ""
        likes = dictionary["likes"] as? Int ?? 0
        imageUrl = dictionary["imageUrl"] as? String ?? ""
        ownerUid = dictionary["ownerUid"] as? String ?? ""
        timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.postId = postId
        ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        ownerUsername = dictionary["ownerUsername"] as? String ?? ""
    }
}
