//
//  CoreDataStack.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 12/06/24.
//

import CoreData

struct CoreDataStack {
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "RepoExplorer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
