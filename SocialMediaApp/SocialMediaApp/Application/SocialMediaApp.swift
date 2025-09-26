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
    let fileService: FileService = DefaultFileService(directory: .documents)
    
    var body: some Scene {
        WindowGroup {
            RootView(fileService: fileService)
        }
    }
}
