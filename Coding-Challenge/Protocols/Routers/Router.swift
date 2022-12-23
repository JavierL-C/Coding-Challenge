//
//  Router.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import UIKit

protocol Router: AnyObject {
    associatedtype Route
    var navigationController: UINavigationController { get set }
    func exit()
    func process(route: Route)
}

protocol AppRouter: Router where Route == AppTransition {
    
}
