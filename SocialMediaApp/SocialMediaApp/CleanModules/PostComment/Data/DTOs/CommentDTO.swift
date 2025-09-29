//
//  CommentDTO.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 29/09/2025.
//

import Foundation

struct CommentDTO: Codable, Identifiable {
    var id: String?
    let postId: String
    let parentCommentId: String? // Comment replies will have non-nil value for this field.
    let text: String? // It could be nil if comment is some media type.
    let type: CommentType.RawValue
    var mediaName: String? // Media Name could be nil if comment is of text type.
    let createdAt: String
    
    init?(from commentModel: PostCommentModel) {
        
        
        self.id = commentModel.id
        self.type = commentModel.type
        self.mediaName = commentModel.mediaName
        self.createdAt = commentModel.createdAt
        
        self.postId = commentModel.postId
        self.parentCommentId = commentModel.parentCommentId
        self.text = commentModel.text
    }
    
    init(id: String?, postId: String, parentCommentId: String?, text: String?, type: String, mediaName: String?, createdAt: String) {
        self.id = id
        self.postId = postId
        self.parentCommentId = parentCommentId
        self.text = text
        self.type = type
        self.mediaName = mediaName
        self.createdAt = createdAt
    }
}

extension CommentDTO {
    func toEntity() -> CommentEntity {
        
        return CommentEntity(id: id ?? UUID().uuidString, postId: postId, parentCommentId: parentCommentId, text: text, type: type, mediaName: mediaName, createdAt: createdAt)
    }
}

extension CommentDTO {
    func toCommentModel() -> PostCommentModel {
        PostCommentModel(id: id ?? UUID().uuidString, postId: postId, parentCommentId: parentCommentId, text: text, type: type, mediaName: mediaName, createdAt: createdAt)
    }
}
