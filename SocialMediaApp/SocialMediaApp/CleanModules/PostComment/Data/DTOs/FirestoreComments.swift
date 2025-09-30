//
//  FirestoreComments.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 29/09/2025.
//

/// Represents a document's fields, where each key maps to a FirestoreValue.
struct FirestoreCommentFields: Codable {
    var id: FirestoreValue?
    var postId: FirestoreValue?
    var parentCommentId: FirestoreValue?
    var text: FirestoreValue?
    var type: FirestoreValue?
    var mediaName: FirestoreValue?
    var createdAt: FirestoreValue?
    var replyCount: FirestoreValue?
   
    enum CodingKeys: String, CodingKey {
        case id, postId, parentCommentId, text, type, mediaName, createdAt, replyCount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(FirestoreValue.self, forKey: .id)
        self.postId = try container.decodeIfPresent(FirestoreValue.self, forKey: .postId)
        self.parentCommentId = try container.decodeIfPresent(FirestoreValue.self, forKey: .parentCommentId)
        self.text = try container.decodeIfPresent(FirestoreValue.self, forKey: .text)
        self.type = try container.decodeIfPresent(FirestoreValue.self, forKey: .type)
        self.mediaName = try container.decodeIfPresent(FirestoreValue.self, forKey: .mediaName)
        self.createdAt = try container.decodeIfPresent(FirestoreValue.self, forKey: .createdAt)
        self.replyCount = try container.decodeIfPresent(FirestoreValue.self, forKey: .replyCount)
    }
}

/// The top-level document model returned by the Firestore REST API.
struct FirestoreCommentDocument: Codable {
    var name: String
    var fields: FirestoreCommentFields
    var createTime: String
    var updateTime: String
}

/// A new wrapper struct to handle the top-level array format from the API.
struct FirestoreCommentssDocumentWrapper: Codable {
    let document: FirestoreCommentDocument
}

