//
//  APIManager.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import Foundation
import UIKit
import Combine

final class APIManager {
    static let baseServiceURL = "https://api.themoviedb.org/3/"
    static let apiKey = "b60f6e6a79a5b0ba7002d8dad8e72d8a"

    static func buildURL(path: String) -> URL? {
        return URL(string: baseServiceURL + path + "?api_key=" + apiKey)
    }
}
