//
//  Environment.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 22/09/2025.
//

import SwiftUI


private struct AppDIContainerKey: EnvironmentKey {
    static let defaultValue: AppDIContainer = AppDIContainer()
}

extension EnvironmentValues {
    var appDIContainer: AppDIContainer {
        get { self[AppDIContainerKey.self] }
        set { self[AppDIContainerKey.self] = newValue }
    }
}
