//  
//  ProfileRouter.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Foundation

protocol ProfileRouter {
    func navigate2Details(hit: Hit)
}

final class ProfileRouterImpl: ProfileRouter {
    private weak var controller: ProfileController?
    
    init(controller: ProfileController) {
        self.controller = controller
    }
    
    func navigate2Details(hit: Hit) {
        self.controller?.navigationController?.pushViewController(ProfileDetailsContainer.controller(hit: hit), animated: false)
    }
   
}
