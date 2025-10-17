//
//  DefaultNetworkRepositoryTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultNetworkRepositoryTests {
    
    @Test(.tags(.networking, .unit))
    func testGetPostsSuccess() async throws {
        let mockDataTransferService = MockDataTransferService()
        let limit = 5
        let startAt = "2025-10-06T12:59:13.856Z"
        let defaultNetworkRepository = DefaultNetworkRepository(apiDataTransferService: mockDataTransferService)
        let posts = try await defaultNetworkRepository.getPosts(limit: limit, startAt: startAt)
        
        #expect(posts != nil)
    }
    
    @Test(.tags(.networking, .unit))
    func testCreatePostSuccess() async throws {
        let mockDataTransferService = MockDataTransferService()
        let defaultNetworkRepository = DefaultNetworkRepository(apiDataTransferService: mockDataTransferService)
        let post = try await defaultNetworkRepository.createPost(mediaType: .image, mediaName: "image.png")
        
        #expect(post != nil)
        #expect(post.postType == MediaType.image.rawValue)
    }
    
    @Test(.tags(.networking, .unit))
    func testGetCommentsSuccess() async throws {
        let mockDataTransferService = MockDataTransferService()
        let mockPostID = "4ABBB302-628A-4713-9146-BE2C383F1F2D"
        let limit = 5
        let startAt = "2025-10-06T12:59:13.856Z"
        let defaultNetworkRepository = DefaultNetworkRepository(apiDataTransferService: mockDataTransferService)
        let posts = try await defaultNetworkRepository.getComments(postId: mockPostID, limit: limit, startAt: startAt, parentCommentId: nil)
        
        #expect(posts != nil)
        #expect(posts.count == 0)
    }
    
    @Test(.tags(.networking, .unit))
    func testGetCommentsFailure() async throws {
        let mockDataTransferService = MockDataTransferService()
        mockDataTransferService.errorToThrow = CustomError.message("Mock Error")
        let mockPostID = "4ABBB302-628A-4713-9146-BE2C383F1F2D"
        let limit = 5
        let startAt = "2025-10-06T12:59:13.856Z"
        let defaultNetworkRepository = DefaultNetworkRepository(apiDataTransferService: mockDataTransferService)
        await #expect(throws: CustomError.self) {
            _ = try await defaultNetworkRepository.getComments(postId: mockPostID, limit: limit, startAt: startAt, parentCommentId: nil)
        }
    }
    
    @Test(.tags(.networking, .unit))
    func testGetCommentRepliesSuccess() async throws {
        let mockDataTransferService = MockDataTransferService()
        let mockPostID = "4ABBB302-628A-4713-9146-BE2C383F1F2D"
        let limit = 5
        let startAt = "2025-10-06T12:59:13.856Z"
        let defaultNetworkRepository = DefaultNetworkRepository(apiDataTransferService: mockDataTransferService)
        let posts = try await defaultNetworkRepository.getComments(postId: mockPostID, limit: limit, startAt: startAt, parentCommentId: "1234567890")
        
        #expect(posts != nil)
        #expect(posts.count == 0)
    }
    
    @Test(.tags(.networking, .unit))
    func testGetCommentRepliesFailure() async throws {
        let mockDataTransferService = MockDataTransferService()
        mockDataTransferService.errorToThrow = CustomError.message("Mock Error")
        let mockPostID = "4ABBB302-628A-4713-9146-BE2C383F1F2D"
        let limit = 5
        let startAt = "2025-10-06T12:59:13.856Z"
        let defaultNetworkRepository = DefaultNetworkRepository(apiDataTransferService: mockDataTransferService)
        await #expect(throws: CustomError.self) {
            _ = try await defaultNetworkRepository.getComments(postId: mockPostID, limit: limit, startAt: startAt, parentCommentId: "1234567890")
        }
    }
}
