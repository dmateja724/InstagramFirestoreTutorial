//
//  PostViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 12/1/21.
//

import Foundation
import UIKit

struct PostViewModel {
    var post: Post

    var imageUrl: URL? {
        URL(string: post.imageUrl)
    }

    var caption: String {
        post.caption
    }

    var likes: Int {
        post.likes
    }

    var likeButtonTintColor: UIColor {
        post.didLike ? .red : .black
    }

    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
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
