//
//  HomeScreenViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 08/09/2025.
//

import Foundation

class PostsListingViewModel: ObservableObject {
    private let postsListingUseCase: PostsListingUseCase
    @Published var posts: [PostEntity] = []
    @Published var errorMessage: String = ""
    
    
    init(postsListingUseCase: PostsListingUseCase) {
        self.postsListingUseCase = postsListingUseCase
    }
    
    func fetchPosts() async {
        do {
            let posts = try await postsListingUseCase.fetchPosts()
            await MainActor.run {
                self.posts = posts
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
            }
        }
    }
}
