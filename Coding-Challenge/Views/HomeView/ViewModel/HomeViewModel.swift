//
//  HomeViewModel.swift
//  Coding-Challenge
//
//  Created by Javier  on 24/12/22.
//

import UIKit
import Combine

protocol HomeViewModelRepresentable {
    
}

final class HomeViewModel<R: AppRouter> {
    
    var router: R?
    
    private var cancellables = Set<AnyCancellable>()

}

extension HomeViewModel: HomeViewModelRepresentable {
    
}
