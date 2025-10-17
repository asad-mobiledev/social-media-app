//
//  MockPostCommentUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class MockPostCommentUseCase: PostCommentUseCase {
    var errorToThrow: Error?
    
    func addComment(postId: String, mediaAttachement: MediaAttachment?, commentText: String?, parentCommentId: String?, parentCommentDepth: String?) async throws -> CommentEntity {
        if let error = errorToThrow {
            throw error
        }
        return PostCommentsViewModelTestsHelper.createCommentEntity()
    }
    
    func fetchComments(postId: String, limit: Int, startAt: String?, parentCommentId: String?) async throws -> [CommentEntity] {
        if let error = errorToThrow {
            throw error
        }
        return [PostCommentsViewModelTestsHelper.createCommentEntity()]
    }
    
    
}
