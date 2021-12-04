//
//  AuthenticationViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Derrick Mateja on 11/23/21.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?

    var formIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false
    }

    var buttonBackgroundColor: UIColor {
        formIsValid ? .purple : .purple.withAlphaComponent(0.1)
    }

    var buttonTitleColor: UIColor {
        formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullName: String?
    var userName: String?

    var formIsValid: Bool {
        email?.isEmpty == false && password?.isEmpty == false && fullName?.isEmpty == false && userName?.isEmpty == false
    }

    var buttonBackgroundColor: UIColor {
        formIsValid ? .purple : .purple.withAlphaComponent(0.1)
    }

    var buttonTitleColor: UIColor {
        formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}
