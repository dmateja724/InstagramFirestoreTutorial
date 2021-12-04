//
//  ProfileHeaderViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 11/25/21.
//

import Foundation
import UIKit

struct ProfileHeaderViewModel {
    let user: User

    var fullName: String {
        user.fullname
    }

    var profileImageUrl: URL? {
        URL(string: user.profileImageUrl)
    }

    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }

        return user.isFollowed ? "Following" : "Follow"
    }

    var followButtonBackgroundColor: UIColor {
        user.isCurrentUser ? .white : .systemBlue
    }

    var followButtonTextColor: UIColor {
        user.isCurrentUser ? .black : .white
    }

    var numberOfFollwers: NSAttributedString {
        attributedStackText(value: user.stats.followers, label: "followers")
    }

    var numberOfPosts: NSAttributedString {
        attributedStackText(value: user.stats.posts, label: "posts")
    }

    var numberOfFollowing: NSAttributedString {
        attributedStackText(value: user.stats.following, label: "following")
    }

    init(user: User) {
        self.user = user
    }

    func attributedStackText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
}
