//
//  DefaultPostCommentRepositoryTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultPostCommentRepositoryTests {
    @Test(.tags(.usecase, .unit))
    func testProtocolConformance() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        let defaultPostCommentRepository = DefaultPostCommentRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        #expect(defaultPostCommentRepository is PostCommentRepository)
    }
    
    @Test(.tags(.usecase, .unit))
    func testAddCommentSuccess() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        let defaultPostCommentRepository = DefaultPostCommentRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        let (commentDTO, postDTO): (CommentDTO, PostDTO?) = try await defaultPostCommentRepository.addComment(postId: "7321CFC0-35FF-479D-BF1B-07DED1BCA06C", mediaAttachement: nil, commentText: "Asad2")
        
        #expect(commentDTO != nil)
        #expect(postDTO != nil)
        
        #expect(commentDTO.postId == "7321CFC0-35FF-479D-BF1B-07DED1BCA06C")
        #expect(commentDTO.text == "Asad2")
    }
    
    @Test(.tags(.usecase, .unit))
    func testAddCommentFailure() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        mockNetworkRepository.errorToThrow = CustomError.message("custom error")
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        let defaultPostCommentRepository = DefaultPostCommentRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        await #expect(throws: CustomError.self) {
            let (_, _): (CommentDTO, PostDTO?) = try await defaultPostCommentRepository.addComment(postId: "12345", mediaAttachement: nil, commentText: "Asad2")
        }
    }
    
    @Test(.tags(.usecase, .unit))
    func testGetCommentsSuccess() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        let defaultPostCommentRepository = DefaultPostCommentRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        let comments = try await defaultPostCommentRepository.getComments(postId: "7321CFC0-35FF-479D-BF1B-07DED1BCA06C", limit: 5, startAt: nil, parentCommentId: nil)
        
        #expect(comments != nil)
        #expect(comments.count > 0)
    }
    
    @Test(.tags(.usecase, .unit))
    func testGetCommentsFailure() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        mockNetworkRepository.errorToThrow = CustomError.message("mock error")
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        await MainActor.run {
            mockDatabaseService.errorToThrow = CustomError.message("mock error")
        }
        let defaultPostCommentRepository = DefaultPostCommentRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        await #expect(throws: CustomError.self) {
            let _ = try await defaultPostCommentRepository.getComments(postId: "7321CFC0-35FF-479D-BF1B-07DED1BCA06C", limit: 5, startAt: nil, parentCommentId: nil)
        }
    }
}
