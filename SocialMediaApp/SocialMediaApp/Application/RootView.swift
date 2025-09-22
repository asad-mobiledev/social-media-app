//
//  RootView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 22/09/2025.
//

import SwiftUI

//We cannot do below work inside App -> SocialMediaApp because upto that point View is not initialized and hence a variable with wrapper @StateObject cannot be used there.
struct RootView: View {
    @StateObject var router: Router
    let appDIContainer: AppDIContainer

    var body: some View {
        NavigationStack(path: $router.navPath) {
            appDIContainer.postsListingScreen
                .navigationDestination(for: Router.AppRoute.self) { destination in
                    switch destination {
                    case .postsListing:
                        appDIContainer.postsListingScreen
                    case .detail(let type):
                        appDIContainer.createPostDetailScreen(type: type)
                    }
                }
        }
        .environment(\.appDIContainer, appDIContainer)
        .environmentObject(router)
    }
}
