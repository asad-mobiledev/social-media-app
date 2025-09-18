//
//  Router.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/09/2025.
//

import SwiftUI

final class Router: ObservableObject {
    
    @Published var navPath = NavigationPath()
    
    enum AppRoute: Hashable {
        case postsListing
        case detail(type: MediaType)
    }
    
    func navigate(to destination: AppRoute) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
