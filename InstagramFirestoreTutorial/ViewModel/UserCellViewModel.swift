//
//  UserCellViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 11/25/21.
//

import Foundation

struct UserCellViewModel {
    private let user: User

    var profileImageUrl: URL? {
        URL(string: user.profileImageUrl)
    }

    var username: String {
        user.username
    }

    var fullname: String {
        user.fullname
    }

    init(user: User) {
        self.user = user
    }
}
