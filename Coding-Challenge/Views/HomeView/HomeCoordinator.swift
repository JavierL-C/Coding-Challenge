//
//  HomeCoordinator.swift
//  Coding-Challenge
//
//  Created by Javier  on 24/12/22.
//

import UIKit


final class HomeCoordinator<R: AppRouter> {
    let router: R
    
    init(router: R) {
        self.router = router
    }
}

extension HomeCoordinator: Coordinator {
    var primaryViewController: UIViewController {
        let viewModel = HomeViewModel<R>()
        viewModel.router = router
        let homeViewController = HomeViewController(viewModel: viewModel)
        return homeViewController
    }
    
    func start() {
        router.navigationController.setNavigationBarHidden(true, animated: true)
        router.navigationController.setViewControllers([primaryViewController], animated: true)
    }
}
