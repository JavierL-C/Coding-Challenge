//
//  DetailCoordinator.swift
//  Coding-Challenge
//
//  Created by Javier  on 26/12/22.
//

import UIKit
import SwiftUI

final class DetailCoordinator<R: AppRouter> {
    let router: R
    
    init(router: R) {
        self.router = router
    }
}

extension DetailCoordinator: Coordinator {
    var primaryViewController: UIViewController {
        let tvShowDetailView = TVShowDetailView()
        let detailViewController = UIHostingController(rootView: tvShowDetailView)
        return detailViewController
    }
    
    func start() {
        router.navigationController.pushViewController(primaryViewController, animated: true)
    }
}
