//
//  PostCommentRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 26/09/2025.
//

protocol PostCommentRepository {
    func addComment(postId: String, mediaAttachement: MediaAttachment?, commentText: String?, parentCommentId: String?, parentCommentDepth: String?) async throws -> (CommentDTO, PostDTO?)
    func getComments(postId: String, limit: Int, startAt: String?, parentCommentId: String?) async throws -> [CommentDTO]
}
