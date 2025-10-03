//
//  PostCommentUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 26/09/2025.
//

import Foundation

protocol PostCommentUseCase {
    func addComment(postId: String, mediaAttachement: MediaAttachment?, commentText: String?, parentCommentId: String?, parentCommentDepth: String?) async throws -> CommentEntity
    func fetchComments(postId: String, limit: Int, startAt: String?, parentCommentId: String?) async throws -> [CommentEntity]
}

final class DefaultPostCommentUseCase: PostCommentUseCase {
    
    private let repository: PostCommentRepository
    
    init(repository: PostCommentRepository) {
        self.repository = repository
    }
    
    func addComment(postId: String, mediaAttachement: MediaAttachment?, commentText: String?, parentCommentId: String? = nil, parentCommentDepth: String? = nil) async throws -> CommentEntity {
        
        let (commentDTO, postDTO) = try await repository.addComment(postId: postId, mediaAttachement: mediaAttachement, commentText: commentText, parentCommentId: parentCommentId, parentCommentDepth: parentCommentDepth)
        if let post = postDTO {
            let postEntity = post.toEntity()
            NotificationCenter.default.post(name: .updatedPost, object: postEntity)
        }
        return commentDTO.toEntity()
    }
    
    func fetchComments(postId: String, limit: Int, startAt: String? = nil, parentCommentId: String?) async throws -> [CommentEntity] {
        let commentDTOs = try await repository.getComments(postId: postId, limit: limit, startAt: startAt, parentCommentId: parentCommentId)
        return commentDTOs.map { $0.toEntity() }
    }
}
