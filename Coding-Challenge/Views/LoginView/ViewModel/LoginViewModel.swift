//
//  LoginViewModel.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import Foundation

protocol LoginViewModelRepresentable {
    func login(userName: String, password: String)
}

final class LoginViewModel<R: AppRouter> {
    weak var router: R?

}

extension LoginViewModel: LoginViewModelRepresentable {
    func login(userName: String, password: String) {
        print("User is login")
    }
    
}
