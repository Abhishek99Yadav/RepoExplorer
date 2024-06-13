//
//  Persistence.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 12/06/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newRepository = Repository(context: viewContext)
            newRepository.id = Int32.random(in: 0..<1000)
            newRepository.name = "Sample Repo"
            newRepository.fullName = "Sample/Repo"
            newRepository.isPrivate = false
            newRepository.htmlUrl = URL(string: "https://github.com/sample/repo")!
            newRepository.desc = "This is a sample description"
            let newOwner = Owner(context: viewContext)
            newOwner.login = "sampleowner"
            newRepository.owner = newOwner
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RepoExplorer")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
