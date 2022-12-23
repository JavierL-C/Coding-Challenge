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
        let loginView = LoginView()
        let LoginViewController = UIHostingController(rootView: loginView)
        return LoginViewController
    }
    
    func start() {
        router.navigationController.pushViewController(primaryViewController, animated: true)
    }
}
