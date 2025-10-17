//
//  URLRequestCreatorHelper.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class URLRequestCreatorHelper {
    
    static func createMockConfig(baseURL: String = "google.com") -> ApiDataNetworkConfig {
        return ApiDataNetworkConfig(baseURL: baseURL)
    }
    
    static func createMockNetworkRequest(path: String = "https://www.google.com/comments", method: HTTPMethod = .get, headerParameters: [String: String] = [:], queryParameters: [String: Any] = [:], bodyParameters: [String: Any] = [:]) -> DefaultNetworkRequest {
        DefaultNetworkRequest(path: path,
                              method: method,
                              headerParameters: headerParameters,
                              queryParameters: queryParameters,
                              bodyParameters: bodyParameters)
        
    }
    
    static func createMockNetworkRequestWithHeader() -> DefaultNetworkRequest {
        DefaultNetworkRequest(path: "https://www.google.com/comments",
                              method: .post,
                              headerParameters: [
                                "Authorization": "Bearer token123",
                                "Content-Type": "application/json"
                              ])
        
    }
    
    static func createMockNetworkRequestWithBody() -> DefaultNetworkRequest {
        DefaultNetworkRequest(path: "https://www.google.com/comments",
                              method: .post,
                              bodyParameters: [
                                "name": "Asad",
                                "email": "asad.mobiledev@gmail.com",
                                "age": 30
                              ])
        
    }
}
