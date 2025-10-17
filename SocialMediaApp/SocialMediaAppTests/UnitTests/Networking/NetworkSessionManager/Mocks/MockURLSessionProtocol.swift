//
//  MockURLSessionProtocol.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

final class MockURLSession: URLSessionProtocol {
    var dataToReturn: (Data?, URLResponse?)?
    var errorToThrow: Error?
    var requestReceived: URLRequest?
    var asyncDataCallCount = 0
    
    func asyncData(for request: URLRequest) async throws -> (Data?, URLResponse?) {
        asyncDataCallCount += 1
        requestReceived = request
        
        if let error = errorToThrow {
            throw error
        }
        
        return dataToReturn ?? (nil, nil)
    }
}
