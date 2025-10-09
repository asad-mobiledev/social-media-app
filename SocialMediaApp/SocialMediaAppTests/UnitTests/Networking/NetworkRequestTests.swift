//
//  NetworkRequestTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class NetworkRequestTests {
    @Test(.tags(.networking, .unit))
    func testDefaultNetworkRequestProtocolConformance() async throws {
        // Given
        let path = "/comments"
        
        // When
        let networkRequest = DefaultNetworkRequest(path: path)
        
        // Then
        #expect(networkRequest is NetworkRequest)
    }
    
    @Test(.tags(.networking, .unit))
    func testNetworkRequestDefaultParams() async throws {
        // Given
        let path = "/comments"
        
        // When
        let networkRequest = DefaultNetworkRequest(path: path)
        
        // Then
        #expect(networkRequest.path == path)
        #expect(networkRequest.method == .get)
        #expect(networkRequest.headerParameters.isEmpty)
        #expect(networkRequest.queryParameters.isEmpty)
        #expect(networkRequest.bodyParameters.isEmpty)
    }
    
    @Test(.tags(.networking, .unit))
    func testNetworkRequestAllParams() async throws {
        // Given
        let path = "/comments"
        let method = HTTPMethod.post
        let headers = [
            "Authorization": "Bearer token123",
            "Content-Type": "application/json"
        ]
        
        let queryParameters = [
            "page": 1,
            "limit": 10
        ]
        
        let bodyParameters = [
            "name": "Asad",
            "email": "asadpk80@gmail.com"
        ] as [String: Any]
        
        // When
        let networkRequest = DefaultNetworkRequest(path: path, method: method, headerParameters: headers, queryParameters: queryParameters, bodyParameters: bodyParameters)
        
        // Then
        #expect(networkRequest.path == path)
        #expect(networkRequest.method == method)
        #expect(networkRequest.headerParameters.count == 2)
        #expect(networkRequest.headerParameters == headers)
        #expect(networkRequest.queryParameters.count == 2)
        #expect(networkRequest.queryParameters["page"] as? Int == 1)
        #expect(networkRequest.queryParameters["limit"] as? Int == 10)
        #expect(networkRequest.bodyParameters.count == 2)
        #expect(networkRequest.bodyParameters["name"] as? String == "Asad")
        #expect(networkRequest.bodyParameters["email"] as? String == "asadpk80@gmail.com")
    }
    
    @Test(.tags(.networking, .unit))
    func testHTTPMethods() async throws {
        // Given
        let getMethod = "GET"
        let postMethod = "POST"
        let patchMethod = "PATCH"
        let putMethod = "PUT"
        let deleteMethod = "DELETE"
        
        // When & Then
        #expect(HTTPMethod.get.rawValue == getMethod)
        #expect(HTTPMethod.post.rawValue == postMethod)
        #expect(HTTPMethod.put.rawValue == putMethod)
        #expect(HTTPMethod.patch.rawValue == patchMethod)
        #expect(HTTPMethod.delete.rawValue == deleteMethod)
    }
}

/*
 import Foundation

 enum HTTPMethod: String {
     case get     = "GET"
     case post    = "POST"
     case put     = "PUT"
     case patch   = "PATCH"
     case delete  = "DELETE"
 }

 protocol NetworkRequest {
     var path: String {get set}
     var method: HTTPMethod {get set}
     var headerParameters: [String: String] {get set}
     var queryParameters: [String: Any] {get set}
     var bodyParameters: [String: Any] {get set}
 }

 final class DefaultNetworkRequest: NetworkRequest {
     
     var path: String
     var method: HTTPMethod
     var headerParameters: [String: String]
     var queryParameters: [String: Any]
     var bodyParameters: [String: Any]
     init(path: String,
          method: HTTPMethod = .get,
          headerParameters: [String: String] = [:],
          queryParameters: [String: Any] = [:],
          bodyParameters: [String: Any] = [:]) {
         self.path = path
         self.method = method
         self.headerParameters = headerParameters
         self.queryParameters = queryParameters
         self.bodyParameters = bodyParameters
     }
 }

 */
