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
    var tvShowsSubject: PassthroughSubject<[TVShow], Failure> { get }
}

final class HomeViewModel<R: AppRouter> {
    
    var router: R?
    let tvShowsSubject = PassthroughSubject<[TVShow], Failure>()
    
    private let tvShowsStore: TVShowsStore
    private var cancellables = Set<AnyCancellable>()
    
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
        
        tvShowsStore.fetchTVShowsBy(filter: filter, page: 1).sink { [unowned self] completion in
            switch  completion {
            case .finished:
                break
            case .failure(let failure):
                tvShowsSubject.send(completion: .failure(failure))
            }
        } receiveValue: { [unowned self] tvShows in
            DispatchQueue.main.async {
                self.tvShows = tvShows
            }
        }
        .store(in: &cancellables)
    }
}
