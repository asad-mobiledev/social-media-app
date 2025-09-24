//
//  PostDTO.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/09/2025.
//

import Foundation

struct PostDTO: Codable,Identifiable {
    var id: String?
    var postType: MediaType.RawValue
    var mediaName: String
    var date: String
    
    // A custom initializer that maps the verbose Firestore data.
    init?(from firestoreDocument: FirestoreDocument) {
        guard let id = firestoreDocument.name.components(separatedBy: "/").last,
              let postType = firestoreDocument.fields.postType?.stringValue,
              let mediaName = firestoreDocument.fields.mediaName?.stringValue,
              let date = firestoreDocument.fields.date?.stringValue else {
            return nil
        }
        
        self.id = id
        self.postType = postType
        self.mediaName = mediaName
        self.date = date
    }
    
    init(id: String? = UUID().uuidString, postType: String, mediaName: String, date: String) {
        self.id = id
        self.postType = postType
        self.mediaName = mediaName
        self.date = date
    }
}

extension PostDTO {
    init(from model: PostModel) {
        self.id = model.id
        self.postType = model.postType
        self.mediaName = model.mediaName
        self.date = model.date
    }
}

extension PostDTO {
    func toEntity() -> PostEntity {
        return PostEntity(
            id: id ?? UUID().uuidString,
            postType: MediaType(rawValue: postType)!,
            mediaName: mediaName,
            date: date
        )
    }
}

extension PostDTO {
    func toPostModel() -> PostModel {
        PostModel(
            id: self.id ?? UUID().uuidString,
            postType: self.postType,
            mediaName: self.mediaName,
            date: date
        )
    }
}

struct FirestoreValue: Codable {
    var stringValue: String?
    var integerValue: String?
    var booleanValue: Bool?
    var arrayValue: FirestoreArray?
    var mapValue: FirestoreMap?
    // Add other types as needed (timestampValue, doubleValue, etc.)
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
struct FirestoreFields: Codable {
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
struct FirestoreDocument: Codable {
    var name: String
    var fields: FirestoreFields
    var createTime: String
    var updateTime: String
}

/// A new wrapper struct to handle the top-level array format from the API.
struct FirestoreDocumentWrapper: Codable {
    let document: FirestoreDocument
}

