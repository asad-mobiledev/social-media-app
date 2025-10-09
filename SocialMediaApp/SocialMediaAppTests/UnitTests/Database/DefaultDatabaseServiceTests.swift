//
//  DefaultDatabaseServiceTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 07/10/2025.
//
import SwiftData
import Testing
@testable import SocialMediaApp
import Foundation

struct DefaultDatabaseServiceTests {
    
    // MARK: - Save Tests
    
    @Test(.tags(.database, .unit))
    func testSavePostModel() async throws {
        // Given
        let databaseService = try await DatabaseTestHelper.createInMemoryDatabaseService()
        let postModel = await DatabaseTestHelper.createTestPostModel()
        
        // When
        try await databaseService.save(item: postModel)
        
        //Then
        let fetchedPosts: [PostModel] = try await databaseService.fetch(descriptor: nil)
        #expect(fetchedPosts.count == 1)
        #expect(fetchedPosts.first?.id == "test-post-1")
        #expect(fetchedPosts.first?.postType == MediaType.image.rawValue)
    }
    
    @Test(.tags(.database, .unit))
    func testSavePostCommentModel() async throws {
        // Given
        let databaseService = try await DatabaseTestHelper.createInMemoryDatabaseService()
        let postCommentModel = await DatabaseTestHelper.createTestCommentModel()
        
        // When
        try await databaseService.save(item: postCommentModel)
        
        //Then
        let fetchedPostComments: [PostCommentModel] = try await databaseService.fetch(descriptor: nil)
        #expect(fetchedPostComments.count == 1)
        #expect(fetchedPostComments.first?.id == "test-comment-1")
        #expect(fetchedPostComments.first?.type == CommentType.text.rawValue)
    }
    
    @Test(.tags(.database,.unit))
    func testSaveMultipleItems() async throws {
        // Given
        let databaseService = try await DatabaseTestHelper.createInMemoryDatabaseService()
        let post1 = await DatabaseTestHelper.createTestPostModel()
        let post2 = PostModel(id: "test-post-2", postType: MediaType.video.rawValue, mediaName: "test-video.mp4", date: "2025-01-02T10:00:00Z", commentsCount: 5)
        
        // When
        try await databaseService.save(item: post1)
        try await databaseService.save(item: post2)
        
        // Then
        let fetchedPosts: [PostModel] = try await databaseService.fetch(descriptor: nil)
        #expect(fetchedPosts.count == 2)
        #expect(fetchedPosts[0].id == "test-post-1")
        #expect(fetchedPosts[1].id == "test-post-2")
    }
    
    @Test(.tags(.database, .unit))
    func testBatchSaveItems() async throws {
        // Given
        let databaseService = try await DatabaseTestHelper.createInMemoryDatabaseService()
        let postItems = [
            await DatabaseTestHelper.createTestPostModel(),
            PostModel(id: "test-post-2", postType: MediaType.audio.rawValue, mediaName: "test-audio.mp3", date: "2025-01-02T10:00:00Z", commentsCount: 3)
        ]
        //When
        try await databaseService.batchSave(items: postItems)
        
        //Then
        let fetchedPosts: [PostModel] = try await databaseService.fetch(descriptor: nil)
        #expect(fetchedPosts.count == 2)
    }
    
    @Test(.tags(.database, .unit))
    func testBatchSaveEmptyArray() async throws {
        // Given
        let databaseService = try await DatabaseTestHelper.createInMemoryDatabaseService()
        let postItems: [PostModel] = []
        //When
        try await databaseService.batchSave(items: postItems)
        
        //Then
        let fetchedPosts: [PostModel] = try await databaseService.fetch(descriptor: nil)
        #expect(fetchedPosts.count == 0)
    }
    
    @Test(.tags(.database, .unit), .enabled(if: MediaType.audio.rawValue == "audio"))
    func testFetchWithDescriptor() async throws {
        // Given
        let databaseHelper = try await DatabaseTestHelper.createInMemoryDatabaseService()
        let posts = [
            await DatabaseTestHelper.createTestPostModel(),
            PostModel(id: "test-post-2", postType: MediaType.audio.rawValue, mediaName: "test-audio.mp3", date: "2025-01-02T10:00:00Z", commentsCount: 2)
        ]
        
        // When
        for post in posts {
            try await databaseHelper.save(item: post)
        }
        
        // Then
        let predicate: Predicate<PostModel> = #Predicate { $0.postType == "audio" }
        let descriptor = FetchDescriptor<PostModel>(
            predicate: predicate)
        let fetchedPosts: [PostModel] = try await databaseHelper.fetch(descriptor: descriptor)
        #expect(fetchedPosts.count == 1)
        #expect(fetchedPosts.first?.postType == MediaType.audio.rawValue)
    }
    
