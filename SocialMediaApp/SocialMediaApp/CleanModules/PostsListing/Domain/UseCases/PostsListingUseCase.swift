//
//  Untitled.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

protocol PostsListingUseCase {
    func fetchPosts() async throws -> [PostEntity]
}

final class DefaultPostsListingUseCase: PostsListingUseCase {
    
    private let repository: PostsListingRepository
    private let paginationPolicy: PostsPaginationPolicy
    private let lastCursor: String? = nil // We are using cursor based pagination like in Firebase Firestore.
    
    init(repository: PostsListingRepository, paginationPolicy: PostsPaginationPolicy) {
        self.repository = repository
        self.paginationPolicy = paginationPolicy
    }
    
    func fetchPosts() async throws -> [PostEntity] {
        let postDTOs = try await repository.getPosts(limit: 5, startAt: nil)
        return postDTOs.map { $0.toEntity() }
    }
}
