//
//  Untitled.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

protocol PostsListingUseCase {
    func fetchPosts(limit: Int, startAt: String?) async throws -> [PostEntity]
}

final class DefaultPostsListingUseCase: PostsListingUseCase {
    
    private let repository: PostsListingRepository
    
    init(repository: PostsListingRepository) {
        self.repository = repository
    }
    
    func fetchPosts(limit: Int, startAt: String? = nil) async throws -> [PostEntity] {
        let postDTOs = try await repository.getPosts(limit: limit, startAt: startAt)
        return postDTOs.map { $0.toEntity() }
    }
}
