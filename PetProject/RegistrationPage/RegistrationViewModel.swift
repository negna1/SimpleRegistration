//  
//  RegistrationViewModel.swift
//  PetProject
//
//  Created by Nato Egnatashvili on 15.02.23.
//

import Combine
import UIKit
import Components

protocol RegistrationViewModelType {
    func transform(input: RegistrationViewModelInput) -> RegistrationViewModelOutput
}
struct RegistrationViewModelInput {
    
}

typealias RegistrationViewModelOutput = AnyPublisher<RegistrationState, Never>

enum RegistrationState: Equatable {
    case idle([RegistrationController.CellModelType])
    case validation([RegistrationController.CellModelType])
    case showSuccess(String)
    case showError(String)
    case loading(showIndicator: Bool)
}

final class RegistrationViewModel: RegistrationViewModelType {
    typealias CellType = RegistrationController.CellModelType
    private var cancellables: [AnyCancellable] = []
    private var stateSubject = PassthroughSubject<RegistrationState, Never>()
    private var currentDataSource: [CellType] = []
    private var additionalDataSource: [CellType] = []
    private let usersData: LocalUsersData
    
    private var isEmailValid: Bool = false
    private var isPasswordValid: Bool = false
    private var isAgeValid: Bool = false
    private var everythingIsValid: Bool {
        isEmailValid && isPasswordValid && isAgeValid
    }
    
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
    
    private var birthDate: Date? {
            didSet {
                isAgeValid = (Date() - (birthDate ?? Date())) > 18 && (Date() - (birthDate ?? Date())) < 99
            }
    }
    
    private let router: RegistrationRouter?
    init(userData: LocalUsersData,
         router: RegistrationRouter) {
        self.usersData = userData
        self.router = router
    }
    
    func transform(input: RegistrationViewModelInput) -> RegistrationViewModelOutput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        makeDataSource()
        Task {
            await  self.usersData.fetchRequest()
        }
        let idle: RegistrationViewModelOutput = Just(.idle(currentDataSource))
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
        return Publishers.Merge(idle, stateSubject).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func makeDataSource() {
        currentDataSource = [
            .textField(viewModel: emailTextField),
            .textField(viewModel: passwordTextField),
            .dateView(viewModel: agePicker),
            primaryButton
            ]
    }
    
    private func makeAdditionalDataSource() -> [CellType] {
       return  [!isEmailValid ? emailError : nil, !isPasswordValid ? passwordError : nil,
                !isAgeValid ? ageError : nil].compactMap({$0})
    }
}

extension RegistrationViewModel {
    func didTapRegistration() async {
        let user = LocalUsersData.User(email: email,
                                       password: password,
                                       birthDate: birthDate ?? Date())
        
        self.stateSubject.send(.loading(showIndicator: false))
        let res = await usersData.saveUser(object: user)
        switch res {
        case .success(_):
            self.stateSubject.send(.showSuccess(Constant.userCreated))
        case .failure(let failure):
            self.stateSubject.send(.showError(failure.localizedDescription))
        }
    }
}

//MARK: - Cell Types
extension RegistrationViewModel {
    private var emailError: CellType {
        .errorTitle(title: Constant.emailError, systemImageName: Constant.emailIconName)
    }
    
    private var passwordError: CellType {
        .errorTitle(title: Constant.passwordError, systemImageName: Constant.passwordIconName)
    }
    
    private var ageError: CellType {
        .errorTitle(title: Constant.ageError, systemImageName: Constant.ageIconName)
    }
    
    private var primaryButton: CellType {
        .button(viewModel: .init(title: Constant.registration, action: {
            
               
            self.stateSubject.send(.validation(self.makeAdditionalDataSource()))
            guard self.everythingIsValid else { return }
            self.stateSubject.send(.loading(showIndicator: true))
            Task {
                await self.didTapRegistration()
            }
        }, buttonType: .primaryButton))
    }
}

extension RegistrationViewModel {
    var emailTextField: TextFieldUI.ViewModel {
        .init(title: Constant.email,
              textFieldType: .email) { email in
            self.email = email
        }
    }
    
    var passwordTextField: TextFieldUI.ViewModel {
        .init(title: Constant.password,
              textFieldType: .password) { password in
            self.password = password
        }
    }
    
    var agePicker: DatePickerUI.ViewModel {
        .init(title: Constant.ageTitle) { date in
            self.birthDate = date
        }
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: rhs, to: lhs)
        return Double(components.year ?? 0)
    }
}
