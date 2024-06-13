//
//  RepoDetailsView.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 13/06/24.
//

import SwiftUI

struct RepoDetailsView: View {
    let repository: Repository
    @StateObject var viewModel = HomeViewModel()
    @State private var repositoriesByContributor: [Repository] = []

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(repository.name ?? "")
                    .font(.title)

                Text(repository.fullName ?? "")
                    .font(.headline)

                if let description = repository.desc {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.gray)
                }

                if let htmlUrl = repository.htmlUrl {
                    Link("Project Link", destination: URL(string: "\(htmlUrl)") ?? URL(fileURLWithPath: "www.abinfo.co.in"))
                        .font(.body)
                        .foregroundColor(.blue)
                }

                Text("Contributor:")
                    .font(.headline)

                if let contributorLogin = repository.owner?.login {
                    Text(contributorLogin)
                        .font(.body)
                        .foregroundColor(.gray)
                }

                if repositoriesByContributor.isEmpty {
                    Text("No other repositories by \(repository.owner?.login ?? "Contributor")")
                        .foregroundColor(.gray)
                } else {
                    Text("Repositories by \(repository.owner?.login ?? "Contributor"):")
                        .font(.headline)
                        .padding(.top, 8)

                    // Display repositories by the contributor
                    ForEach(repositoriesByContributor, id: \.id) { repo in
                        Text(repo.name ?? "")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("Repository Details")
        .onAppear {
            // Fetch repositories associated with the contributor
            viewModel.fetchRepositories(query: repository.owner?.login ?? "", page: 1) {
                repositoriesByContributor = viewModel.repositories.filter { $0.owner?.login == repository.owner?.login }
            }
        }
    }
}
