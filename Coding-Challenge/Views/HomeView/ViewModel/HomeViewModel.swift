//
//  HomeViewModel.swift
//  Coding-Challenge
//
//  Created by Javier  on 24/12/22.
//

import UIKit
import Combine

protocol HomeViewModelRepresentable {
    func fetchTVShows()
    var TVSHhowsSubject: PassthroughSubject<[TVShow], Failure> { get }
}

final class HomeViewModel<R: AppRouter> {
    
    var router: R?
    let TVSHhowsSubject = PassthroughSubject<[TVShow], Failure>()
    
    private let tvShowsStore: TVShowsStore
    private var cancellables = Set<AnyCancellable>()
    
    init(store: TVShowsStore = APIManager()) {
        tvShowsStore = store
    }
}

extension HomeViewModel: HomeViewModelRepresentable {
    func fetchTVShows() {
         print("Test")
    }
}
