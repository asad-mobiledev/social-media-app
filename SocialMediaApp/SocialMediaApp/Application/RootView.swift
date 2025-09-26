//
//  RootView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 22/09/2025.
//

import SwiftUI

//We cannot do below work inside App -> SocialMediaApp because upto that point View is not initialized and hence a variable with wrapper @StateObject cannot be used there.
struct RootView: View {
    // router is @StateObject because this is Observable and we need to observe it when swicthing between views, ANd AppDIContainer does not have this use case, it only need to be passed down after initializing so we can use it's single instance to resolve different dependencies.
    let fileService: FileService
    @StateObject var router = Router()
    @State private var appDIContainer: AppDIContainer? = nil

    var body: some View {
        Group{
            if let container = appDIContainer, container.isFullyinitialized() {
                NavigationStack(path: $router.navPath) {
                    container.postsListingScreen
                        .navigationDestination(for: Router.AppRoute.self) { destination in
                            switch destination {
                            case .postsListing:
                                container.postsListingScreen
                            case .detail(let post):
                                container.createPostDetailScreen(post: post)
                            }
                        }
                }
                .environment(\.appDIContainer, container)
                .environmentObject(router)
            } else {
                ProgressView()
            }
        }
        .task {
            let databaseService = await MainActor.run {
                DefaultDatabaseService.configure(isStoredInMemoryOnly: false)
                return DefaultDatabaseService.shared
            }
            self.appDIContainer = AppDIContainer(router: router, databaseService: databaseService, fileService: fileService)
        }
    }
}
