//
//  DefaultPostsRepositoryTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

struct DefaultPostsRepositoryTests {
    @Test(.tags(.usecase, .unit))
    func testProtocolConformance() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        let defaultPostsRepository = DefaultPostsRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        #expect(defaultPostsRepository is PostsListingRepository)
    }
    
    @Test(.tags(.usecase, .unit))
    func testCreatePostSuccess() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        let defaultPostsRepository = DefaultPostsRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        let url = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        
        let post = try await defaultPostsRepository.createPost(mediaType: .image, mediaURL: url)
        
        #expect(post != nil)
        #expect(post.mediaName == "test.png")
        
    }
    
    @Test(.tags(.usecase, .unit))
    func testCreatePostFilesFailure() async throws {
        let mockFileService = MockFileService()
        mockFileService.errorToThrow = CustomError.message("mock error")
        let mockNetworkRepository = MockNetworkRepository()
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        let defaultPostsRepository = DefaultPostsRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        let url = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        
        await #expect(throws: CustomError.self) {
            let _ = try await defaultPostsRepository.createPost(mediaType: .image, mediaURL: url)
        }
    }
    
    @Test(.tags(.usecase, .unit))
    func testCreatePostNetworkFailure() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        mockNetworkRepository.errorToThrow = CustomError.message("mock error")
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        let defaultPostsRepository = DefaultPostsRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        let url = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        
        await #expect(throws: CustomError.self) {
            let _ = try await defaultPostsRepository.createPost(mediaType: .image, mediaURL: url)
        }
    }
    
    @Test(.tags(.usecase, .unit))
    func testGetPostsSuccess() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        let defaultPostsRepository = DefaultPostsRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        let posts = try await defaultPostsRepository.getPosts(limit: 1, startAt: nil)
        
        #expect(posts != nil)
        #expect(posts.count == 1)
        
    }
    
    @Test(.tags(.usecase, .unit))
    func testGetPostsFailure() async throws {
        let mockFileService = MockFileService()
        let mockNetworkRepository = MockNetworkRepository()
        mockNetworkRepository.errorToThrow = CustomError.message("mock error")
        let mockDatabaseService = try await MockDatabaseService(isStoredInMemoryOnly: true)
        await MainActor.run {
            mockDatabaseService.errorToThrow = CustomError.message("mock error")
        }
        let defaultPostsRepository = DefaultPostsRepository(filesRepository: mockFileService, networkRepository: mockNetworkRepository, databaseService: mockDatabaseService)
        
        await #expect(throws: CustomError.self) {
            let _ = try await defaultPostsRepository.getPosts(limit: 1, startAt: nil)
        }
    }
}
