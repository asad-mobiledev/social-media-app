//
//  MockNetworkSessionManager.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

final class MockNetworkSessionManager: NetworkSessionManager {
    var dataToReturn: (Data?, URLResponse?)?
    var errorToThrow: Error?
    var configReceived: NetworkConfigurable?
    var requestReceived: NetworkRequest?
    var requestCallsCount = 0
    
    func request(with config: NetworkConfigurable, request: NetworkRequest) async throws -> (Data?, URLResponse?) {
        requestCallsCount += 1
        configReceived = config
        requestReceived = request
        
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn ?? (nil, nil)
    }
}
