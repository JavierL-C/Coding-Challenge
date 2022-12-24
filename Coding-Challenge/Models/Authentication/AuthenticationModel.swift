//
//  AuthenticationModel.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import Foundation

struct RequestToken: Codable {
    let success: Bool
    let expiresAt: String
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case token = "request_token"
    }
}
