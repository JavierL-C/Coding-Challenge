//
//  Actor.swift
//  Coding-Challenge
//
//  Created by Javier  on 26/12/22.
//

import Foundation

struct Actor: Codable, Equatable, Hashable {
    let id: Int
    let profilePath: String?
    let name: String
    let order: Int?
    
    var profileURL: URL? {
        return URL(string: APIManager.baseServiceImageURL + (profilePath ?? ""))
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case profilePath = "profile_path"
        case name
        case order
    }
}
