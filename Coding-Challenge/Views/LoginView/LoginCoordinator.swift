//
//  LoginCoordinator.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import UIKit
import SwiftUI

final class LoginCoordinator<R: AppRouter> {
    let router: R
    
    init(router: R) {
        self.router = router
    }
}

extension LoginCoordinator: Coordinator {
    var primaryViewController: UIViewController {
        let viewModel = LoginViewModel<R>()
        let loginView = LoginView(viewModel: viewModel)
        let loginViewController = UIHostingController(rootView: loginView)
        loginViewController.title = "Log in"
        return loginViewController
    }
    
    func start() {
        router.navigationController.pushViewController(primaryViewController, animated: true)
    }
}
