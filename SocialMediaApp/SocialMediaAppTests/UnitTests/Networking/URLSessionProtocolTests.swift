//
//  Untitled.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct URLSessionProtocolTests {
    @Test(.tags(.networking, .unit))
    func testProtocolConformance() async throws {
        // Given
        let urlSession = URLSession.shared
        
        // When & Then
        #expect(urlSession is URLSessionProtocol)
        
        // Test that protocol method is callable
        let request = URLSessionTestHelper.createTestURLRequest()
        let result = try await urlSession.asyncData(for: request)
        
        #expect(result.0 != nil) // Data
        #expect(result.1 != nil) // Response
        
        #expect(type(of: result.0) == Data?.self)
        #expect(type(of: result.1) == URLResponse?.self)
    }
    
    @Test(.tags(.networking, .unit))
    func testAsyncDataMethod() async throws {
        // Given
        let urlSession = URLSession.shared
        let request = URLSessionTestHelper.createTestURLRequest()
        
        // When
        let result = try await urlSession.asyncData(for: request)
        
        // Then
        #expect(result.0 != nil)
        #expect(result.1 != nil)
        
        if let httpResponse = result.1 as? HTTPURLResponse {
            #expect(httpResponse.statusCode == 200)
        }
        if let data = result.0 {
            #expect(data.count > 0)
            let json = try JSONSerialization.jsonObject(with: URLSessionTestHelper.createTestData(), options: .allowFragments)
            #expect(json is [String: Any])
        }
    }
}
