//
//  NotificationViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 12/4/21.
//

import UIKit

struct NotificationViewModel {
    // MARK: - Properties

    var notification: Notification

    var postImageUrl: URL? {
        URL(string: notification.postImageUrl ?? "")
    }

    var profileImageUrl: URL? {
        URL(string: notification.userProfileImageUrl)
    }

    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.notificationMessage

        let attributedText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: " 2m", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }

    var shouldHidePostImage: Bool {
        notification.type == .follow
    }

    var followButtonText: String {
        notification.userIsFollowed ? "Following" : "Follow"
    }

    var followButtonBackgroundColor: UIColor {
        notification.userIsFollowed ? .white : .systemBlue
    }

    var followButtonTextColor: UIColor {
        notification.userIsFollowed ? .black : .white
    }

    // MARK: - Lifecycle

    init(notification: Notification) {
        self.notification = notification
    }
}
