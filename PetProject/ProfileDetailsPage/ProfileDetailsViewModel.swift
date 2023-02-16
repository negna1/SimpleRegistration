//  
//  ProfileDetailsViewModel.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 16.02.23.
//

import Combine
import UIKit
import Components


protocol ProfileDetailsViewModelType {
    func transform() -> ProfileDetailsViewModelOutput
}

typealias ProfileDetailsViewModelOutput = AnyPublisher<ProfileDetailsState, Never>

enum ProfileDetailsState: Equatable {
    case idle([ProfileDetailsController.CellModelType])
}

final class ProfileDetailsViewModel: ProfileDetailsViewModelType {
    typealias CellType = ProfileDetailsController.CellModelType
    private var cancellables: [AnyCancellable] = []
    private var currentDataSource: [CellType] = []
    
    private let hit: Hit
    private let router: ProfileDetailsRouter?
    init(hit: Hit,
        router: ProfileDetailsRouter) {
        self.hit = hit
        self.router = router
    }
    
    func transform() -> ProfileDetailsViewModelOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        makeDataSource()
        return Just(.idle(currentDataSource))
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
    }

    private func makeDataSource() {
        currentDataSource = [
            .bigTitle(title: Constant.firstSectionTitle),
            .title(hit: hit),
            .bigTitle(title: Constant.secondSectionTitle),
            ] + 
        InfoType.allCases.map({CellType.infoRowItem(title: $0.title,
                                                    value: $0.getValue(hit: hit),
                                                    systemNameImage: $0.iconName)})
    }
}
