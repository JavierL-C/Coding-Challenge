//
//  APIManager+TVShowDetail.swift
//  Coding-Challenge
//
//  Created by Javier  on 26/12/22.
//

import Foundation
import Combine

protocol TVShowDetailStore {
    func fetchTVShowDetail(id: Int) -> Future<(season: [Season], creators: [Creator]), Failure>
    func fetchTVShowCast(id: Int) -> Future<[Actor], Failure>
}

extension APIManager: TVShowDetailStore {
    func fetchTVShowDetail(id: Int) -> Future<(season: [Season], creators: [Creator]), Failure> {
        let path = "tv/\(id)"
        
        return Future { promise in
            guard let url = APIManager.buildURL(path: path) else {
                promise(.failure(.urlConstructError)); return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard let data = data, case .none = error else { promise(.failure(.urlConstructError)); return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    let jsonDataSeasons = try JSONSerialization.data(withJSONObject: json["seasons"] as! [[String: Any]], options: .prettyPrinted)
                    let jsonDataCreators = try JSONSerialization.data(withJSONObject: json["created_by"] as! [[String: Any]], options: .prettyPrinted)
        
                    let decoder = JSONDecoder()
                    let seasons = try decoder.decode([Season].self, from: jsonDataSeasons)
                    let creators = try decoder.decode([Creator].self, from: jsonDataCreators)
                    
                    promise(.success((seasons, creators)))
                } catch {
                    promise(.failure(.APIError(error)))
                }
            }
            
            task.resume()
        }
    }
    
    func fetchTVShowCast(id: Int) -> Future<[Actor], Failure> {
        let path = "tv/\(id)/aggregate_credits"
        
        return Future { promise in
            
            guard let url = APIManager.buildURL(path: path) else {
                promise(.failure(.urlConstructError)); return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard let data = data, case .none = error else { promise(.failure(.urlConstructError)); return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let jsonData = try JSONSerialization.data(withJSONObject: json["cast"] as! [[String: Any]], options: .prettyPrinted)
                    
                    let decoder = JSONDecoder()
                    let tvShows = try decoder.decode([Actor].self, from: jsonData)
                    promise(.success(tvShows))
                } catch {
                    promise(.failure(.APIError(error)))
                }
            }
            
            task.resume()
        }
    }
}
