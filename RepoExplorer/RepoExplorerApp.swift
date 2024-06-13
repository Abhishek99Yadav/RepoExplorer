//
//  RepoExplorerApp.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 12/06/24.
//

import SwiftUI

@main
struct RepoExplorerApp: App {
    let persistenceController = CoreDataStack.shared

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
