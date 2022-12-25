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
    func fetchTVShowsBy(filter: FilterTVShows, page: Int = 1) -> Future<[TVShow], Failure> {
        let path = filter.path
        return Future { promise in
            
            guard let url = APIManager.buildURL(path: path, queryItems: ["page": "\(page)"]) else {
                promise(.failure(.urlConstructError)); return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard let data = data, case .none = error else { promise(.failure(.urlConstructError)); return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let jsonData = try JSONSerialization.data(withJSONObject: json["results"] as! [[String: Any]], options: .prettyPrinted)
        
                    let decoder = JSONDecoder()
                    let tvShows = try decoder.decode([TVShow].self, from: jsonData)
                    promise(.success(tvShows))
                } catch {
                    promise(.failure(.APIError(error)))
                }
            }
            
            task.resume()
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