    @Test(.tags(.database, .unit))
    func testDeleteAll() async throws {
        // Given
        let databaseHelper = try await DatabaseTestHelper.createInMemoryDatabaseService()
        let posts = [
            await DatabaseTestHelper.createTestPostModel(),
            PostModel(id: "test-post-2", postType: MediaType.video.rawValue, mediaName: "test-video.mp4", date: "2025-01-02T10:00:00Z", commentsCount: 2)
        ]
        try await databaseHelper.batchSave(items: posts)
        
        // When
        try await databaseHelper.deleteAll(of: PostModel.self, descriptor: nil)
        
        // Then
        let fetchedPosts: [PostModel] = try await databaseHelper.fetch(descriptor: nil)
        #expect(fetchedPosts.count == 0)
    }
    
    @Test(.tags(.database, .unit))
    func testDeleteAllWithDescriptor() async throws {
        // Given
        let databaseHelper = try await DatabaseTestHelper.createInMemoryDatabaseService()
        let posts = [
            await DatabaseTestHelper.createTestPostModel(),
            PostModel(id: "test-post-2", postType: MediaType.image.rawValue, mediaName: "test-image-2.png", date: "2025-01-02T10:00:00Z", commentsCount: 2)
        ]
        try await databaseHelper.batchSave(items: posts)
        
        // When
        let predicate: Predicate<PostModel> = #Predicate { $0.postType == "image" }
        let descriptor: FetchDescriptor<PostModel> = FetchDescriptor(predicate: predicate)
        try await databaseHelper.deleteAll(of: PostModel.self, descriptor: nil)
        
        // Then
        let fetchedPosts: [PostModel] = try await databaseHelper.fetch(descriptor: nil)
        #expect(fetchedPosts.count == 0)
    }
    
    @Test(.tags(.database, .unit))
    func testContext() async throws {
        // Given
        let databaseHelper = try await DatabaseTestHelper.createInMemoryDatabaseService()
        
        // Then
        await #expect(databaseHelper.context != nil)
    }
    
    @Test(.tags(.database, .unit))
    func testPostCommentIntegration() async throws {
        // Given
        let databaseHelper = try await DatabaseTestHelper.createInMemoryDatabaseService()
        let post = await DatabaseTestHelper.createTestPostModel()
        let comment = await DatabaseTestHelper.createTestCommentModel()
        
        // When
        try await databaseHelper.save(item: post)
        try await databaseHelper.save(item: comment)
        
        // Then
        let fetchedPosts: [PostModel] = try await databaseHelper.fetch(descriptor: nil)
        let fetchedComments: [PostCommentModel] = try await databaseHelper.fetch(descriptor: nil)
        
        #expect(fetchedPosts.count == 1)
        #expect(fetchedComments.count == 1)
        #expect(fetchedComments.first?.postId == fetchedPosts.first?.id)
    }
    
    @Test(.tags(.database, .unit))
    func testConcurrentSaving() async throws {
        // Given
        let databaseHelper = try await DatabaseTestHelper.createInMemoryDatabaseService()
        
        // When
        async let save1: () = databaseHelper.save(item: DatabaseTestHelper.createTestPostModel())
        async let save2: () = databaseHelper.save(item: DatabaseTestHelper.createTestCommentModel())
        
        try await save1
        try await save2
        
        // Then
        let fetchedPosts: [PostModel] = try await databaseHelper.fetch(descriptor: nil)
        let fetchedCOmments: [PostCommentModel] = try await databaseHelper.fetch(descriptor: nil)
        
        #expect(fetchedPosts.count == 1)
        #expect(fetchedCOmments.count == 1)
    }
    
    @Test(.tags(.database, .unit))
    func testConfigureInMemory() async throws {
        //Given & When
        await DefaultDatabaseService.configure(isStoredInMemoryOnly: true)
        let service = await DefaultDatabaseService.shared
        
        // Then
        await #expect(service.context != nil)
    }
    
    @Test(.tags(.database, .unit))
    func testConfigurePersistent() async throws {
        //Given & When
        await DefaultDatabaseService.configure(isStoredInMemoryOnly: false)
        let service = await DefaultDatabaseService.shared
        
        // Then
        await #expect(service.context != nil)
    }
    
    @Test(.tags(.database, .unit))
    func testSingletonBehavior() async throws {
        // Given
        await DefaultDatabaseService.configure(isStoredInMemoryOnly: true)
        
        // When
        let service1 = await DefaultDatabaseService.shared
        let service2 = await DefaultDatabaseService.shared
        
        // Then
        #expect(service1 === service2)
    }
    
    @Test(.tags(.database, .unit))
    func testModelContainerConfiguration() async throws {
        let databaseHelper = try await DatabaseTestHelper.createInMemoryDatabaseService()
        
        // When & Then
        let container = await databaseHelper.container
        let context = await databaseHelper.context
        let mainContext = await container.mainContext
        
        #expect(container != nil)
        #expect(context == mainContext)
    }
}
