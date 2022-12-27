//
//  TVShows.swift
//  Coding-Challenge
//
//  Created by Javier  on 24/12/22.
//

import Foundation

struct TVShow: Codable, Equatable, Hashable {
    let id: Int
    let backgroundPath: String?
    let voteAverage: Double
    let overview: String
    let name: String
    let firstAirDate: String
    
    var backgroundURL: URL? {
        return URL(string: APIManager.baseServiceImageURL + (backgroundPath ?? ""))
    }
    
    var description: String {
        return overview == "" ? "This TV show does not have overview" : overview
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case backgroundPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case name
        case firstAirDate = "first_air_date"
    }
}
