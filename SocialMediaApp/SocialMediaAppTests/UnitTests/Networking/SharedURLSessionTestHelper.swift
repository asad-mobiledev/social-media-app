//
//  SharedURLSessionTestHelper.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//
import Foundation
import Testing
@testable import SocialMediaApp

class SharedURLSessionTestHelper {
    
    
    static func createMockURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        let delegate = SharedURLSessionDelegate()
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }
    
}
