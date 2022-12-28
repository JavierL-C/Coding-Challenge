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
    func login(requestToken: RequestToken)
    func showHomeView()
}

final class LoginViewModel<R: AppRouter>: ObservableObject {
    var router: R?
    
    private let loginStore: LoginStore
    private var cancellables = Set<AnyCancellable>()
    
    @Published var userName = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var isLoginFail = false
    @Published var isLoginSuccess = false
    
    init(loginStore: LoginStore = APIManager()) {
        self.loginStore = loginStore
    }
}

extension LoginViewModel: LoginViewModelRepresentable {

    func requestToken() {
        isLoading = true
        loginStore.createRequestToken()
            .sink { completion in
                switch completion  {
                    case .finished:
                        break
                    case .failure(let failure):
                        DispatchQueue.main.async { [weak self] in
                            self?.isLoading = false
                            self?.isLoginFail = true
                        }
                        print("something went wrong " + failure.localizedDescription)
                        break
                }
            } receiveValue: { [unowned self] requestToken in
                login(requestToken: requestToken)
            }
            .store(in: &cancellables)
    }
    
    func login(requestToken: RequestToken) {
        let defaults = UserDefaults.standard
        
        loginStore.login(userName: userName, password: password, token: requestToken.token)
            .sink { [unowned self] completion in
                switch completion  {
                    case .finished:
                        break
                    case .failure(let failure):
                        print("something went wrong " + failure.localizedDescription)
                        DispatchQueue.main.async { [weak self] in
                            self?.isLoginFail = true
                            self?.isLoading = false
                        }
                        break
                }
            } receiveValue: { [unowned self] requestToken in
                defaults.setValue(requestToken.token, forKey: "token")
                defaults.setValue(requestToken.expiresAt, forKey: "expires")
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = false
                    self?.isLoginSuccess = true
                }
            }
            .store(in: &cancellables)
    }
    
    func showHomeView() {
        router?.process(route: .showHomeScreen)
    }
}
