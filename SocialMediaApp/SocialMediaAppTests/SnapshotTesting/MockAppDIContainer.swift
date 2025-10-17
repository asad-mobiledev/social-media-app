//
//  MockAppDIContainer.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 16/10/2025.
//

import SwiftUI
@testable import SocialMediaApp

class MockAppDIContainer: AppDIContainer {
    
    // Simple initializer - pass nil for everything since we're just taking snapshots
    override init(router: Router?, databaseService: DatabaseService?, fileService: FileService?) {
        super.init(
            router: router,
            databaseService: databaseService,
            fileService: fileService
        )
    }
    
    // Override methods to return simple mock views
    // These won't actually be called during snapshot tests
    // But we override them to prevent crashes if they are called
    // Add other overrides as needed...
}
