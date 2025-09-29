//
//  CommentModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 03/09/2025.
//
import Foundation

struct DummyCommentModel: Identifiable {
    let id = UUID()
    let content: String
    var replies: [DummyCommentModel] = []
    var depth = 0
    let type: CommentType
}

