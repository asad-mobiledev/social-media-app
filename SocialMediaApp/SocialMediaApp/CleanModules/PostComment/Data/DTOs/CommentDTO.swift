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
    let replyCount: String?
    
    init?(from firestoreDocument: FirestoreCommentDocument) {
        guard let id = firestoreDocument.name.components(separatedBy: "/").last,
              let postId = firestoreDocument.fields.postId?.stringValue,
              let type = firestoreDocument.fields.type?.stringValue,
              let createdAt = firestoreDocument.fields.createdAt?.stringValue else {
            return nil
        }
        
        self.id = id
        self.postId = postId
        self.type = type
        self.createdAt = createdAt
        
        self.mediaName = firestoreDocument.fields.mediaName?.stringValue
        self.parentCommentId = firestoreDocument.fields.parentCommentId?.stringValue
        self.text = firestoreDocument.fields.text?.stringValue
        self.replyCount = firestoreDocument.fields.replyCount?.integerValue
    }
    
    
    init(id: String?, postId: String, parentCommentId: String?, text: String?, type: String, mediaName: String?, createdAt: String, replyCount: String?) {
        self.id = id
        self.postId = postId
        self.parentCommentId = parentCommentId
        self.text = text
        self.type = type
        self.mediaName = mediaName
        self.replyCount = replyCount
        self.createdAt = createdAt
    }
}

extension CommentDTO {
    func toEntity() -> CommentEntity {
        
        return CommentEntity(id: id ?? UUID().uuidString, postId: postId, parentCommentId: parentCommentId, text: text, type: type, mediaName: mediaName, createdAt: createdAt, replyCount: replyCount)
    }
}

extension CommentDTO {
    func toCommentModel() -> PostCommentModel {
        PostCommentModel(id: id ?? UUID().uuidString, postId: postId, parentCommentId: parentCommentId, text: text, type: type, mediaName: mediaName, createdAt: createdAt, replyCount: replyCount)
    }
}

extension CommentDTO {
    init(from model: PostCommentModel) {
        self.id = model.id
        self.postId = model.postId
        self.parentCommentId = model.parentCommentId
        self.text = model.text
        self.type = model.type
        self.mediaName = model.mediaName
        self.createdAt = model.createdAt
        self.replyCount = model.replyCount
    }
}
