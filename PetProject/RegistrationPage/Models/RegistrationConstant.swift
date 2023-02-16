//
//  RegistrationConstants.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Foundation

extension RegistrationController {
    struct Constant {
        static let title: String = "Registration"
        static let error: String = "Error"
        static let success: String = "Success"
    }
}

extension RegistrationViewModel {
    struct Constant {
        static let registration: String = "Registration"
        static let email: String = "Email"
        static let password: String = "Password"
        
        static let emailError: String = "Email is not valid"
        static let passwordError: String = "Password needs 6-12 symbol"
        static let ageError: String = "Age restriction 18-99"
        static let emailIconName: String = "envelope"
        static let passwordIconName: String = "exclamationmark.lock.fill"
        static let ageTitle: String = "Select your birth date"
        static let ageIconName: String = "18.circle"
        
        static let userCreated: String = "User Create"
    }
}
