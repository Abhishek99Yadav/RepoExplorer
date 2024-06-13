//
//  Models.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 12/06/24.
//

import Foundation

struct SearchResult: Codable {
    let items: [RepositoryDTO]
}

struct RepositoryDTO: Codable {
    let id: Int
    let name: String
    let fullName: String
    let isPrivate: Bool
    let owner: OwnerDTO
    let htmlUrl: URL
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlUrl = "html_url"
        case description
    }
}

struct OwnerDTO: Codable {
    let login: String
}
