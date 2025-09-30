//
//  PostCommentModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 29/09/2025.
//

import SwiftData
import Foundation

@Model
final class PostCommentModel {
    var id: String
    var postId: String
    var parentCommentId: String?
    var text: String?
    var type: CommentType.RawValue
    var mediaName: String?
    var createdAt: String
    var replyCount: String?
    var depth: String?
    var parentCommentDepth: String?
    
    init(id: String, postId: String, parentCommentId: String?, text: String?, type: CommentType.RawValue, mediaName: String?, createdAt: String, replyCount: String?, depth: String?, parentCommentDepth: String?) {
        self.id = id
        self.postId = postId
        self.parentCommentId = parentCommentId
        self.text = text
        self.type = type
        self.mediaName = mediaName
        self.createdAt = createdAt
        self.replyCount = replyCount
        self.depth = depth
        self.parentCommentDepth = parentCommentDepth
    }
}
