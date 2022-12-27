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
    static let baseServiceImageURL = "https://image.tmdb.org/t/p/original"

    static func buildURL(path: String, queryItems: [String: String] = [:]) -> URL? {
        var urlComponents = URLComponents(string: baseServiceURL + path)
        var items = [URLQueryItem(name: "api_key", value: apiKey)]
        
        queryItems.forEach {
            items.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents?.queryItems = items

        return urlComponents?.url
    }
}
