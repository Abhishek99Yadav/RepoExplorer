RepoExplorer

RepoExplorer is a SwiftUI-based iOS application that allows users to search for GitHub repositories and view details about them, including the contributors. Users can also see the repositories associated with a specific contributor. The app supports offline storage for the first 15 search results and implements pagination to fetch data in chunks.

Features

- Search GitHub Repositories: Search for repositories using the GitHub API.
- Repository List View: Display search results in a list view with pagination.
- Repository Details View: View detailed information about a selected repository, including the project's image, name, description, link, and contributors.
- Contributor Repositories: View repositories associated with a specific contributor.
- Offline Storage: Save the first 15 search results for offline viewing.
- SwiftUI and MVVM Architecture: Utilize SwiftUI for the UI and MVVM for architecture, with CoreData for persistence.

Screenshots

![Home Screen](path/to/home_screen.png)
![Repository Details Screen](path/to/details_screen.png)

Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

Installation

1. Clone the repository:
   
   git clone https://github.com/Abhishek99Yadav/RepoExplorer.git
   
2. Open the project in Xcode:
   
   cd RepoExplorer
   open RepoExplorer.xcodeproj
   
3. Build and run the project using Xcode.

Usage

1. Search for Repositories: Enter a keyword in the search bar on the home screen to search for GitHub repositories.
2. View Repository Details: Tap on a repository from the search results to view its details.
3. View Contributor Repositories: Tap on a contributor's name in the repository details to view repositories associated with the contributor.
4. Offline Access: The app will store the first 15 search results offline, which can be accessed without an internet connection.

Architecture

- MVVM: The project follows the Model-View-ViewModel architecture for a clear separation of concerns.
- CoreData: Used for offline storage of repository data.
- SwiftUI: Utilized for building the user interface.

Project Structure

```
RepoExplorer/
├── RepoExplorer/
│   ├── CoreDataStack.swift
│   ├── Persistence.swift
│   ├── RepoExplorerApp.swift
│   ├── ContentView.swift
│   ├── ViewModel/
│   │   └── HomeViewModel.swift
│   ├── Model/
│   │   └── Models.swift
│   ├── View/
│   │   ├── RepositoryListView.swift
│   │   ├── HomeView.swift
│   │   ├── SearchBar.swift
│   │   └── RepoDetailsView.swift
│   ├── Assets.xcassets/
│   └── Preview Content/
├── RepoExplorerTests/
│   └── RepoExplorerTests.swift
├── RepoExplorerUITests/
│   └── RepoExplorerUITests.swift
└── README.md
```

CoreData

- CoreDataStack.swift: Manages the CoreData stack, including the persistent container and context.
- Persistence.swift: Handles saving and fetching data from CoreData.

API Integration

- GitHub API: Fetches repositories and contributor details from the GitHub API.
  - [GitHub Search API](https://developer.github.com/v3/search/)

Contributing

1. Fork the project.
2. Create your feature branch (git checkout -b feature/AmazingFeature).
3. Commit your changes (git commit -m 'Add some AmazingFeature').
4. Push to the branch (git push origin feature/AmazingFeature).
5. Open a pull request.

Contact

Abhishek Yadav - [p.abhishek.yadav@outlook.com](mailto:p.abhishek.yadav@outlook.com)

Project Link: [https://github.com/Abhishek99Yadav/RepoExplorer.git](https://github.com/Abhishek99Yadav/RepoExplorer.git)
