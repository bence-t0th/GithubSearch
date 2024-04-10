//
//  RepoDetailView.swift
//  GitHubSearch
//
//  Created by Bence Tóth on 09/04/2024.
//

import SwiftUI

struct RepoDetailView: View {
    var item: Item?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                HStack {
                    AsyncImage(url: URL(string: item?.owner?.avatarURL ?? "")!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 64, height: 64)
                    .cornerRadius(16)
                    .onTapGesture {
                        UIApplication.shared.open(URL(string: item?.owner?.htmlURL ?? "")!)
                    }
                    
                    Link(destination: URL(string: item?.htmlURL ?? "")!, label: {
                        Text(item?.fullName ?? "Full name")
                            .font(.title3)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    })
                }
                
                Text(item?.description ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Label(String(item?.stargazersCount ?? 0), systemImage: "star")
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Updated at: " + (item?.updatedAt?.dropLast(10) ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                Label(String(item?.forksCount ?? 0), systemImage: "tuningfork")
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Created at: " + (item?.createdAt?.dropLast(10) ?? ""))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()

            }
            .padding(.horizontal, 16)
            .padding(.top, 32)
            .navigationTitle(item?.name ?? "")
        }

    }
}

#Preview {
    RepoDetailView()
}
