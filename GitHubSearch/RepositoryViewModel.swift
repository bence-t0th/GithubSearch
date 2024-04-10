//
//  RepositoryViewModel.swift
//  GitHubSearch
//
//  Created by Bence Tóth on 09/04/2024.
//

import Foundation
import Combine

class RepositoryViewModel: ObservableObject {
    @Published var results: [Item] = []
    @Published var loading = false
    @Published var showError = false
    
    var cancellables = Set<AnyCancellable>()
    
    func search(name: String) {
        loading = true
        API.search(name: name)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    self.loading = false
                case .failure(_):
                    self.showError = true
                    self.loading = false
                }
            }, receiveValue: { resp in
                self.results = resp.items ?? []
            })
            .store(in: &cancellables)
    }
}
