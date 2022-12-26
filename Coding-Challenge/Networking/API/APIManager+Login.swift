//
//  APIManage+Login.swift
//  Coding-Challenge
//
//  Created by Javier  on 23/12/22.
//

import Foundation
import UIKit
import Combine


protocol LoginStore {
    func createRequestToken() -> Future<RequestToken, Failure>
    func login(userName: String, password: String, token: String) -> Future<RequestToken, Failure>
}

extension APIManager: LoginStore {
    func createRequestToken() -> Future<RequestToken, Failure> {
        let path = "authentication/token/new"
        return Future { promise in
            guard let url = APIManager.buildURL(path: path) else {
                promise(.failure(.urlConstructError))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard let data = data, case .none = error else { promise(.failure(.urlConstructError)); return }
                do {

                    let decoder = JSONDecoder()
                    let requestToken = try decoder.decode(RequestToken.self, from: data)
                    promise(.success(requestToken))
                } catch {
                    promise(.failure(.APIError(error)))
                }
            }
            
            task.resume()
        }
    }
    
    func login(userName: String, password: String, token: String) -> Future<RequestToken, Failure> {
        let path = "authentication/token/validate_with_login"
        
        return Future { promise in
            guard let url = APIManager.buildURL(path: path) else {
                promise(.failure(.urlConstructError))
                return
            }
            
            let bodyData = [
                "username": userName,
                "password": password,
                "request_token": token
            ]

            let postData = try? JSONSerialization.data(withJSONObject: bodyData)

            let request = NSMutableURLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpMethod = "POST"
            request.httpBody = postData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let data = data, case .none = error else { promise(.failure(.urlConstructError)); return }
                do {

                    let decoder = JSONDecoder()
                    let requestToken = try decoder.decode(RequestToken.self, from: data)
                    promise(.success(requestToken))
                } catch {
                    promise(.failure(.APIError(error)))
                }
            }
            
            task.resume()
        }
    }
}
