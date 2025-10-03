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
    var commentsCount: String
    
    // A custom initializer that maps the verbose Firestore data.
    init?(from firestoreDocument: FirestorePostDocument) {
        guard let id = firestoreDocument.name.components(separatedBy: "/").last,
              let postType = firestoreDocument.fields.postType?.stringValue,
              let mediaName = firestoreDocument.fields.mediaName?.stringValue,
              let date = firestoreDocument.fields.date?.stringValue,
              let commentsCount = firestoreDocument.fields.commentsCount?.stringValue else {
            return nil
        }
        
        self.id = id
        self.postType = postType
        self.mediaName = mediaName
        self.date = date
        self.commentsCount = commentsCount
    }
    
    init(id: String? = UUID().uuidString, postType: String, mediaName: String, date: String, commentsCount: String) {
        self.id = id
        self.postType = postType
        self.mediaName = mediaName
        self.date = date
        self.commentsCount = commentsCount
    }
}

extension PostDTO {
    init(from model: PostModel) {
        self.id = model.id
        self.postType = model.postType
        self.mediaName = model.mediaName
        self.date = model.date
        self.commentsCount = String(model.commentsCount)
    }
}

extension PostDTO {
    func toEntity() -> PostEntity {
        return PostEntity(
            id: id ?? UUID().uuidString,
            postType: MediaType(rawValue: postType)!,
            mediaName: mediaName,
            date: date,
            commentsCount: Int(commentsCount)!
        )
    }
}

extension PostDTO {
    func toPostModel() -> PostModel {
        PostModel(
            id: self.id ?? UUID().uuidString,
            postType: self.postType,
            mediaName: self.mediaName,
            date: date,
            commentsCount: Int(self.commentsCount)!
        )
    }
}
