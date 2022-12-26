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
        let loginView = LoginView<R>(router: router)
        let loginViewController = UIHostingController(rootView: loginView)
        return loginViewController
    }
    
    func start() {
        router.navigationController.show(primaryViewController, sender: true)
    }
}
