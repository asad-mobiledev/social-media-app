//
//  MockURLRequestGenerator.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

final class MockURLRequestGenerator: URLRequestGenerator {
    
    var urlRequestToReturn: URLRequest?
    var errorToThrow: Error?
    var generateCallCount = 0
    var configReceived: NetworkConfigurable?
    var requestReceived: NetworkRequest?
    
    func generateURLRequest(with config: NetworkConfigurable, from request: NetworkRequest) throws -> URLRequest {
        generateCallCount += 1
        configReceived = config
        requestReceived = request
        
        if let error = errorToThrow {
            throw error
        }
        
        return urlRequestToReturn ?? URLRequest(url: URL(string: "https://example.com")!)
    }
}

