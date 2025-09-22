//
//  Router.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/09/2025.
//

import SwiftUI

final class Router: ObservableObject {
    
    @Published var navPath = NavigationPath()
    @Published var activeSheet: SheetRoute?
    
    enum AppRoute: Hashable {
        case postsListing
        case detail(type: MediaType)
    }
    
    enum SheetRoute: Identifiable {
        case createPost
        
        var id: String {
            switch self {
            case .createPost:
                return "createPost"
            }
        }
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
    
    // MARK: - Sheets
    func present(sheet: SheetRoute) {
        activeSheet = sheet
    }
    
    @MainActor
    func dismissSheet() {
        activeSheet = nil
    }
    
}
