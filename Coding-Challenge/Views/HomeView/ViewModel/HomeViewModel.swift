//
//  HomeViewModel.swift
//  Coding-Challenge
//
//  Created by Javier  on 24/12/22.
//

import UIKit
import Combine

protocol HomeViewModelRepresentable {
    func fetchTVShows(filter: FilterTVShows)
    func didTapItem(model: TVShow)
    func logOut()
    func setNavigationBarHidden()
    var tvShowsSubject: PassthroughSubject<[TVShow], Failure> { get }
}

final class HomeViewModel<R: AppRouter> {
    
    var router: R?
    let tvShowsSubject = PassthroughSubject<[TVShow], Failure>()
    
    private let tvShowsStore: TVShowsStore
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 0
    private var currentFilter: FilterTVShows = .popular
    
    private var tvShows = [TVShow]() {
        didSet {
            tvShowsSubject.send(tvShows)
        }
    }
    
    init(store: TVShowsStore = APIManager()) {
        tvShowsStore = store
    }
}

extension HomeViewModel: HomeViewModelRepresentable {
    func fetchTVShows(filter: FilterTVShows) {
        
        if currentFilter != filter {
            tvShows.removeAll()
            currentFilter = filter
            currentPage = 1
        } else {
            currentPage += 1
        }
        
        tvShowsStore.fetchTVShowsBy(filter: filter, page: currentPage).sink { [unowned self] completion in
            switch  completion {
            case .finished:
                break
            case .failure(let failure):
                tvShowsSubject.send(completion: .failure(failure))
            }
        } receiveValue: { [unowned self] tvShows in
            DispatchQueue.main.async {
                guard let setTVShows = NSOrderedSet(array: self.tvShows + tvShows).array as? [TVShow] else { return }
                self.tvShows = setTVShows
            }
        }
        .store(in: &cancellables)
    }
    
    func didTapItem(model: TVShow) {
        router?.process(route: .showDetailScreen(model: model))
    }
    
    func logOut() {
        router?.process(route: .showLoginScreen)
    }
    
    func setNavigationBarHidden() {
        router?.navigationController.setNavigationBarHidden(true, animated: true)
    }
}
