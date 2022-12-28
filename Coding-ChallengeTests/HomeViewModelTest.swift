//
//  HomeViewModelTest.swift
//  Coding-ChallengeTests
//
//  Created by Javier  on 27/12/22.
//

import XCTest
import Combine

@testable import Coding_Challenge

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModelRepresentable!
    private var tvShowsStore: TVShowsStore!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        tvShowsStore = APIManagerMock()
        viewModel = HomeViewModel<App>(store: tvShowsStore)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        tvShowsStore = nil
        viewModel = nil
    }
    
    func testLoadTVShows() throws {
        let loadTVShows = XCTestExpectation(description: "Load tv shows")
        var tvShows = [TVShow]()
        
        viewModel.tvShowsSubject.sink { _ in
            
        } receiveValue: { loadedTVShows in
            tvShows = loadedTVShows
            loadTVShows.fulfill()
        }.store(in: &cancellables)
        
        viewModel.fetchTVShows(filter: .popular)
        
        wait(for: [loadTVShows], timeout: 1)
        XCTAssertFalse(tvShows.isEmpty)
    }
}
