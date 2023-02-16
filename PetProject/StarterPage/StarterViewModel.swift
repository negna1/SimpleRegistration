//
//  StarterViewModel.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Combine
import UIKit
import Components

protocol StarterViewModelType {
    func transform(input: StarterViewModelInput) -> StarterViewModelOutput
}
//I know I don't need this one but it is example how we will use Inputs.
struct StarterViewModelInput {
}

typealias StarterViewModelOutput = AnyPublisher<StarterPageState, Never>

enum StarterPageState: Equatable {
    case idle([StarterController.CellModelType])
    case validation([StarterController.CellModelType])
    case showError(String)
}

final class StarterViewModel: StarterViewModelType {
    typealias CellType = StarterController.CellModelType
    private var cancellables: [AnyCancellable] = []
    private var stateSubject = PassthroughSubject<StarterPageState, Never>()
    private var currentDataSource: [CellType] = []
    private var additionalDataSource: [CellType] = []
    private var isEmailValid: Bool = false
    private var isPasswordValid: Bool = false
    
    //MARK: - Computed property -
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
    //MARK: - Initilized property -
    private let userData: LocalUsersData
    private let router: StarterRouter?
    init(userData: LocalUsersData, router: StarterRouter) {
        self.router = router
        self.userData = userData
    }
    
    func transform(input: StarterViewModelInput) -> StarterViewModelOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        makeDataSource()
        let idle: StarterViewModelOutput = Just(.idle(currentDataSource))
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
        return Publishers.Merge(idle, stateSubject).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func makeDataSource() {
        currentDataSource = [
            .title(Constant.logInTitle),
            .textField(viewModel: emailTextField),
            .textField(viewModel: passwordTextField),
            shadowButton,
            primaryButton
        ]
    }
    
    private func makeAdditionalDataSource() -> [CellType] {
        return  [!isEmailValid ? emailError : nil, !isPasswordValid ? passwordError : nil].compactMap({$0})
    }
}

//MARK: - LogIn Call
extension StarterViewModel {
    private func didTapLogIn() async {
        guard (isEmailValid && isPasswordValid) else { return }
        let res = await userData.isUserExist(email: email, password: password)
        switch res {
        case .success(let userExist):
            guard userExist else {
                self.stateSubject.send(.showError(LocalUsersData.CoreDataError.UserExist.localizedDescription))
                return
            }
            self.router?.navigate2Profile()
        case .failure(let failure):
            self.stateSubject.send(.showError(failure.localizedDescription))
        }
    }
}

//MARK: - Cell Types
extension StarterViewModel {
    private var emailError: CellType {
        .errorTitle(title: Constant.emailError, systemImageName: Constant.emailIconName)
    }
    
    private var passwordError: CellType {
        .errorTitle(title: Constant.passwordError, systemImageName: Constant.passwordIconName)
    }
    
    private var primaryButton: CellType {
        .button(viewModel: .init(title: Constant.logIn, action: {
            self.stateSubject.send(.validation(self.makeAdditionalDataSource()))
            Task {
                await self.didTapLogIn()
            }
        }, buttonType: .primaryButton))
    }
    
    private var shadowButton: CellType {
        .button(viewModel: .init(title: Constant.registration, action: {
            self.router?.navigate2Registration()
        }, buttonType: .shadowButton))
    }
}

//MARK: - Textfield view Models-
extension StarterViewModel {
    private var emailTextField: TextFieldUI.ViewModel {
        .init(title: Constant.email,
              textFieldType: .email) { email in
            self.email = email
        }
    }
    
    private var passwordTextField: TextFieldUI.ViewModel {
        .init(title: Constant.password,
              textFieldType: .password) { password in
            self.password = password
        }
    }
}
