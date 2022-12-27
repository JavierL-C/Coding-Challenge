//
//  DetailCoordinator.swift
//  Coding-Challenge
//
//  Created by Javier  on 26/12/22.
//

import UIKit
import SwiftUI

final class DetailCoordinator<R: AppRouter> {
    
    let model: TVShow
    let router: R
    
    init(tvShow: TVShow, router: R) {
        self.model = tvShow
        self.router = router
    }
}

extension DetailCoordinator: Coordinator {
    var primaryViewController: UIViewController {
        let tvShowDetailView = TVShowDetailView(tvShow: model)
        let detailViewController = UIHostingController(rootView: tvShowDetailView)
        return detailViewController
    }
    
    func start() {
        router.navigationController.pushViewController(primaryViewController, animated: true)
        router.navigationController.navigationBar.tintColor = .white
        router.navigationController.setNavigationBarHidden(false, animated: true)
        router.navigationController.navigationBar.isTranslucent = false
        router.navigationController.navigationBar.barTintColor = UIColor(named: "Almost Black")
    }
}
