//
//  TVShowViewModel.swift
//  Coding-Challenge
//
//  Created by Javier  on 26/12/22.
//

import Foundation
import Combine

final class TVShowDetailViewModel: ObservableObject {
    
    private let tvShowDetailStore: TVShowDetailStore
    private var cancellables = Set<AnyCancellable>()
    
    @Published var tvShow: TVShow?
    @Published var tvShowSeasons = [Season]()
    @Published var tvShowCreators = [Creator]()
    @Published var tvShowCast = [Actor]()
    
    init(tvShowDetailStore: TVShowDetailStore = APIManager()) {
        self.tvShowDetailStore = tvShowDetailStore
    }
}

extension TVShowDetailViewModel {
    
    func getTVShowDetail(id: Int) {
        tvShowDetailStore.fetchTVShowDetail(id: id)
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        print("some thing went wrong" + failure.localizedDescription)
                        break
                }
            } receiveValue: { [weak self] (season: [Season], creators: [Creator]) in
                DispatchQueue.main.async { [weak self] in
                    self?.tvShowCreators = creators
                    self?.tvShowSeasons = season
                }
            }.store(in: &cancellables)
    }
    
    func getTVShowCast(id: Int) {
        tvShowDetailStore.fetchTVShowCast(id: id)
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let failure):
                        print("some thing went wrong" + failure.localizedDescription)
                        break
                }
            } receiveValue: { [weak self] cast in
                DispatchQueue.main.async { [weak self] in
                    self?.tvShowCast = cast
                }
            }.store(in: &cancellables)
    }
}
