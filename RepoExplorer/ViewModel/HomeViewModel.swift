//
//  HomeViewModel.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 12/06/24.
//


import Foundation
import CoreData

class HomeViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var error: Error?
    @Published var offlineDataAvailable: Bool = false
    
    // Fetch repositories with pagination
    func fetchRepositories(query: String, page: Int, completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(query)&page=\(page)&per_page=10") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                // Handle error
                DispatchQueue.main.async {
                    self.error = error
                }
                return
            }
            
            guard let data = data else {
                // Handle no data error
                DispatchQueue.main.async {
                    self.error = NSError(domain: "DataError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                let repositoriesDTO = result.items
                
                DispatchQueue.main.async {
                    let context = CoreDataStack.shared.viewContext
                    
                    // If it's the first page, save the data to Core Data
                    if page == 1 {
                        self.saveRepositoriesToCoreData(repositoriesDTO)
                        self.offlineDataAvailable = true
                    } else {
                        // Append data to Core Data
                        self.appendRepositoriesToCoreData(repositoriesDTO)
                    }
                    
                    // Fetch repositories from Core Data to update the UI
                    self.fetchRepositoriesFromCoreData()
                    
                    // Trigger completion handler
                    completion()
                }
            } catch {
                // Handle decoding error
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }.resume()
    }
    
    // Fetch repositories from Core Data
    func fetchRepositoriesFromCoreData() {
        let request: NSFetchRequest<Repository> = Repository.fetchRequest()
        do {
            self.repositories = try CoreDataStack.shared.viewContext.fetch(request)
        } catch {
            // Handle fetch error
            print("Error fetching repositories: \(error.localizedDescription)")
        }
    }
    
    // Clear CoreData
    func clearCoreData() {
        let context = CoreDataStack.shared.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Repository")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? context.execute(deleteRequest)
    }
    
    // Save repositories to Core Data
    func saveRepositoriesToCoreData(_ repositories: [RepositoryDTO]) {
        clearCoreData()
//        appendRepositoriesToCoreData(repositories.prefix(15))
        appendRepositoriesToCoreData(Array(repositories.prefix(15)))
    }
    
    // Append repositories to Core Data
    func appendRepositoriesToCoreData(_ repositories: [RepositoryDTO]) {
        let context = CoreDataStack.shared.viewContext
        for repoDTO in repositories {
            let repository = Repository(context: context)
            repository.id = Int32(repoDTO.id)
            repository.name = repoDTO.name
            repository.fullName = repoDTO.fullName
            repository.isPrivate = repoDTO.isPrivate
            repository.htmlUrl = repoDTO.htmlUrl
            repository.desc = repoDTO.description
            
            let owner = Owner(context: context)
            owner.login = repoDTO.owner.login
            repository.owner = owner
        }
        CoreDataStack.shared.saveContext()
    }
}
