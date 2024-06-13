//
//  RepositoryListView.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 13/06/24.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedRepository: Repository? = nil

    var body: some View {
        List(viewModel.repositories, id: \.id) { repository in
            NavigationLink(destination: RepoDetailsView(repository: repository)) {
                VStack(alignment: .leading) {
                    Text(repository.name ?? "")
                        .font(.headline)
                    Text(repository.fullName ?? "")
                        .font(.subheadline)
                    if let description = repository.desc {
                        Text(description)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}
