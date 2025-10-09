//
//  DatabaseTestHelper.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 07/10/2025.
//

import SwiftData
import Testing
@testable import SocialMediaApp

@MainActor
class DatabaseTestHelper {
    static func createInMemoryDatabaseService() async throws -> DefaultDatabaseService {
        DefaultDatabaseService.configure(isStoredInMemoryOnly: true)
        return DefaultDatabaseService.shared
    }
    
    static func createTestPostModel() -> PostModel {
        return PostModel(id: "test-post-1", postType: MediaType.image.rawValue, mediaName: "test-image.jpeg", date: "2025-01-01T10:00:00Z", commentsCount: 0)
    }
    
    static func createTestCommentModel() -> PostCommentModel {
        return PostCommentModel(id: "test-comment-1", postId: "test-post-1", parentCommentId: nil, text: "Test Comment", type: CommentType.text.rawValue, mediaName: nil, createdAt: "2025-01-01T10:00:00Z", replyCount: "0", depth: "0", parentCommentDepth: nil)
    }
}
