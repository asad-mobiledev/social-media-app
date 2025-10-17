//
//  URLSessionTestHelper.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/10/2025.
//
import Foundation

class URLSessionTestHelper {
    static func createTestURLRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://github.com/oleh-zayats/awesome-unit-testing-swift")!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    static func createTestData() -> Data {
        return """
                {"id": "test-123",
                "name": "test data",
                "value": 42 }
                """.data(using: .utf8)!
    }
    
    static func createTestHTTPResponse(statusCode: Int = 200) -> HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "https://github.com/oleh-zayats/awesome-unit-testing-swift")!, statusCode: statusCode, httpVersion: nil, headerFields: ["Content-Type": "application/json"])!
    }
}
