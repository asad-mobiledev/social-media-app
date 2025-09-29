//
//  FirestorePosts.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 29/09/2025.
//

struct FirestoreValue: Codable {
    var stringValue: String?
    var integerValue: String?
    var booleanValue: Bool?
    var arrayValue: FirestoreArray?
    var mapValue: FirestoreMap?
}

/// A container for Firestore's array values.
struct FirestoreArray: Codable {
    var values: [FirestoreValue]?
}

/// A container for Firestore's map values.
struct FirestoreMap: Codable {
    var fields: [String: FirestoreValue]?
}

/// Represents a document's fields, where each key maps to a FirestoreValue.
struct FirestorePostFields: Codable {
    var id: FirestoreValue?
    var postType: FirestoreValue?
    var mediaName: FirestoreValue?
    var date: FirestoreValue?
    
    enum CodingKeys: String, CodingKey {
        case id, postType, mediaName, date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(FirestoreValue.self, forKey: .id)
        self.postType = try container.decodeIfPresent(FirestoreValue.self, forKey: .postType)
        self.mediaName = try container.decodeIfPresent(FirestoreValue.self, forKey: .mediaName)
        self.date = try container.decodeIfPresent(FirestoreValue.self, forKey: .date)
    }
}

/// The top-level document model returned by the Firestore REST API.
struct FirestorePostDocument: Codable {
    var name: String
    var fields: FirestorePostFields
    var createTime: String
    var updateTime: String
}

/// A new wrapper struct to handle the top-level array format from the API.
struct FirestorePostsDocumentWrapper: Codable {
    let document: FirestorePostDocument
}

