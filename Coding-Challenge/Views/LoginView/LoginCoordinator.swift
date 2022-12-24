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
        viewModel.router = router
        let loginView = LoginView(viewModel: viewModel)
        let loginViewController = UIHostingController(rootView: loginView)
        return loginViewController
    }
    
    func start() {
        router.navigationController.show(primaryViewController, sender: true)
    }
}
