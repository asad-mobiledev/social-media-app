//
//  NetworkRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 11/09/2025.
//

import Foundation

protocol NetworkRepository {
    func createPost(mediaType: MediaType, fileURL: URL) async throws -> PostDTO
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO]
}
