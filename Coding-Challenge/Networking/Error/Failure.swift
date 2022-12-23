//
//  Failure.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import Foundation

enum Failure: Error {
    case decodingError
    case urlConstructError
    case APIError(Error)
    case statusCode
}
