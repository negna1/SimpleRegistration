//  
//  RegistrationRouter.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Foundation

protocol RegistrationRouter {
    func navigate2Registration()
}

final class RegistrationRouterImpl: RegistrationRouter {
    private weak var controller: RegistrationController?
    
    init(controller: RegistrationController) {
        self.controller = controller
    }
    
    func navigate2Registration() {
        print("Navigation Here")
    }
}
