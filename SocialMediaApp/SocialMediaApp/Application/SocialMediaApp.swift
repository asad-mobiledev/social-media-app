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
    
    private let router = Router()
    private let appDIContainer: AppDIContainer
    
    init() {
        appDIContainer = AppDIContainer()
        appDIContainer.inject(router: router)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(router: router, appDIContainer: appDIContainer)
        }
    }
}
