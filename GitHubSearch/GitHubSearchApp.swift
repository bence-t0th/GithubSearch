//
//  GitHubSearchApp.swift
//  GitHubSearch
//
//  Created by Bence Tóth on 09/04/2024.
//

import SwiftUI
import CustomAlertKit

@main
struct GitHubSearchApp: App {
    @StateObject var viewModel = RepositoryViewModel()
    
    var body: some Scene {
        WindowGroup {
            RepoSearchView(viewModel: viewModel)
                .snackbar(visible: $viewModel.showError) {
                    Text("Something went wrong!")
                        .foregroundStyle(.white)
                        .padding(16)
                        .background(.red.opacity(0.8))
                        .cornerRadius(16)
                }
        }
    }
}
