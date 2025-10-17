//
//  NetworkErrorTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct NetworkErrorTests {
    @Test(.tags(.networking, .unit))
    func testNetworkErrors() async throws {
        let networkError1 = NetworkError.badURL
        let networkError2 = NetworkError.badHostname
        let networkError3 = NetworkError.failed
        let networkError4 = NetworkError.noResponse
        let networkError5 = NetworkError.noData
        let networkError6 = NetworkError.unableToDecode
        let networkError7 = NetworkError.notConnected
        let networkError8 = NetworkError.generic
        
        #expect(networkError1.description == "Bad URL")
        #expect(networkError2.description == "A server with the specified hostname could not be found")
        #expect(networkError3.description == "Network Request Failed")
        #expect(networkError4.description == "No response")
        #expect(networkError5.description == "No Data")
        #expect(networkError6.description == "Response can't be decoded")
        #expect(networkError7.description == "The internet connection appears to be offline")
        #expect(networkError8.description == "Something went wrong")
    }
    
    @Test(.tags(.networking, .unit))
    func testResolveOutput() async throws {
        let outputError = NetworkError.notConnected
        let responseError = NetworkError.resolve(error: URLError(.notConnectedToInternet))
        
        #expect(responseError == outputError)
        #expect(responseError.description == "The internet connection appears to be offline")
    }
    
    @Test(.tags(.networking, .unit))
    func testResolveCannotFindHost() async throws {
        let outputError = NetworkError.badHostname
        let responseError = NetworkError.resolve(error: URLError(.cannotFindHost))
        
        #expect(responseError == outputError)
        #expect(responseError.description == "A server with the specified hostname could not be found")
    }
    
    @Test(.tags(.networking, .unit))
    func testResolveGeneric() async throws {
        let outputError = NetworkError.generic
        let responseError = NetworkError.resolve(error: URLError(.cancelled))
        
        #expect(responseError == outputError)
        #expect(responseError.description == "Something went wrong")
    }
}
