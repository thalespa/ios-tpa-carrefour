//
//  AppService.swift
//  ios-tpa-carrefour
//
//  Created by Thales Andrade on 19/05/23.
//

import Foundation

class AppService {
    let urlbase =  "https://api.github.com"
    
    func fetchDataUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let url = URL(string: String(format: "%@/users", urlbase))!
        print("url:\n\(url)")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                let str = String(data: data, encoding: .utf8)
                print("Received data:\n\(str ?? "")")
                do {
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let users = try decoder.decode([User].self, from: data)
                    completion(.success(users))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func fetchDataInfoUser(userURL: String, completion: @escaping (Result<InfoUserModel, Error>) -> Void) {
        let url = URL(string: String(format: "%@/users/%@", urlbase, userURL))!
        print("url:\n\(url)")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                let str = String(data: data, encoding: .utf8)
                print("Received data:\n\(str ?? "")")
                do {
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let users = try decoder.decode(InfoUserModel.self, from: data)
                    completion(.success(users))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func fetchDataReposityUser(reposityURL: String, completion: @escaping (Result<[ReposityUserModel], Error>) -> Void) {
        let url = URL(string: String(format: "%@", reposityURL))!
        print("url:\n\(url)")
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                let str = String(data: data, encoding: .utf8)
                print("Received data:\n\(str ?? "")")
                do {
                    let decoder = JSONDecoder()
                    //decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let reposityUserModel = try decoder.decode([ReposityUserModel].self, from: data)
                    completion(.success(reposityUserModel))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
