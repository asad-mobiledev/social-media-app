//
//  NetworkSessionManagerTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct NetworkSessionManagerTests {
    
    @Test(.tags(.networking, .unit))
    func testProtocolConformance() async throws {
        // Given & When
        let defaultNetworkManager = NetworkSessionManagerTestHelper.createDefaultNetworkSessionManager()
        
        // Then
        #expect(defaultNetworkManager is NetworkSessionManager)
    }
    
    @Test(.tags(.networking, .unit))
    func testDefaultNetworkSessionManagerResponse() async throws {
        // Given & When
        let defaultRequest = try await NetworkSessionManagerTestHelper.createDefaultRequest()
        
        // Then
        #expect(defaultRequest.0 is Data?)
        #expect(defaultRequest.1 is URLResponse?)
    }
}
