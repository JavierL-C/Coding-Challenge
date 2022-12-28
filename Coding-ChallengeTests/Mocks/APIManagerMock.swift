//
//  APIManagerMock.swift
//  Coding-ChallengeTests
//
//  Created by Javier  on 27/12/22.
//

import Foundation
import Combine

@testable import Coding_Challenge

final class APIManagerMock { }

extension APIManagerMock: LoginStore {
    func createRequestToken() -> Future<Coding_Challenge.RequestToken, Coding_Challenge.Failure> {
        return Future { promise in
            guard let urlPath = Bundle(for: APIManagerMock.self).url(forResource: "requestToken", withExtension: "json"),
                  let jsonString = (try? String(contentsOf: urlPath, encoding: .utf8)),
                  let data = jsonString.data(using: .utf8),
                  let requesToken = (try? JSONDecoder().decode(RequestToken.self, from: data))
            else {
                promise(.failure(.decodingError))
                return }
            promise(.success(requesToken))
        }
    }
    
    func login(userName: String, password: String, token: String) -> Future<Coding_Challenge.RequestToken, Coding_Challenge.Failure> {
        
        return Future { promise in
            guard let urlPath = Bundle(for: APIManagerMock.self).url(forResource: "requestToken", withExtension: "json"),
                  let jsonString = (try? String(contentsOf: urlPath, encoding: .utf8)),
                  let data = jsonString.data(using: .utf8),
                  let requesToken = (try? JSONDecoder().decode(RequestToken.self, from: data)),
                  userName == "javier",
                  password == "123456"
            else {
                promise(.failure(.decodingError))
                return }
            promise(.success(requesToken))
        }
    }
}
