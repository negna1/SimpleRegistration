//
//  UserCoreDataModels + Type.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Foundation

//MARK: - User entity's main struct
extension LocalUsersData {
    struct User {
        let id: String = UUID().uuidString
        let email: String
        let password: String
        let birthDate: Date
    }
}

//MARK: - Custom error
extension LocalUsersData {
    enum CoreDataError: Error {
        case managedNotFound
        case NotSaved
        case notFoundUser
        case UserExist
    }
}
//MARK: - Custom error's localized error to get what was error
extension LocalUsersData.CoreDataError {
    var localizedDescription: String{
        switch self {
        case .managedNotFound:
            return "Managed Context not found"
        case .NotSaved:
            return "Can't save user"
        case .notFoundUser:
            return "User can't found"
        case .UserExist:
            return "User already exist"
        }
    }
}
