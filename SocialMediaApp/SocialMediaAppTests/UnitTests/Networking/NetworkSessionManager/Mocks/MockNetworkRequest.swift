//
//  MockNetworkRequest.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

final class MockNetworkRequest: NetworkRequest {
    var path: String
    var method: HTTPMethod
    var headerParameters: [String : String]
    var queryParameters: [String : Any]
    var bodyParameters: [String : Any]
    
    init(path: String = "/test", method: HTTPMethod = .get, headerParameters: [String : String] = [:], queryParameters: [String : Any] = [:], bodyParameters: [String : Any] = [:]) {
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.queryParameters = queryParameters
        self.bodyParameters = bodyParameters
    }
}
