//
//  AuthService.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 11/25/21.
//

import Firebase
import UIKit

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage
}

enum AuthService {
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }

    static func registerUser(withCredential credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                if let error = error {
                    print("DEBUG: Failed to register user \(error.localizedDescription)")
                    return
                }

                guard let uid = result?.user.uid else { return }
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullName,
                                           "profileImageUrl": imageUrl,
                                           "uid": uid,
                                           "username": credentials.userName]

                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
    
    static func resetPassword(withEmail email: String, completion: SendPasswordResetCallback?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
}
