//
//  HomeScreenViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/09/2025.
//

import Foundation

class PostsListingViewModel: ObservableObject {
    private let postsListingUseCase: PostsListingUseCase
    private let paginationPolicy: PostsPaginationPolicy
    @Published var posts: [PostEntity] = []
    @Published var errorMessage: String = ""
    @Published var isLoading = false
    private let pageLimit = 5
    
    init(postsListingUseCase: PostsListingUseCase, paginationPolicy: PostsPaginationPolicy) {
        self.postsListingUseCase = postsListingUseCase
        self.paginationPolicy = paginationPolicy
    }
    
    func fetchPosts() async {
        guard canHaveMorePosts() else { return }
        guard !isLoading else { return }
        await MainActor.run {
            isLoading = true
        }
        do {
            let posts = try await postsListingUseCase.fetchPosts(limit: 5, startAt: posts.last?.date)
            await MainActor.run {
                self.posts += posts
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
        }
        await MainActor.run {
            isLoading = false
        }
    }
    
    func refreshPosts() async {
        await MainActor.run {
            posts = [] 
            errorMessage = ""
        }
        await fetchPosts()
    }
    
    private func canHaveMorePosts() -> Bool {
        posts.count % paginationPolicy.itemsPerPage == 0
    }
}
