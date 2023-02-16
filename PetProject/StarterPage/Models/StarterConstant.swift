//
//  StarterConstant.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Foundation

extension StarterController {
    struct Constant {
        static let title: String = "Log In"
        static let error: String = "Error"
    }
}

extension StarterViewModel {
    struct Constant {
        static let emailError: String = "Email is not valid"
        static let passwordError: String = "Password should contains minimum 6 and maximum 12 symbols"
        static let emailIconName: String = "envelope"
        static let passwordIconName: String = "exclamationmark.lock.fill"
        
        static let email: String = "Email"
        static let password: String = "Password"
        static let registration: String = "Registration"
        static let logIn: String = "Log In"
        static let logInTitle: String = "IF YOU HAVE ACCCOUNT, PLEASE LOG IN"
    }
}
