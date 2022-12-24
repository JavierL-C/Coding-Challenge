//
//  APIManager+TVShows.swift
//  Coding-Challenge
//
//  Created by Javier  on 24/12/22.
//

import Foundation
import Combine

protocol TVShowsStore {
    func fetchTVShowsBy(filter: FilterTVShows, page: Int) -> Future<[TVShow], Failure>
}

extension APIManager: TVShowsStore {
    func fetchTVShowsBy(filter: FilterTVShows, page: Int) -> Future<[TVShow], Failure> {
        return Future { promise in
            
        }
    }
}

enum FilterTVShows {
    case popular
    case topRated
    case onTV
    case airingToday
    
    var path: String {
        switch self {
            case .popular:
                return "tv/popular"
            case .topRated:
                return "tv/top_rated"
            case .onTV:
                return "tv/on_the_air"
            case .airingToday:
                return "tv/airing_today"
        }
    }
}
