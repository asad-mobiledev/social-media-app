//
//  MockNetworkRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class MockNetworkRepository: NetworkRepository {
    var errorToThrow: Error?
    
    func createPost(mediaType: MediaType, mediaName: String) async throws -> PostDTO {
        if let error = errorToThrow {
            throw error
        }
        return DefaultPostsListingUseCaseHelper.createMockPostDTO()
    }
    
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO] {
        if let error = errorToThrow {
            throw error
        }
        return [DefaultPostsListingUseCaseHelper.createMockPostDTO()]
    }
    
    func addComment(postId: String, mediaAttachement: MediaAttachment?, fileName: String?, commentText: String?, parentCommentId: String?, parentCommentDepth: String?) async throws -> CommentDTO {
        if let error = errorToThrow {
            throw error
        }
        return DefaultPostCommentUseCaseHelper.createMockCommentsDTO().first!
    }
    
    func getComments(postId: String, limit: Int, startAt: String?, parentCommentId: String?) async throws -> [CommentDTO] {
        if let error = errorToThrow {
            throw error
        }
        return DefaultPostCommentUseCaseHelper.createMockCommentsDTO()
    }
    
    func updateParentCommentsReplyCounts(_ parentCommentId: String) async throws -> CommentDTO {
        if let error = errorToThrow {
            throw error
        }
        return DefaultPostCommentUseCaseHelper.createMockCommentsDTO().first!
    }
    
    func incrementPostCommentsCount(postId: String) async throws -> PostDTO {
        if let error = errorToThrow {
            throw error
        }
        return DefaultPostsListingUseCaseHelper.createMockPostDTO()
    }
}
