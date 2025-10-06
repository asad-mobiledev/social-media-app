//
//  NetworkRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 11/09/2025.
//

protocol NetworkRepository {
    func createPost(mediaType: MediaType, mediaName: String) async throws -> PostDTO
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO]
    func addComment(postId: String, mediaAttachement: MediaAttachment?, fileName: String?, commentText: String?, parentCommentId: String?, parentCommentDepth: String?) async throws -> CommentDTO
    func getComments(postId: String, limit: Int, startAt: String?, parentCommentId: String?) async throws -> [CommentDTO]
    func updateParentCommentsReplyCounts(_ parentCommentId: String) async throws -> CommentDTO
    func incrementPostCommentsCount(postId: String) async throws -> PostDTO 
}
