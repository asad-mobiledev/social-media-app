//
//  PostEntity.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

import Foundation

struct PostEntity: Identifiable, Equatable {
    var id: String
    var postType: MediaType
    var fileURL: URL?
    var date: String
}
