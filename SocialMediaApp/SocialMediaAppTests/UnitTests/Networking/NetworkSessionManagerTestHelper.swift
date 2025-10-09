//
//  NetworkSessionManagerTestHelper.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp


final class NetworkSessionManagerTestHelper {
    static func createDefaultNetworkSessionManager() -> DefaultNetworkSessionManager {
        DefaultNetworkSessionManager()
    }
    
    static func createDefaultNetworkSessionManagerFromSharedURLSession() -> DefaultNetworkSessionManager {
        DefaultNetworkSessionManager(session: SharedURLSession.shared)
    }
    
    static func createDefaultParams() -> (ApiDataNetworkConfig, NetworkRequest) {
        let config = ApiDataNetworkConfig(baseURL: "google.com")
        let request = DefaultNetworkRequest(path: "https://www.google.com")
        return (config, request)
    }
    
    static func createDefaultRequest() async throws -> (Data?, URLResponse?) {
        let networkSessionManager = createDefaultNetworkSessionManager()
        let params = createDefaultParams()
        return try await networkSessionManager.request(with: params.0, request: params.1)
    }
    
//    static func createDummyResponseOfRequest() async throws -> (Data?, URLResponse?) {
//        let networkSessionManager = createDefaultNetworkSessionManager()
//        let params = createDefaultParams()
//        return try await networkSessionManager.request(with: params.0, request: params.1)
//    }
}
