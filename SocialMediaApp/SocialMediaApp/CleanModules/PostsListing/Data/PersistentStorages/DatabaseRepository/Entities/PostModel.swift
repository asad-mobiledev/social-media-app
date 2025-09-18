//
//  Post.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/09/2025.
//
import SwiftData

@Model
class PostModel {
    var postType: MediaType.RawValue
    var mediaName: String
    var time: String
    
    init(postType: MediaType.RawValue, mediaName: String, time: String) {
        self.postType = postType
        self.mediaName = mediaName
        self.time = time
    }
}
