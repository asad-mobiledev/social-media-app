//
//  SnapshotTesting.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/10/2025.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import SocialMediaApp

final class PostsListingScreenSnapshotTests: XCTestCase {
    
    var mockUseCase: MockPostListingUseCase!
    var paginationPolicy: DefaultPaginationPolicy!
    var mockRouter: Router!
    var fileService: FileService!
    var mockAppDIContainer: MockAppDIContainer!
    var viewModel: PostsListingViewModel!
    
    override func setUp() async throws {
        try await super.setUp()
        mockUseCase = MockPostListingUseCase()
        paginationPolicy = DefaultPaginationPolicy()
        mockRouter = Router()
        fileService = DefaultFileService(directory: .documents)
        mockAppDIContainer = MockAppDIContainer(router: mockRouter, databaseService: nil, fileService: fileService)
        viewModel = PostsListingViewModel(postsListingUseCase: mockUseCase, paginationPolicy: paginationPolicy, notificationCenter: NotificationCenter())
    }
    
    override func tearDown() async throws {
        mockUseCase = nil
        paginationPolicy = nil
        mockRouter = nil
        fileService = nil
        mockAppDIContainer = nil
        viewModel = nil
        try await super.tearDown()
    }
    
    override func invokeTest() {
        withSnapshotTesting(record: .all, diffTool: .ksdiff) {
            super.invokeTest()
        }
    }
    
    @MainActor
    func testPostListingScreen() throws {
        let view = PostsListingScreen(postsListingViewModel: viewModel)
            .frame(width: 390, height: 844)
            .environmentObject(mockRouter)
            .environment(\.appDIContainer, mockAppDIContainer)
        assertSnapshot(of: view, as: .image, record: false)
    }
    
    @MainActor
    func testPostListingScreenWithPosts() throws {
        var fileName = ""
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "image1", withExtension: "jpeg") else {
            XCTFail("Failed to find image in test bundle")
            return
        }
        do {
            fileName = try fileService.save(mediaType: .image, mediaURL: url)
        } catch {
            XCTFail("Failed to save image")
            return
        }
        mockUseCase.postsToReturn = [
            PostEntity(id: "1", postType: .image, mediaName: fileName, date: "\(Date())", commentsCount: 1),
            PostEntity(id: "2", postType: .image, mediaName: fileName, date: "\(Date())", commentsCount: 3)
        ]
        
        viewModel.posts = mockUseCase.postsToReturn
        viewModel.isLoading = false
        
        let view = PostsListingScreen(postsListingViewModel: viewModel)
            .frame(width: 390, height: 844)
            .environmentObject(mockRouter)
            .environment(\.appDIContainer, mockAppDIContainer)
        assertSnapshot(of: view, as: .image, record: false)
    }
    
    @MainActor
    func testPostListingScreenWithAudioPosts() throws {
        var fileName = ""
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "audio", withExtension: "mp3") else {
            XCTFail("Failed to find audio in test bundle")
            return
        }
        do {
            fileName = try fileService.save(mediaType: .image, mediaURL: url)
        } catch {
            XCTFail("Failed to save audio")
            return
        }
        mockUseCase.postsToReturn = [
            PostEntity(id: "1", postType: .audio, mediaName: fileName, date: "\(Date())", commentsCount: 1),
            PostEntity(id: "2", postType: .audio, mediaName: fileName, date: "\(Date())", commentsCount: 3)
        ]
        
        viewModel.posts = mockUseCase.postsToReturn
        viewModel.isLoading = false
        
        let view = PostsListingScreen(postsListingViewModel: viewModel)
            .frame(width: 390, height: 844)
            .environmentObject(mockRouter)
            .environment(\.appDIContainer, mockAppDIContainer)
        assertSnapshot(of: view, as: .image, record: false)
    }
    
    @MainActor
       func testPostListingScreen_loadingState() async throws {
           let view = PostsListingScreen(postsListingViewModel: viewModel)
               .frame(width: 390, height: 844)
               .environmentObject(mockRouter)
               .environment(\.appDIContainer, mockAppDIContainer)
           
           try await Task.sleep(nanoseconds: 2 * 1_000_000_000)
           
           viewModel.isLoading = true
           
           assertSnapshot(of: view, as: .image, record: false)
       }
    
    @MainActor
    func testPostListingScreenWithAudioPostsDarkMode() throws {
        var fileName = ""
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "audio", withExtension: "mp3") else {
            XCTFail("Failed to find audio in test bundle")
            return
        }
        do {
            fileName = try fileService.save(mediaType: .image, mediaURL: url)
        } catch {
            XCTFail("Failed to save audio")
            return
        }
        mockUseCase.postsToReturn = [
            PostEntity(id: "1", postType: .audio, mediaName: fileName, date: "\(Date())", commentsCount: 1),
            PostEntity(id: "2", postType: .audio, mediaName: fileName, date: "\(Date())", commentsCount: 3)
        ]
        
        viewModel.posts = mockUseCase.postsToReturn
        viewModel.isLoading = false
        
        let view = PostsListingScreen(postsListingViewModel: viewModel)
            .frame(width: 390, height: 844)
            .preferredColorScheme(.dark)
            .environmentObject(mockRouter)
            .environment(\.appDIContainer, mockAppDIContainer)
        assertSnapshot(of: view, as: .image, record: false)
    }
}
