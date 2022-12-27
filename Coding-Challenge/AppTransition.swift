//
//  AppTransition.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import Foundation

enum AppTransition {
    
    case showLoginScreen
    case showHomeScreen
    case showDetailScreen
    
    var hasState: Bool {
        // If some transitions need to have state - perform case match logic here
        // Generally prefer stateless
        false
    }
    
    func coordinatorFor<R: AppRouter>(router: R) -> Coordinator? {
        switch self {
            case .showLoginScreen: return LoginCoordinator(router: router)
            case .showHomeScreen: return HomeCoordinator(router: router)
            case .showDetailScreen: return DetailCoordinator(router: router)
        }
    }
}

extension AppTransition: Hashable {

    var identifier: String {
        switch self {
            case .showLoginScreen: return "showMainScreen"
            case .showHomeScreen: return "showHomeScreen"
            case .showDetailScreen: return "showDetailScreen"
        }
    }
    
    static func == (lhs: AppTransition, rhs: AppTransition) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
