//
//  StarterRouter.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Foundation

protocol StarterRouter {
    func navigate2Profile()
    func navigate2Registration()
}

final class StarterRouterImpl: StarterRouter {
    private weak var controller: StarterController?
    
    init(controller: StarterController) {
        self.controller = controller
    }
    
    func navigate2Registration() {
        DispatchQueue.main.async {
            self.controller?.navigationController?.pushViewController(RegistrationContainer.registrationController, animated: false)
        }
    }
    
    func navigate2Profile() {
        DispatchQueue.main.async {
            self.controller?.navigationController?.pushViewController(ProfileContainer.profileController, animated: false)
        }
    }
}
