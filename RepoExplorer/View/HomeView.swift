//
//  HomeView.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 12/06/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()
    @State private var searchText = ""
    @State private var showList = true

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText) {
                    viewModel.fetchRepositories(query: searchText, page: 1) {
                        debugPrint("Search Completion")
                    }
                }

                if showList {
                    RepositoryListView(viewModel: viewModel)
                }
            }
            .navigationBarTitle("Git Repositories")
        }
    }
}
