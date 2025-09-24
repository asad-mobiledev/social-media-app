//
//  NetworkRepository.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 11/09/2025.
//

protocol NetworkRepository {
    func createPost(mediaType: MediaType, mediaName: String) async throws -> PostDTO
    func getPosts(limit: Int, startAt: String?) async throws -> [PostDTO]
}
