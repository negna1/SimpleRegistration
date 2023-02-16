//  
//  ProfileViewModel.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Combine
import UIKit
import Components


protocol ProfileViewModelType {
    func transform(input: ProfileViewModelInput) -> ProfileViewModelOutput
}

struct ProfileViewModelInput {
    let selection: AnyPublisher<ProfileController.CellModelType, Never>
}


typealias ProfileViewModelOutput = AnyPublisher<ProfileState, Never>

enum ProfileState: Equatable {
    case idle([ProfileController.CellModelType])
    case showError(String)
    case isLoading(show: Bool)
}

final class ProfileViewModel: ProfileViewModelType {
    typealias CellType = ProfileController.CellModelType
    private var cancellables: [AnyCancellable] = []
    private var stateSubject = PassthroughSubject<ProfileState, Never>()
    private var currentDataSource: [CellType] = []
    private var additionalDataSource: [CellType] = []
    private var input: ProfileViewModelInput?
    private var hits: [Hit] = []
    var isEmailValid: Bool = false
    var isPasswordValid: Bool = false
    private var email: String = "" {
        didSet {
            isEmailValid = email.isValidEmail()
        }
    }
    private var password: String = "" {
            didSet {
                isPasswordValid = password.isPaswordValid()
            }
    }
    
    private let router: ProfileRouter?
    init(router: ProfileRouter) {
        self.router = router
    }
    
    func transform(input: ProfileViewModelInput) -> ProfileViewModelOutput {
        self.input = input
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        selectionSink(input: input)
        
        Task {
            await fetchIcons()
        }
        
        let idle: ProfileViewModelOutput = Just(.isLoading(show: true))
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
        return Publishers.Merge(idle, stateSubject).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func selectionSink(input: ProfileViewModelInput) {
        input.selection
            .sink {  [unowned self] cellType  in
                switch cellType {
                case .title(let hit):
                    self.router?.navigate2Details(hit: hit)
                }
            }.store(in: &cancellables)
    }
}

extension ProfileViewModel {
    var cellTypes: [CellType] {
        self.hits.map({.title(hit: $0)})
    }
}

extension ProfileViewModel {
    func fetchIcons() async {
        let request = URLRequest.icons(body: .init())
        let response = await URLSession.shared.fetchAsync(for: request, with: IconsResponse.self)
        stateSubject.send(.isLoading(show: false))
        switch response {
        case .success(let items):
            self.hits = items.hits.compactMap({$0})
            self.currentDataSource = cellTypes
            stateSubject.send(.idle(currentDataSource))
        case .failure(let failure):
            self.stateSubject.send(.showError(failure.localizedDescription))
        }
    }
}
