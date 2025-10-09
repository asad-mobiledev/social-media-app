//
//  DataTransferServiceTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DataTransferServiceTests {
    @Test(.tags(.networking, .unit))
    func testInitialization() async throws {
        let mockNetworkManager = MockNetworkManager()
        let defaultDataTransferService = DefaultDataTransferService(networkManager: mockNetworkManager)
        
        #expect(defaultDataTransferService != nil)
    }
    
    @Test(.tags(.networking, .unit))
    func testRequestWithDecodableResponse() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager()
        let defaultDataTransferService = DefaultDataTransferService(networkManager: mockNetworkManager)
        let mockRequest = MockNetworkRequest()
        let expectedPost = PostDTO(postType: "image", mediaName: "image_1.png", date: "2025-01-01", commentsCount: "0")
        let jsonData = try JSONEncoder().encode(expectedPost)
        mockNetworkManager.dataToReturn = jsonData
        
        // When
        let result: PostDTO = try await defaultDataTransferService.request(request: mockRequest)
        
        // Then
        #expect(result.postType == expectedPost.postType)
        #expect(result.mediaName == expectedPost.mediaName)
        #expect(result.date == expectedPost.date)
        #expect(result.commentsCount == expectedPost.commentsCount)
        #expect(mockNetworkManager.fetchCallsCount == 1)
    }
    
    @Test(.tags(.networking, .unit))
    func testErrorCase() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager()
        let defaultDataTransferService = DefaultDataTransferService(networkManager: mockNetworkManager)
        let mockRequest = MockNetworkRequest()
        let emptyData = Data()
        mockNetworkManager.dataToReturn = emptyData
        
        // When & Then
        await #expect(throws: NetworkError.unableToDecode) {
            let result: PostDTO = try await defaultDataTransferService.request(request: mockRequest)
        }
        
        #expect(mockNetworkManager.fetchCallsCount == 1)
    }
    
    @Test(.tags(.networking, .unit))
    func testDecode() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager()
        let defaultDataTransferService = DefaultDataTransferService(networkManager: mockNetworkManager)
        let mockRequest = MockNetworkRequest()
        let expectedPost = PostDTO(postType: "image", mediaName: "image_1.png", date: "2025-01-01", commentsCount: "0")
        let jsonData = try JSONEncoder().encode(expectedPost)
        
        
        // When
        let result: PostDTO = try defaultDataTransferService.decode(data: jsonData)
        
        // Then
        #expect(result.postType == expectedPost.postType)
    }
    
    @Test(.tags(.networking, .unit))
    func testDecodeFailure() async throws {
        // Given
        let mockNetworkManager = MockNetworkManager()
        let defaultDataTransferService = DefaultDataTransferService(networkManager: mockNetworkManager)
        let mockRequest = MockNetworkRequest()
        let expectedPost = PostDTO(postType: "image", mediaName: "image_1.png", date: "2025-01-01", commentsCount: "0")
        let jsonData = try JSONEncoder().encode(expectedPost)
        
        
        // When & Then
        #expect(throws: NetworkError.self) {
            let result: CommentDTO = try defaultDataTransferService.decode(data: jsonData)
        }
    }
    
}

/*
 func request<T>(request: NetworkRequest) async throws -> T where T : Decodable {
     let data = try await networkManager.fetch(request: request)
     return try decode(data: data)
 }
 */
