//
//  NetworkConfigTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/10/2025.
//

import Testing
@testable import SocialMediaApp

struct NetworkConfigTests {
    
    @Test(.tags(.networking, .unit))
    func testNetworkConfigInitialization() async throws {
        // Given
        let url = "https://www.example.com"
        // When
        let networkConfig = ApiDataNetworkConfig(baseURL: url)
        
        // Then
        #expect(networkConfig.baseURL == url)
        #expect(networkConfig.headers.isEmpty)
    }
    
    @Test(.tags(.networking, .unit))
    func testNetworkConfigurableProtocolConformance() async throws {
        // Given
        let url = "https://www.example.com"

        // When
        let networkConfig = ApiDataNetworkConfig(baseURL: url)
        
        // Then
        #expect(networkConfig is NetworkConfigurable)
        
    }
    
    @Test(.tags(.networking, .unit))
    func testNetworkConfigFullInitialization() async throws {
        // Given
        let url = "https://www.example.com"
        let headers = [
            "Authorization": "Bearer token123",
            "Content-Type": "application/json"
        ]
        // When
        let networkConfig = ApiDataNetworkConfig(baseURL: url, headers: headers)
        
        // Then
        #expect(networkConfig.baseURL == url)
        #expect(networkConfig.headers.count == 2)
        #expect(networkConfig.headers == headers)
    }
}
