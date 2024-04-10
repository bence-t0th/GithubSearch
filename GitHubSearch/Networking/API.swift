//
//  API.swift
//  GitHubSearch
//
//  Created by Bence Tóth on 09/04/2024.
//

import Foundation
import Combine

struct API {
    static let baseURL: String = "https://api.github.com/search"
    
    static func search(name: String) -> AnyPublisher<RepoList, Error> {
        URLSession.shared.dataTaskPublisher(for: URL(string: "\(baseURL)/repositories?q=\(name)")!)
            .mapError { $0 }
            .map { $0.data }
            .decode(type: RepoList.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
