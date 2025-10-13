//
//  DefaultPostsListingUseCaseTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultPostCommentUseCaseTests {
    @Test(.tags(.usecase, .unit))
    func testProtocolConformance() async throws {
        let mockPostCommentRepository = MockPostCommentRepository()
        let defaultPostCommentUseCase = DefaultPostCommentUseCase(repository: mockPostCommentRepository)
        
        #expect(defaultPostCommentUseCase is PostCommentUseCase)
    }
    
    @Test(.tags(.usecase, .unit))
    func testAddCommentToPostSuccess() async throws {
        let mockPostCommentRepository = MockPostCommentRepository()
        let mockCommentAndPostDataToReturn = DefaultPostCommentUseCaseHelper.createMockCommentAndPostDTOTuple()
        mockPostCommentRepository.commentAndPostDataToReturn = mockCommentAndPostDataToReturn
        let defaultPostCommentUseCase = DefaultPostCommentUseCase(repository: mockPostCommentRepository)
        
        
        let addedCommentAndPost = try await defaultPostCommentUseCase.addComment(postId: mockCommentAndPostDataToReturn.1!.id!, mediaAttachement: nil, commentText: "Asad2")
        
        #expect(addedCommentAndPost != nil)
        #expect(addedCommentAndPost.postId == mockCommentAndPostDataToReturn.0.postId)
    }
    
    @Test(.tags(.usecase, .unit))
    func testAddCommentToPostFailure() async throws {
        let mockPostCommentRepository = MockPostCommentRepository()
        let defaultPostCommentUseCase = DefaultPostCommentUseCase(repository: mockPostCommentRepository)
        mockPostCommentRepository.errorToThrow = CustomError.message("Mock error")
        
        await #expect(throws: CustomError.self) {
            let addedCommentAndPost = try await defaultPostCommentUseCase.addComment(postId: "", mediaAttachement: nil, commentText: "Asad2")
        }
    }
    
    @Test(.tags(.usecase, .unit))
    func testFetchCommentsSuccess() async throws {
        let mockPostCommentRepository = MockPostCommentRepository()
        let mockCommentsToReturn = DefaultPostCommentUseCaseHelper.createMockCommentsDTO()
        mockPostCommentRepository.commentsDataToReturn = mockCommentsToReturn
        let defaultPostCommentUseCase = DefaultPostCommentUseCase(repository: mockPostCommentRepository)
        
        let fetchedComments = try await defaultPostCommentUseCase.fetchComments(postId: "7321CFC0-35FF-479D-BF1B-07DED1BCA06C", limit: 5, startAt: nil, parentCommentId: nil)
        
        #expect(fetchedComments != nil)
        #expect(fetchedComments.count > 0)
    }
    
    @Test(.tags(.usecase, .unit))
    func testFetchCommentsFailure() async throws {
        
        let mockPostCommentRepository = MockPostCommentRepository()
        mockPostCommentRepository.errorToThrow = CustomError.message("Mock error")
        let defaultPostCommentUseCase = DefaultPostCommentUseCase(repository: mockPostCommentRepository)
        
        await #expect(throws: CustomError.self) {
            let comments = try await defaultPostCommentUseCase.fetchComments(postId: "7321CFC0-35FF-479D-BF1B-07DED1BCA06C", limit: 5, startAt: nil, parentCommentId: nil)
        }
    }
}
