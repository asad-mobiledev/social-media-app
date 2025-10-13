//
//  DefaultPostsListingUseCaseTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultPostsListingUseCaseTests {
    @Test(.tags(.usecase, .unit))
    func testProtocolConformance() async throws {
        let mockPostsListingRepository = MockPostsListingRepository()
        let defaultPostsListingUseCase = DefaultPostsListingUseCase(repository: mockPostsListingRepository)
        
        #expect(defaultPostsListingUseCase is PostsListingUseCase)
    }
    
    @Test(.tags(.usecase, .unit))
    func testFetchPostsSuccess() async throws {
        let mockPostsListingRepository = MockPostsListingRepository()
        let defaultPostsListingUseCase = DefaultPostsListingUseCase(repository: mockPostsListingRepository)
        
        let posts = try await defaultPostsListingUseCase.fetchPosts(limit: 5)
        
        #expect(posts != nil)
        #expect(posts.count > 0)
    }
    
    @Test(.tags(.usecase, .unit))
    func testFetchPostsFailure() async throws {
        let mockPostsListingRepository = MockPostsListingRepository()
        mockPostsListingRepository.errorToThrow = CustomError.message("Custom Error")
        let defaultPostsListingUseCase = DefaultPostsListingUseCase(repository: mockPostsListingRepository)
        
        await #expect(throws: CustomError.self) {
            let posts = try await defaultPostsListingUseCase.fetchPosts(limit: 5)
        }
    }
}


/*
 func fetchPosts(limit: Int, startAt: String? = nil) async throws -> [PostEntity] {
     let postDTOs = try await repository.getPosts(limit: limit, startAt: startAt)
     return postDTOs.map { $0.toEntity() }
 }
 */
