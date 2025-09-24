//
//  Environment.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 22/09/2025.
//

import SwiftUI

private struct AppDIContainerKey: EnvironmentKey {
    // To allow passing DIContainer at Environment level and don't make it reactive by conforming to ObservableObject. We are initializing here with nil values. And we are making sure that before injecting it inside views we will initilize it fully.
    static let defaultValue: AppDIContainer = AppDIContainer(router: nil, databaseService: nil, fileService: nil)
}

extension EnvironmentValues {
    var appDIContainer: AppDIContainer {
        get { self[AppDIContainerKey.self] }
        set { self[AppDIContainerKey.self] = newValue }
    }
}
