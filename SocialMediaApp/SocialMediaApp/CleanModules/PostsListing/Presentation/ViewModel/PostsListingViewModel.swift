//
//  HomeScreenViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/09/2025.
//

import Foundation
import Combine

class PostsListingViewModel: ObservableObject {
    private let postsListingUseCase: PostsListingUseCase
    private let paginationPolicy: PostsPaginationPolicy
    @Published var posts: [PostEntity] = []
    var lastFetchedPostsCount = -1
    @Published var errorMessage: String = ""
    @Published var isLoading = false
    private let pageLimit = 5
    var refreshing = false
    private var cancellables = Set<AnyCancellable>()
    
    init(postsListingUseCase: PostsListingUseCase, paginationPolicy: PostsPaginationPolicy) {
        self.postsListingUseCase = postsListingUseCase
        self.paginationPolicy = paginationPolicy
        
        NotificationCenter.default.publisher(for: .didCreatePost)
            .compactMap { $0.object as? PostEntity }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newPost in
                self?.posts.insert(newPost, at: 0)
            }
            .store(in: &cancellables)
    }
    
    func fetchPosts(isRefreshing: Bool = false) async {
        guard canHaveMorePosts() else { return }
        guard !isLoading else { return }
        await MainActor.run {
            isLoading = true
        }
        do {
            var startIndex = posts.last?.date
            if isRefreshing {
                startIndex = nil
            }
            let posts = try await postsListingUseCase.fetchPosts(limit: 5, startAt: startIndex)
            lastFetchedPostsCount = posts.count
            await MainActor.run {
                if isRefreshing {
                    self.posts = []
                }
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
            errorMessage = ""
        }
        await fetchPosts(isRefreshing: true)
    }
    
    private func canHaveMorePosts() -> Bool {
        lastFetchedPostsCount != 0
    }
}
