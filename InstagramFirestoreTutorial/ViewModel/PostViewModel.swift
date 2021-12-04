//
//  PostViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 12/1/21.
//

import Foundation

struct PostViewModel {
    let post: Post

    var imageUrl: URL? {
        URL(string: post.imageUrl)
    }

    var caption: String {
        post.caption
    }

    var likes: Int {
        post.likes
    }

    var likesLabelTextString: String {
        if post.likes != 1 {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
    }

    var userProfileImageUrl: URL? {
        URL(string: post.ownerImageUrl)
    }

    var username: String { post.ownerUsername }

    init(post: Post) {
        self.post = post
    }
}
