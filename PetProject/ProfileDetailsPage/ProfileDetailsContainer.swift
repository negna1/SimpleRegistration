
//  
//  ProfileDetailsContainer.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 16.02.23.
//


import Foundation

final class ProfileDetailsContainer {
    static func controller(hit: Hit) -> ProfileDetailsController {
        let vc = ProfileDetailsController()
        let router = ProfileDetailsRouterImpl(controller: vc)
        let vm = ProfileDetailsViewModel(hit: hit,
                                         router: router)
        vc.bind(with: vm)
        return vc
    }
}

