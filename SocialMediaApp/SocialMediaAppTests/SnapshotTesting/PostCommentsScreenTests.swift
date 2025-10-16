//
//  PostCommentsScreenTests.swift
//  SocialMediaAppTests
//
//  Created by Asad Mehmood on 16/10/2025.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import SocialMediaApp

final class PostCommentsScreenTests: XCTestCase {

    var mockUseCase: MockPostCommentUseCase!
    var paginationPolicy: DefaultPaginationPolicy!
    var mockRouter: Router!
    var fileService: FileService!
    var mockAppDIContainer: MockAppDIContainer!
    var postCommentViewModel: PostCommentsViewModel!
    var importMediaBottomSheetViewModel: ImportMediaBottomSheetViewModel!
    var fileName = ""
    
    override func setUp() async throws {
        try await super.setUp()
        mockUseCase = MockPostCommentUseCase()
        paginationPolicy = DefaultPaginationPolicy()
        mockRouter = Router()
        fileService = DefaultFileService(directory: .documents)
        mockAppDIContainer = MockAppDIContainer(router: mockRouter, databaseService: nil, fileService: fileService)
        importMediaBottomSheetViewModel = ImportMediaBottomSheetViewModel()
    }
    
    override func tearDown() async throws {
        mockUseCase = nil
        paginationPolicy = nil
        mockRouter = nil
        mockAppDIContainer = nil
        postCommentViewModel = nil
        try fileService.deleteFile(name: fileName, folder: MediaType.image.rawValue, directory: .documents)
        fileService = nil
        fileName = ""
        try await super.tearDown()
    }
    
    @MainActor
    func testPostCommentsScreenEmpty() async throws {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "image1", withExtension: "jpeg") else {
            throw CustomError.message("Failed to find image in test bundle")
        }
        do {
            fileName = try fileService.save(mediaType: .image, mediaURL: url)
        } catch {
            throw CustomError.message("Failed to save image")
        }
        let postEntity = PostEntity(id: "1", postType: .image, mediaName: fileName, date: "\(Date())", commentsCount: 1)
            
        self.postCommentViewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockUseCase, paginationPolicy: paginationPolicy)
        let view = PostCommentsScreen(postCommentsViewModel: self.postCommentViewModel, commentMediaBottomSheetViewModel: self.importMediaBottomSheetViewModel)
            .frame(width: 390, height: 844)
            .environmentObject(mockRouter)
            .environment(\.appDIContainer, mockAppDIContainer)
        
        assertSnapshot(of: view, as: .image(), record: false)
    }
    
    @MainActor
    func testPostCommentsScreenComment() async throws {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "image1", withExtension: "jpeg") else {
            throw CustomError.message("Failed to find image in test bundle")
        }
        do {
            fileName = try fileService.save(mediaType: .image, mediaURL: url)
        } catch {
            throw CustomError.message("Failed to save image")
        }
        let postEntity = PostEntity(id: "1", postType: .image, mediaName: fileName, date: "\(Date())", commentsCount: 1)
            
        self.postCommentViewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockUseCase, paginationPolicy: paginationPolicy)
        self.postCommentViewModel.comments = [
            CommentEntity(id: "1", postId: "1", parentCommentId: nil, text: "Asad", type: CommentType.text.rawValue, createdAt: "2025-01-01", replyCount: "0", parentCommentDepth: nil, depth: 0)
        ]
        let view = PostCommentsScreen(postCommentsViewModel: self.postCommentViewModel, commentMediaBottomSheetViewModel: self.importMediaBottomSheetViewModel)
            .frame(width: 390, height: 844)
            .environmentObject(mockRouter)
            .environment(\.appDIContainer, mockAppDIContainer)
        
        assertSnapshot(of: view, as: .image(), record: false)
    }
    
    @MainActor
    func testPostCommentsScreenAudioComment() async throws {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "audio", withExtension: "mp3") else {
            throw CustomError.message("Failed to find audio in test bundle")
        }
        do {
            fileName = try fileService.save(mediaType: .image, mediaURL: url)
        } catch {
            throw CustomError.message("Failed to audio image")
        }
        let postEntity = PostEntity(id: "1", postType: .audio, mediaName: fileName, date: "\(Date())", commentsCount: 1)
            
        self.postCommentViewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockUseCase, paginationPolicy: paginationPolicy)
        self.postCommentViewModel.comments = [
            CommentEntity(id: "1", postId: "1", parentCommentId: nil, text: nil, type: CommentType.audio.rawValue,mediaName: fileName, createdAt: "2025-01-01", replyCount: "0", parentCommentDepth: nil, depth: 0)
        ]
        let view = PostCommentsScreen(postCommentsViewModel: self.postCommentViewModel, commentMediaBottomSheetViewModel: self.importMediaBottomSheetViewModel)
            .frame(width: 390, height: 844)
            .environmentObject(mockRouter)
            .environment(\.appDIContainer, mockAppDIContainer)
        
        assertSnapshot(of: view, as: .image(), record: false)
    }
    
    @MainActor
    func testPostCommentsScreenVideoComment() async throws {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: "video", withExtension: "mp4") else {
            throw CustomError.message("Failed to find video in test bundle")
        }
        do {
            fileName = try fileService.save(mediaType: .video, mediaURL: url)
        } catch {
            throw CustomError.message("Failed to video image")
        }
        let postEntity = PostEntity(id: "1", postType: .video, mediaName: fileName, date: "\(Date())", commentsCount: 1)
            
        self.postCommentViewModel = PostCommentsViewModel(post: postEntity, postCommentUseCase: mockUseCase, paginationPolicy: paginationPolicy)
        self.postCommentViewModel.comments = [
            CommentEntity(id: "1", postId: "1", parentCommentId: nil, text: nil, type: CommentType.video.rawValue,mediaName: fileName, createdAt: "2025-01-01", replyCount: "0", parentCommentDepth: nil, depth: 0)
        ]
        let view = PostCommentsScreen(postCommentsViewModel: self.postCommentViewModel, commentMediaBottomSheetViewModel: self.importMediaBottomSheetViewModel)
            .frame(width: 390, height: 844)
            .environmentObject(mockRouter)
            .environment(\.appDIContainer, mockAppDIContainer)
        
        assertSnapshot(of: view, as: .image(), record: false)
    }
}
