//
//  Season.swift
//  Coding-Challenge
//
//  Created by Javier  on 26/12/22.
//

import Foundation

struct Season: Codable, Equatable, Hashable {
    let id: Int
    let posterPath: String?
    let seasonNumber: Int
    let overview: String
    let name: String
    let airDate: String
    
    var posterURL: URL? {
        return URL(string: APIManager.baseServiceImageURL + (posterPath ?? ""))
    }
    
    var description: String {
        return overview == "" ? "This Season show does not have overview" : overview
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case overview
        case name
        case airDate = "air_date"
    }
}
