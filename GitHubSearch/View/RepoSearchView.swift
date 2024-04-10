//
//  RepoSearchView.swift
//  GitHubSearch
//
//  Created by Bence Tóth on 09/04/2024.
//

import SwiftUI

struct RepoSearchView: View {
    
    @ObservedObject var viewModel: RepositoryViewModel
    @State var repoName: String = ""
    @State var selected: Item?
    
    var body: some View {
        NavigationView {
            if viewModel.loading {
                VStack {
                    ProgressView()
                        .progressViewStyle(.circular)
                    Text("Loading...")
                        .padding(.top, 16)
                }
                .frame(maxHeight: .infinity)

            } else {
                ScrollView {
                    HStack {
                        TextField("Search", text: $repoName)
                            .textFieldStyle(.roundedBorder)
                        
                        Button(action: {
                            viewModel.search(name: repoName)
                        }) {
                            Text("Search")
                                .font(.title3)
                        }
                    }
                    .padding(16)
                    .cornerRadius(8)
                    
                    if viewModel.results.isEmpty {
                        Text("No matches found")
                            .font(.title3)
                            .padding(.top, 64)
                    } else {
                        ForEach(viewModel.results) { result in
                            RepoListItem(item: result)
                                .onTapGesture {
                                    selected = result
                                }
                        }
                    }
                }
                .sheet(item: $selected, content: { selected in
                    RepoDetailView(item: selected)
                })
                .navigationTitle("GitHub Search")
            }
        }
    }
}

#Preview {
    RepoSearchView(viewModel: RepositoryViewModel())
}
