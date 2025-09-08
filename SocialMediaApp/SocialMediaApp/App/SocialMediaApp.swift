//
//  SocialMediaApp.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 02/09/2025.
//

import SwiftUI

@main
struct SocialMediaApp: App {
    @StateObject private var router = Router()
    @StateObject private var homeScreenViewModel = HomeScreenViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                HomeScreen(homeScreenViewModel: homeScreenViewModel)
                    .navigationDestination(for: Router.AppRoute.self) { destination in
                        
                        switch destination {
                        case .home: HomeScreen(homeScreenViewModel: homeScreenViewModel)
                        case .detail(let type): PostDetailScreen(type: type)
                            
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
