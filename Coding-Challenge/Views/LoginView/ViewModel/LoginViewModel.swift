//
//  LoginViewModel.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import Foundation
import Combine

protocol LoginViewModelRepresentable {
    func requestToken()
    func login(userName: String, password: String, requestToken: RequestToken)
    var loadSubject: PassthroughSubject<Bool, Never> { get }
    var requestTokenSubject: PassthroughSubject<RequestToken, Failure> { get }
}

final class LoginViewModel<R: AppRouter> {
    weak var router: R?
    
    private let loginStore: LoginStore
    private var cancellables = Set<AnyCancellable>()
    
    let requestTokenSubject = PassthroughSubject<RequestToken, Failure>()
    let loadSubject = PassthroughSubject<Bool, Never>()
    
    init(loginStore: LoginStore = APIManager()) {
        self.loginStore = loginStore
    }
}

extension LoginViewModel: LoginViewModelRepresentable {

    func requestToken() {
        loginStore.createRequestToken()
            .sink { completion in
                switch completion  {
                    case .finished:
                        break
                    case .failure(let failure):
                        print("something went wrong " + failure.localizedDescription)
                        break
                }
            } receiveValue: { [unowned self] requestToken in
                requestTokenSubject.send(requestToken)
            }
            .store(in: &cancellables)
    }
    
    func login(userName: String, password: String, requestToken: RequestToken) {
        let defaults = UserDefaults.standard
        
        loginStore.login(userName: userName, password: password, token: requestToken.token)
            .sink { completion in
                switch completion  {
                    case .finished:
                        break
                    case .failure(let failure):
                        print("something went wrong " + failure.localizedDescription)
                        break
                }
            } receiveValue: { [unowned self] requestToken in
                defaults.setValue(requestToken.token, forKey: "token")
                defaults.setValue(requestToken.expiresAt, forKey: "expires")
                loadSubject.send(false)
            }
            .store(in: &cancellables)
    }
    
}
