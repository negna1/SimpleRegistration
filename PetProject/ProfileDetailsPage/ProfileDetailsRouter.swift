//  
//  ProfileDetailsRouter.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 16.02.23.
//

import Foundation

protocol ProfileDetailsRouter {
	func navigate2()
}

class ProfileDetailsRouterImpl: ProfileDetailsRouter {
    private weak var controller: ProfileDetailsController?
    
    init(controller: ProfileDetailsController) {
        self.controller = controller
    }
    
    func navigate2() {
        print("Navigation Here")
    }
}
