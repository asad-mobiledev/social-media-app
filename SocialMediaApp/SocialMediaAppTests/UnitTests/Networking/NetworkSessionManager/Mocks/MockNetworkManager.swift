//
//  MockNetworkManager.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

final class MockNetworkManager: NetworkManager {
    var receivedNetworkRequest: NetworkRequest?
    var dataToReturn: Data?
    var errorToThrow: Error?
    var fetchCallsCount = 0
    
    func fetch(request: NetworkRequest) async throws -> Data {
        fetchCallsCount += 1
        receivedNetworkRequest = request
        if let error = errorToThrow {
            throw error
        }
        return dataToReturn ?? Data()
    }
    
    
}


/*
 protocol NetworkManager {
     func fetch(request: NetworkRequest) async throws -> Data
 }

 final class DefaultNetworkManager: NetworkManager {
     
     private let config: NetworkConfigurable
     private let sessionManager: NetworkSessionManager
     
     init(config: NetworkConfigurable,
         sessionManager: NetworkSessionManager = DefaultNetworkSessionManager()) {
         self.config = config
         self.sessionManager = sessionManager
     }
     
     /// Method to fetch data from Session Manager and validates the data and response
     /// - Parameter request: Network Request
     /// - Returns: Data
     func fetch(request: NetworkRequest) async throws -> Data {
         let (data, response) = try await sessionManager.request(with: config, request: request)
         guard let response = response as? HTTPURLResponse else { throw NetworkError.noResponse }
         if response.statusCode != 200 { throw NetworkError.failed }
         guard let data = data else { throw NetworkError.noData }
         return data
     }
 }

 */
