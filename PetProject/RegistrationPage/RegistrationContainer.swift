
//  
//  RegistrationContainer.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//


import UIKit
import CoreData

final class RegistrationContainer {
    static var registrationController: RegistrationController {
        let vc = RegistrationController()
        let router = RegistrationRouterImpl(controller: vc)
        let localUserData = LocalUsersData()
        let vm = RegistrationViewModel(userData: localUserData, router: router)
        vc.bind(with: vm)
        return vc
    }
}
