//
//  MockNetworkConfigurable.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

final class MockNetworkConfigurable: NetworkConfigurable {
    var baseURL: String
    var headers: [String : String]
    
    init(baseURL: String = "https://example.com", headers: [String : String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
    }
}
