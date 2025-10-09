//
//  URLRequestCreatorTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct URLRequestCreatorTests {
    
    @Test(.tags(.networking, .unit))
    func testURLRequestGeneratorProtocolConformance() async throws {
        // Given & When
        let generator = DefaultURLRequestGenerator()
        let config = URLRequestCreatorHelper.createMockConfig()
        let request = URLRequestCreatorHelper.createMockNetworkRequest()
        
        // Then
        #expect(generator is URLRequestGenerator)
        let urlRequest = try generator.generateURLRequest(with: config, from: request)
        #expect(urlRequest.url != nil)
        #expect(urlRequest.httpMethod == "GET")
    }
    
    @Test(.tags(.networking, .unit))
    func testProtocolMethodSignature() async throws {
        // Given
        let generator = DefaultURLRequestGenerator()
        let config = URLRequestCreatorHelper.createMockConfig()
        let request = URLRequestCreatorHelper.createMockNetworkRequest()
        
        // When
        let urlRequest = try generator.generateURLRequest(with: config, from: request)
        
        // Then
        #expect(type(of: urlRequest) == URLRequest.self)
        #expect(urlRequest.url != nil)
    }
    
    @Test(.tags(.networking, .unit))
    func testURLRequestCreation() async throws {
        // Given
        let generator = DefaultURLRequestGenerator()
        let config = URLRequestCreatorHelper.createMockConfig()
        let request = URLRequestCreatorHelper.createMockNetworkRequest()
        
        // When
        let urlRequest = try generator.generateURLRequest(with: config, from: request)
        
        // Then
        #expect(urlRequest.url != nil)
        #expect(urlRequest.url?.path == "/comments")
        #expect(urlRequest.httpMethod == "GET")
        #expect(urlRequest.url?.scheme == "https")
        #expect(urlRequest.url?.host() == "www.google.com")
    }
    
    @Test(.tags(.networking, .unit))
    func testURLRequestCreationWithHeaders() async throws {
        // Given
        let generator = DefaultURLRequestGenerator()
        let config = URLRequestCreatorHelper.createMockConfig()
        let request = URLRequestCreatorHelper.createMockNetworkRequestWithHeader()
        
        // When
        let urlRequest = try generator.generateURLRequest(with: config, from: request)
        
        // Then
        #expect(urlRequest.url != nil)
        #expect(urlRequest.url?.path == "/comments")
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.scheme == "https")
        #expect(urlRequest.url?.host() == "www.google.com")
        #expect(urlRequest.allHTTPHeaderFields?.count == 2)
        #expect(urlRequest.value(forHTTPHeaderField: "Authorization") == "Bearer token123")
        #expect(urlRequest.value(forHTTPHeaderField: "Content-Type") == "application/json")
    }
    
    @Test(.tags(.networking, .unit))
    func testURLRequestCreationWithBody() async throws {
        // Given
        let generator = DefaultURLRequestGenerator()
        let config = URLRequestCreatorHelper.createMockConfig()
        let request = URLRequestCreatorHelper.createMockNetworkRequestWithBody()
        
        // When
        let urlRequest = try generator.generateURLRequest(with: config, from: request)
        
        // Then
        #expect(urlRequest.url != nil)
        #expect(urlRequest.url?.path == "/comments")
        #expect(urlRequest.httpMethod == "POST")
        #expect(urlRequest.url?.scheme == "https")
        #expect(urlRequest.url?.host() == "www.google.com")
        #expect(urlRequest.httpBody != nil)
        
        if let bodyData = urlRequest.httpBody {
            let json = try JSONSerialization.jsonObject(with: bodyData) as? [String: Any]
            #expect(json?["name"] as? String == "Asad")
            #expect(json?["email"] as? String == "asad.mobiledev@gmail.com")
            #expect(json?["age"] as? Int == 30)
        }
        
        #expect(urlRequest.timeoutInterval == 10)
        #expect(urlRequest.cachePolicy == .useProtocolCachePolicy)
    }
}

