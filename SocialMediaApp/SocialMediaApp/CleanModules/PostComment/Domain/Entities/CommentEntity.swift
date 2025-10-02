//
//  CommentModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 26/09/2025.
//

import Foundation

struct CommentEntity: Identifiable, Equatable {
    let id: String
    let postId: String
    let parentCommentId: String? // Comment replies will have non-nil value for this field.
    let text: String? // It could be nil if comment is some media type.
    let type: CommentType.RawValue
    var mediaName: String? // Media Name could be nil if comment is of text type.
    let createdAt: String
    let replyCount: String?
    let parentCommentDepth: String?
    let depth: String?
}

