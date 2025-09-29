//
//  PostCommentRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 26/09/2025.
//

protocol PostCommentRepository {
    func addComment(commentEntity: CommentEntity) async throws -> CommentDTO
    func getComments(postId: String, limit: Int, startAt: String?) async throws -> [CommentDTO]
}
