//
//  ContentView.swift
//  RepoExplorer
//
//  Created by Abhishek Yadav on 12/06/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
