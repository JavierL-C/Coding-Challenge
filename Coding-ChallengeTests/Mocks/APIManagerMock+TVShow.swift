//
//  APIManagerMock+TVShow.swift
//  Coding-ChallengeTests
//
//  Created by Javier  on 27/12/22.
//

import Foundation
import Combine

@testable import Coding_Challenge

extension APIManagerMock: TVShowsStore {
    func fetchTVShowsBy(filter: Coding_Challenge.FilterTVShows, page: Int = 1) -> Future<[Coding_Challenge.TVShow], Coding_Challenge.Failure> {
        return Future { promise in
            guard let urlPath = Bundle(for: APIManagerMock.self).url(forResource: "tvShows", withExtension: "json"),
                  let jsonString = (try? String(contentsOf: urlPath, encoding: .utf8)),
                  let data = jsonString.data(using: .utf8),
                  let tvShows = (try? JSONDecoder().decode([TVShow].self, from: data))
            else {
                promise(.failure(.decodingError))
                return }
            promise(.success(tvShows))
        }
    }
}
