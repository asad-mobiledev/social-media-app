//
//  Environement.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 16/09/2025.
//

import SwiftUI

private struct AppDIContainerKey: EnvironmentKey {
    static let defaultValue: AppDIContainer = AppDIContainer() // When SwiftUI can't find an explicitly injected value, it uses defaultValue. This helps previews work without manual DI.
    // test above feature by removing environment inject statement of DIContainer from SocialMediaApp struct
}

extension EnvironmentValues {
    var appDIContainer: AppDIContainer {
        get { self[AppDIContainerKey.self] }
        set { self[AppDIContainerKey.self] = newValue }
    }
}
