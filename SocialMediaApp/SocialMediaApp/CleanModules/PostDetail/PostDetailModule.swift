//
//  PostDetailModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 16/09/2025.
//

class PostDetailModule {
    
    func generatePostDetailScreen(post: PostEntity) -> PostDetailScreen {
        PostDetailScreen(postDetailViewModel: self.generatePostDetailViewModel(post: post))
    }
    
    private func generatePostDetailViewModel(post: PostEntity) -> PostDetailViewModel {
        PostDetailViewModel(post: post)
    }
}
