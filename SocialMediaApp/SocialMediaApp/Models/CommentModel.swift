//
//  CommentModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//
import Foundation

enum CommentType {
    case text, image, audio, video
}
struct CommentModel: Identifiable {
    let id = UUID()
    let content: String
    var replies: [CommentModel] = []
    var depth = 0
    let type: CommentType
}

