//
//  ContentView.swift
//  GitHubSearch
//
//  Created by Bence Tóth on 09/04/2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: RepositoryViewModel
    @State var repoName: String = ""
    @State private var animation = false
    @State var selected: Item?
    @State var showDetail = false
    
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
                            animation.toggle()
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
    HomeView(viewModel: RepositoryViewModel())
}
