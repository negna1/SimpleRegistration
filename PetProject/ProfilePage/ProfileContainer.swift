
//  
//  ProfileContainer.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//


import Foundation

final class ProfileContainer {
    static var profileController: ProfileController {
        let vc = ProfileController()
        let router = ProfileRouterImpl(controller: vc)
        let vm = ProfileViewModel(router: router)
        vc.bind(with: vm)
        return vc
    }
}
