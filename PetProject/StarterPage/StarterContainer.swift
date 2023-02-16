//
//  StarterContainer.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Foundation

final class StarterContainer {
    static var controller: StarterController {
        let vc = StarterController()
        let router = StarterRouterImpl(controller: vc)
        let localUserData = LocalUsersData()
        let vm = StarterViewModel(userData: localUserData, router: router)
        vc.bind(with: vm)
        return vc
    }
}
