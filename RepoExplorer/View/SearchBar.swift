//
//  SearchBar.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 13/06/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onCommit: () -> Void

    var body: some View {
        HStack {
            TextField("Search repositories", text: $searchText, onCommit: onCommit)
            
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            // Clear button
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                }
            }
        }
    }
}
