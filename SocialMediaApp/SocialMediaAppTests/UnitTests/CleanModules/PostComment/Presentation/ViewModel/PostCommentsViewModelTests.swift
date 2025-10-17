//
//  PostCommentsViewModelTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Combine
import Testing
@testable import SocialMediaApp

struct PostCommentsViewModelTests {
    @Test(.tags(.viewmodel, .unit))
    func testInitialization() async throws {
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        #expect(viewModel.commentText == "")
        #expect(viewModel.errorMessage == "")
        #expect(viewModel.isLoading == false)
        #expect(viewModel.isSendCommentLoading == false)
        #expect(viewModel.showBottomSheet == false)
        #expect(viewModel.commentMediaLoadState == .unknown)
        #expect(viewModel.replyToComment == nil)
        #expect(viewModel.lastFetchedCommentsCount == -1)
        #expect(viewModel.refreshing == false)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testPublishedPropertiesAreObservable() async throws {
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let newComment = PostCommentsViewModelTestsHelper.createCommentEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        NotificationCenter.default.post(
            name: .newCommentAdded,
            object: newComment
        )
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        #expect(viewModel.comments.first?.text == "Asad2")
        #expect(viewModel.comments.first?.id == "00464942-C302-4FAB-A49E-A9732B4655DD")
        #expect(viewModel.comments.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testAddCommentSuccess() async throws {
        // Given
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        let imageMediaURL = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        let mediaAttachment: MediaAttachment = MediaAttachment(mediaType: .image, url: imageMediaURL)
        
        // When
        await viewModel.addComment(mediaAttachement: mediaAttachment)
        
        // Then
        #expect(viewModel.errorMessage == "")
        #expect(viewModel.isSendCommentLoading == false)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testAddCommentFailure() async throws {
        // Given
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        mockPostCommentUseCase.errorToThrow = CustomError.message("mock error")
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        let imageMediaURL = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        let mediaAttachment: MediaAttachment = MediaAttachment(mediaType: .image, url: imageMediaURL)
        
        // When
        await viewModel.addComment(mediaAttachement: mediaAttachment)
        
        // Then
        #expect(!viewModel.errorMessage.isEmpty)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testFetchCommentsSuccess() async throws {
        // Given
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        let imageMediaURL = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        let mediaAttachment: MediaAttachment = MediaAttachment(mediaType: .image, url: imageMediaURL)
        
        // When
        let comments = await viewModel.fetchComments()
        
        // Then
        #expect(viewModel.comments.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testFetchCommentsFailure() async throws {
        // Given
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        mockPostCommentUseCase.errorToThrow = CustomError.message("mock error")
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        let imageMediaURL = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        let mediaAttachment: MediaAttachment = MediaAttachment(mediaType: .image, url: imageMediaURL)
        
        // When
        await viewModel.fetchComments()
        
        // Then
        #expect(!viewModel.errorMessage.isEmpty)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testRefreshCommentsSuccess() async throws {
        // Given
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        let imageMediaURL = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        let mediaAttachment: MediaAttachment = MediaAttachment(mediaType: .image, url: imageMediaURL)
        
        // When
        let comments = await viewModel.refreshComments()
        
        // Then
        #expect(viewModel.comments.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testRefreshCommentsFailure() async throws {
        // Given
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        mockPostCommentUseCase.errorToThrow = CustomError.message("mock error")
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        let imageMediaURL = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        let mediaAttachment: MediaAttachment = MediaAttachment(mediaType: .image, url: imageMediaURL)
        
        // When
        await viewModel.refreshComments()
        
        // Then
        #expect(!viewModel.errorMessage.isEmpty)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testMediaTypeSuccess() async throws {
        // Given
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        let imageMediaURL = FileServiceTestHelper.createTestImageFile(fileName: "test.png", folderName: "test", directory: .documents)
        let mediaAttachment: MediaAttachment = MediaAttachment(mediaType: .image, url: imageMediaURL)
        
        // When
        let type = viewModel.mediaType(url: imageMediaURL!)
        
        // Then
        #expect(type == MediaType.image)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testMediaTypeFailure() async throws {
        // Given
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostCommentUseCase = MockPostCommentUseCase()
        mockPostCommentUseCase.errorToThrow = CustomError.message("mock error")
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockPostCommentUseCase, paginationPolicy: defaultPaginationPolicy)
        
        let imageMediaURL = URL(string: "ABC123")
        
        // When
        let type = viewModel.mediaType(url: imageMediaURL!)
        
        // Then
        #expect(type == nil)
    }
}
