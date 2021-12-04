//
//  UserService.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 11/25/21.
//

import Firebase

typealias FirestoreCompletion = (Error?) -> Void

enum UserService {
    static func fetchUser(withUid uid: String, completion: @escaping (User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in

            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }

    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let snapshot = snapshot else { return }

            let users = snapshot.documents.map { User(dictionary: $0.data()) }
            completion(users)
        }
    }

    static func follow(uid: String, completion: @escaping (FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { _ in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }

    static func unFollow(uid: String, completion: @escaping (FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { _ in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }

    static func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { snapshot, _ in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }

    static func fetchUserStats(uid: String, completion: @escaping (UserStats) -> Void) {
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { snapshot, _ in
            let followers = snapshot?.documents.count ?? 0

            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
                let following = snapshot?.documents.count ?? 0

                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { snapshot, _ in
                    let posts = snapshot?.documents.count ?? 0
                    completion(UserStats(followers: followers, following: following, posts: posts))
                }
            }
        }
    }
}
