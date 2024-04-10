//
//  RepoListItem.swift
//  GitHubSearch
//
//  Created by Bence Tóth on 09/04/2024.
//

import SwiftUI

struct RepoListItem: View {
    var item: Item?
    
    var body: some View {
        VStack {
            if let name = item?.fullName {
                Text(name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title3)
            }
            if let description = item?.description {
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.caption)
            }

            Label(String(item?.stargazersCount ?? 0), systemImage: "star")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)

            Text("Updated at: " + (item?.updatedAt?.dropLast(10) ?? ""))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
        }
        .padding(16)
        .background(.blue.opacity(0.1))
        .cornerRadius(16)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
        
    }
}

#Preview {
    RepoListItem()
}
