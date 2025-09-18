//
//  SocialMediaApp.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

@main
struct SocialMediaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var router = Router()
    private let appDIContainer = AppDIContainer()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                appDIContainer.createPostsListingScreen()
                    .navigationDestination(for: Router.AppRoute.self) { destination in
                        
                        switch destination {
                        case .postsListing: appDIContainer.createPostsListingScreen()
                        case .detail(let type): appDIContainer.createPostDetailScreen(type: type)
                        }
                    }
            }
            .environmentObject(router)
            .environment(\.appDIContainer, appDIContainer)
        }
    }
}
