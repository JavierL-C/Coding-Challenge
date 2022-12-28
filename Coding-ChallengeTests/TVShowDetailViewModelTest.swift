//
//  TVShowDetailViewModelTest.swift
//  Coding-ChallengeTests
//
//  Created by Javier  on 27/12/22.
//

import XCTest
import Combine

@testable import Coding_Challenge

final class TVShowDetailViewModelTests: XCTestCase {
    private var viewModel: TVShowDetailViewModel!
    private var tvShowDetailStore: TVShowDetailStore!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        tvShowDetailStore = APIManagerMock()
        viewModel = TVShowDetailViewModel(tvShowDetailStore: tvShowDetailStore)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        tvShowDetailStore = nil
        viewModel = nil
    }
    
    func testLoadTVShowSeasons() throws {
        let loadTVShowSeason = XCTestExpectation(description: "Load tv show detail")
        var tvShowSeasons = [Season]()
        
        viewModel.$tvShowSeasons.dropFirst().sink { _ in
            
        } receiveValue: { loadedTVShowSeasons in
            tvShowSeasons = loadedTVShowSeasons
            loadTVShowSeason.fulfill()
        }.store(in: &cancellables)
        
        viewModel.getTVShowDetail(id: 1)
        
        wait(for: [loadTVShowSeason], timeout: 1)
        XCTAssertFalse(tvShowSeasons.isEmpty)
    }
    
    func testLoadTVShowCreators() throws {
        let loadTVShowCreator = XCTestExpectation(description: "Load tv show creators")
        var tvShowCreators = [Creator]()
        
        viewModel.$tvShowCreators.dropFirst().sink { _ in
            
        } receiveValue: { loadedTVShowCreators in
            tvShowCreators = loadedTVShowCreators
            loadTVShowCreator.fulfill()
        }.store(in: &cancellables)
        
        viewModel.getTVShowDetail(id: 1)
        
        wait(for: [loadTVShowCreator], timeout: 1)
        XCTAssertFalse(tvShowCreators.isEmpty)
    }
    
    func testLoadTVShowCast() throws {
        let loadTVShowCast = XCTestExpectation(description: "Load tv show cast")
        var tvShowCast = [Actor]()
        
        viewModel.$tvShowCast.dropFirst().sink { _ in
            
        } receiveValue: { loadedTVShowCast in
            tvShowCast = loadedTVShowCast
            loadTVShowCast.fulfill()
        }.store(in: &cancellables)
        
        viewModel.getTVShowCast(id: 1)
        
        wait(for: [loadTVShowCast], timeout: 1)
        XCTAssertFalse(tvShowCast.isEmpty)
    }
}
