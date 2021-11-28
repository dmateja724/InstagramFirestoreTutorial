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
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var numberOfFollwers: NSAttributedString {
        return attributedStackText(value: user.stats.followers, label: "followers")
    }
    
    var numberOfPosts: NSAttributedString {
        return attributedStackText(value: 5, label: "posts")
    }
    
    var numberOfFollowing: NSAttributedString {
        return attributedStackText(value: user.stats.following, label: "following")
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
