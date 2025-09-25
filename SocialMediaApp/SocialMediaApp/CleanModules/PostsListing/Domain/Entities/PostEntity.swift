//
//  PostEntity.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

struct PostEntity: Identifiable, Equatable {
    var id: String
    var postType: MediaType
    var mediaName: String
    var date: String
}
