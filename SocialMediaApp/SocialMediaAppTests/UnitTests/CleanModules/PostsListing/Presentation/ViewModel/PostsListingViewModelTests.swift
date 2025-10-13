//
//  PostsListingViewModelTests.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Combine
import Testing
@testable import SocialMediaApp

struct PostsListingViewModelTests {
    @Test(.tags(.viewmodel, .unit))
    func testInitialization() async throws {
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostListingUseCase = MockPostListingUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostsListingViewModel(postsListingUseCase: mockPostListingUseCase, paginationPolicy: defaultPaginationPolicy)
        
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        #expect(viewModel.posts.count == 0)
        #expect(viewModel.lastFetchedPostsCount == -1)
        #expect(viewModel.errorMessage == "")
        #expect(viewModel.isLoading == false)
        #expect(viewModel.refreshing == false)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testPublishedPropertiesAreObservable() async throws {
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostListingUseCase = MockPostListingUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostsListingViewModel(postsListingUseCase: mockPostListingUseCase, paginationPolicy: defaultPaginationPolicy)
        
        NotificationCenter.default.post(
            name: .didCreatePost,
            object: postEntity
        )
        
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        #expect(viewModel.posts.first?.mediaName == "test.png")
        #expect(viewModel.posts.first?.postType == MediaType.image)
        #expect(viewModel.posts.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testPublishedPropertyPostUpdateIsObservable() async throws {
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostListingUseCase = MockPostListingUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostsListingViewModel(postsListingUseCase: mockPostListingUseCase, paginationPolicy: defaultPaginationPolicy)
        
        NotificationCenter.default.post(
            name: .didCreatePost,
            object: postEntity
        )
        
        NotificationCenter.default.post(
            name: .updatedPost,
            object: postEntity
        )
        
        try await Task.sleep(nanoseconds: 1000_000_000)
        
        #expect(viewModel.posts.first?.mediaName == "test.png")
        #expect(viewModel.posts.first?.postType == MediaType.image)
        #expect(viewModel.posts.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testFetchPostsSuccess() async throws {
        // Given
        let postEntity = PostCommentsViewModelTestsHelper.createPostEntity()
        let mockPostListingUseCase = MockPostListingUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostsListingViewModel(postsListingUseCase: mockPostListingUseCase, paginationPolicy: defaultPaginationPolicy)
        
        NotificationCenter.default.post(
            name: .didCreatePost,
            object: postEntity
        )
        
        // When
        await viewModel.fetchPosts()
        
        // Then
        #expect(viewModel.posts.first?.mediaName == "test.png")
        #expect(viewModel.posts.first?.postType == MediaType.image)
        #expect(viewModel.posts.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testFetchDefaultPostsSuccess() async throws {
        // Given
        let mockPostListingUseCase = MockPostListingUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostsListingViewModel(postsListingUseCase: mockPostListingUseCase, paginationPolicy: defaultPaginationPolicy)
        
        // When
        await viewModel.fetchPosts()
        
        // Then
        #expect(viewModel.posts.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testFetchPostsFailure() async throws {
        // Given
        let mockPostListingUseCase = MockPostListingUseCase()
        mockPostListingUseCase.errorToThrow = CustomError.message("mock error")
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostsListingViewModel(postsListingUseCase: mockPostListingUseCase, paginationPolicy: defaultPaginationPolicy)
        
        // When
        viewModel.posts = []
        await viewModel.fetchPosts()
        
        // Then
        #expect(viewModel.posts.count == 0)
        #expect(!viewModel.errorMessage.isEmpty)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testFetchDefaultPostsRefreshingSuccess() async throws {
        // Given
        let mockPostListingUseCase = MockPostListingUseCase()
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostsListingViewModel(postsListingUseCase: mockPostListingUseCase, paginationPolicy: defaultPaginationPolicy)
        
        // When
        await viewModel.fetchPosts(isRefreshing: true)
        
        // Then
        #expect(viewModel.posts.count > 0)
    }
    
    @Test(.tags(.viewmodel, .unit))
    func testFetchPostsRefreshingFailure() async throws {
        // Given
        let mockPostListingUseCase = MockPostListingUseCase()
        mockPostListingUseCase.errorToThrow = CustomError.message("mock error")
        let defaultPaginationPolicy = DefaultPaginationPolicy()
        let viewModel = PostsListingViewModel(postsListingUseCase: mockPostListingUseCase, paginationPolicy: defaultPaginationPolicy)
        
        // When
        viewModel.posts = []
        await viewModel.fetchPosts(isRefreshing: true)
        
        // Then
        #expect(viewModel.posts.count == 0)
        #expect(!viewModel.errorMessage.isEmpty)
    }
}
