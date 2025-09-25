//
//  Post.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/09/2025.
//
import SwiftData
import Foundation

@Model
final class PostModel {
    var id: String
    var postType: MediaType.RawValue
    var mediaName: String
    var date: String
    
    init(id: String, postType: MediaType.RawValue, mediaName: String, date: String) {
        self.id = id
        self.postType = postType
        self.mediaName = mediaName
        self.date = date
    }
}
