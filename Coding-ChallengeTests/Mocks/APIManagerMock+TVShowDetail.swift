//
//  APIManagerMock+TVShowDetail.swift
//  Coding-ChallengeTests
//
//  Created by Javier  on 27/12/22.
//

import Foundation
import Combine

@testable import Coding_Challenge

extension APIManagerMock: TVShowDetailStore {
    func fetchTVShowDetail(id: Int) -> Future<(season: [Coding_Challenge.Season], creators: [Coding_Challenge.Creator]), Coding_Challenge.Failure> {
        return Future { promise in
            guard let urlPathSeason = Bundle(for: APIManagerMock.self).url(forResource: "tvShowSeasons", withExtension: "json"),
                  let urlPathCreators = Bundle(for: APIManagerMock.self).url(forResource: "tvShowSeasons", withExtension: "json"),
                  let jsonStringSeason = (try? String(contentsOf: urlPathSeason, encoding: .utf8)),
                  let jsonStringCreators = (try? String(contentsOf: urlPathCreators, encoding: .utf8)),
                  let dataSeasons = jsonStringSeason.data(using: .utf8),
                  let dataCreators = jsonStringCreators.data(using: .utf8),
                  let seasons = (try? JSONDecoder().decode([Season].self, from: dataSeasons)),
                  let creators = (try? JSONDecoder().decode([Creator].self, from: dataCreators))
            else {
                promise(.failure(.decodingError))
                return }
            promise(.success((seasons, creators)))
        }
    }
    
    func fetchTVShowCast(id: Int) -> Future<[Coding_Challenge.Actor], Coding_Challenge.Failure> {
        return Future { promise in
            guard let urlPath = Bundle(for: APIManagerMock.self).url(forResource: "tvShowCast", withExtension: "json"),
                  let jsonString = (try? String(contentsOf: urlPath, encoding: .utf8)),
                  let data = jsonString.data(using: .utf8),
                  let tvShowCast = (try? JSONDecoder().decode([Actor].self, from: data))
            else {
                promise(.failure(.decodingError))
                return }
            promise(.success(tvShowCast))
        }
    }
}
