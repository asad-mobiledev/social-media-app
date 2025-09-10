//
//  Post.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 09/09/2025.
//
import SwiftData

@Model
class PostEntity {
    var postType: MediaType.RawValue
    var urlString: String
    var time: String
    
    init(postType: MediaType.RawValue, urlString: String, time: String) {
        self.postType = postType
        self.urlString = urlString
        self.time = time
    }
}
