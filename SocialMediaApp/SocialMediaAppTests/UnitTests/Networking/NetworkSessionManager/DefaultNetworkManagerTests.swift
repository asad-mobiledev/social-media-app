//
//  DefaultNetworkManagerTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultNetworkManagerTests {
    
    @Test(.tags(.networking, .unit))
    func testInitializationAndProtocolConformance() async throws {
        // Given & When
        let mockConfig = MockNetworkConfigurable()
        let defaultNetworkManager = DefaultNetworkManager(config: mockConfig)
        
        // Then
        #expect(defaultNetworkManager != nil)
        #expect(defaultNetworkManager is NetworkManager)
    }
    
    @Test(.tags(.networking, .unit))
    func testCustomInitialization() async throws {
        // Given & When
        let mockConfig = MockNetworkConfigurable()
        let mockNetworkSession = MockNetworkSessionManager()
        let defaultNetworkManager = DefaultNetworkManager(config: mockConfig, sessionManager: mockNetworkSession)
        
        // Then
        #expect(defaultNetworkManager != nil)
    }
    
    @Test(.tags(.networking, .unit))
    func testFetchSuccessfull() async throws {
        // Given
        let mockConfig = MockNetworkConfigurable()
        let mockNetworkRequest = MockNetworkRequest()
        let mockSessionManager = MockNetworkSessionManager()
        let expectedData = "test data".data(using: .utf8)
        let expectedResponse = HTTPURLResponse(url: URL(string: "https://www.example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSessionManager.dataToReturn = (expectedData, expectedResponse)
        let defaultNetworkManager = DefaultNetworkManager(config: mockConfig, sessionManager: mockSessionManager)
        
        // When
        let data = try await defaultNetworkManager.fetch(request: mockNetworkRequest)
        
        // Then
        #expect(data != nil)
    }
    
    @Test(.tags(.networking, .unit))
    func testFetchFailure() async throws {
        // Given & When
        let mockConfig = MockNetworkConfigurable()
        let mockNetworkRequest = MockNetworkRequest()
        let mockSessionManager = MockNetworkSessionManager()
        let defaultNetworkManager = DefaultNetworkManager(config: mockConfig, sessionManager: mockSessionManager)
        
        mockSessionManager.dataToReturn = (nil, nil)
        mockSessionManager.errorToThrow = NetworkError.badURL
        
        // When & Then
        await #expect(throws: NetworkError.self) {
            try await defaultNetworkManager.fetch(request: mockNetworkRequest)
        }
    }
}
