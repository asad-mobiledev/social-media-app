//
//  MockPostsListingRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 12/10/2025.
//

import Foundation
import Testing
@testable import SocialMediaApp

class MockPostCommentRepository: PostCommentRepository {
    var errorToThrow: Error?
    var commentAndPostDataToReturn: (CommentDTO, PostDTO?)?
    var commentsDataToReturn: [CommentDTO] = []
    
    func addComment(postId: String, mediaAttachement: MediaAttachment?, commentText: String?, parentCommentId: String?, parentCommentDepth: String?) async throws -> (CommentDTO, PostDTO?) {
        if let error = errorToThrow {
            throw error
        }
        return commentAndPostDataToReturn!
    }
    
    func getComments(postId: String, limit: Int, startAt: String?, parentCommentId: String?) async throws -> [CommentDTO] {
        if let error = errorToThrow {
            throw error
        }
        return commentsDataToReturn
    }
    
    
}
