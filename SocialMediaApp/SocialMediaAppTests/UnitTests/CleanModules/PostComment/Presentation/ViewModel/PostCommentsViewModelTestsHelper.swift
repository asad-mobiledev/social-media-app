//
//  PostCommentsViewModelTestsHelper.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 13/10/2025.
//
import Foundation
import Combine
import Testing
@testable import SocialMediaApp

class PostCommentsViewModelTestsHelper {
    static func createPostEntity() -> PostEntity {
        DefaultPostsListingUseCaseHelper.createMockPostDTO().toEntity()
    }
    
    static func createCommentEntity() -> CommentEntity {
        DefaultPostCommentUseCaseHelper.createMockCommentDTO().toEntity()
    }
}
