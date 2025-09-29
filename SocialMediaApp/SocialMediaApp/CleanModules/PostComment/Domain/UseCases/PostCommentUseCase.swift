//
//  PostCommentUseCase.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 26/09/2025.
//

protocol PostCommentUseCase {
    func addComment(comment: CommentEntity) async throws -> CommentEntity
    func fetchComments(postId: String, limit: Int, startAt: String?) async throws -> [CommentEntity]
}

final class DefaultPostCommentUseCase: PostCommentUseCase {
    
    private let repository: PostCommentRepository
    
    init(repository: PostCommentRepository) {
        self.repository = repository
    }
    
    func addComment(comment: CommentEntity) async throws -> CommentEntity {
        
        let commentDTO = try await repository.addComment(commentEntity: comment)
        return commentDTO.toEntity()
    }
    
    func fetchComments(postId: String, limit: Int, startAt: String? = nil) async throws -> [CommentEntity] {
        let commentDTOs = try await repository.getComments(postId: postId, limit: limit, startAt: startAt)
        return commentDTOs.map { $0.toEntity() }
    }
}
