//
//  DefaultNetworkSessionManagerTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultNetworkSessionManagerTests {
    
    @Test(.tags(.networking, .unit))
    func testInitialization() async throws {
        // Given & When
        let defaultNetworkSessionManager = DefaultNetworkSessionManager()
        
        // When
        #expect(defaultNetworkSessionManager != nil)
    }
    
    @Test(.tags(.networking, .unit))
    func testCustomInitialization() async throws {
        // Given
        let session = MockURLSession()
        let requestGenerator = MockURLRequestGenerator()
        
        // When
        let defaultNetworkSessionManager = DefaultNetworkSessionManager(session: session, requestGenerator: requestGenerator)
        
        // When
        #expect(defaultNetworkSessionManager != nil)
    }
    
    @Test(.tags(.networking, .unit))
    func testSuccessfulRequest() async throws {
        // Given
        let mockSession = MockURLSession()
        let mockRequestGenerator = MockURLRequestGenerator()
        let defaultNetworkSessionManager = DefaultNetworkSessionManager(session: mockSession, requestGenerator: mockRequestGenerator)
        
        let mockConfig = MockNetworkConfigurable()
        let mockRequest = MockNetworkRequest()
        let expectedData = "expected data".data(using: .utf8)
        let expectedResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockRequestGenerator.urlRequestToReturn = URLRequest(url: URL(string: "https://example.com")!)
        mockSession.dataToReturn = (expectedData, expectedResponse)
        
        // When
        let (data, response) = try await defaultNetworkSessionManager.request(with: mockConfig, request: mockRequest)
        
        // Then
        #expect(data == expectedData)
        #expect(response == expectedResponse)
        #expect(mockRequestGenerator.generateCallCount == 1)
        #expect(mockSession.asyncDataCallCount == 1)
    }
    
    @Test(.tags(.networking, .unit))
    func testSuccessfulRequestWithCustomHeadersBodyAndQueryParams() async throws {
        // Given
        let mockSession = MockURLSession()
        let mockRequestGenerator = MockURLRequestGenerator()
        let defaultNetworkSessionManager = DefaultNetworkSessionManager(session: mockSession, requestGenerator: mockRequestGenerator)
        
        let mockConfig = MockNetworkConfigurable(headers: ["Authorization": "Bearer token"])
        let bodyData = "body data".data(using: .utf8)
        let mockRequest = MockNetworkRequest(headerParameters: ["Content-Type": "application/json"], queryParameters: ["page": 1, "limit": 10], bodyParameters: ["mediaName": "image"])
        let expectedData = "expected data".data(using: .utf8)
        let expectedResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockRequestGenerator.urlRequestToReturn = URLRequest(url: URL(string: "https://example.com")!)
        mockSession.dataToReturn = (expectedData, expectedResponse)
        
        // When
        let (data, response) = try await defaultNetworkSessionManager.request(with: mockConfig, request: mockRequest)
        
        // Then
        #expect(data == expectedData)
        #expect(response == expectedResponse)
        #expect(mockRequestGenerator.generateCallCount == 1)
        #expect(mockSession.asyncDataCallCount == 1)
    }
    
    @Test(.tags(.networking, .unit))
    func testURLSessionError() async throws {
        let mockSession = MockURLSession()
        let mockGenerator = MockURLRequestGenerator()
        mockSession.errorToThrow = NetworkError.notConnected
        let manager = DefaultNetworkSessionManager(session: mockSession, requestGenerator: mockGenerator)
        
        let mockConfig = MockNetworkConfigurable()
        let mockRequest = MockNetworkRequest()
        
        await #expect(throws: NetworkError.self) {
            let (data, response) = try await manager.request(with: mockConfig, request: mockRequest)
            #expect(data == nil)
            #expect(response == nil)
        }
        #expect(mockSession.asyncDataCallCount == 1)
        #expect(mockGenerator.generateCallCount == 1)
    }
    
    @Test(.tags(.networking, .unit))
    func testRequestGeneratorError() async throws {
        let mockSession = MockURLSession()
        let mockGenerator = MockURLRequestGenerator()
        mockGenerator.errorToThrow = NetworkError.badURL
        let manager = DefaultNetworkSessionManager(session: mockSession, requestGenerator: mockGenerator)
        
        let mockConfig = MockNetworkConfigurable()
        let mockRequest = MockNetworkRequest()
        
        await #expect(throws: NetworkError.self) {
            let (data, response) = try await manager.request(with: mockConfig, request: mockRequest)
            #expect(data == nil)
            #expect(response == nil)
        }
        #expect(mockSession.asyncDataCallCount == 0)
        #expect(mockGenerator.generateCallCount == 1)
    }
}
