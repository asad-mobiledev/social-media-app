//
//  SendMediaViewModel.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 10/09/2025.
//
import Foundation
import Combine
import UIKit


class SendMediaViewModel: ObservableObject {
    private let sendMediaUseCase: SendMediaUseCase
    @Published var errorMessage = ""
    @Published var isLoading = false
    private let router: Router
    private let postsListingViewModel: PostsListingViewModel
    
    init(sendMediaUseCase: SendMediaUseCase, router: Router, postsListingViewModel: PostsListingViewModel) {
        self.sendMediaUseCase = sendMediaUseCase
        self.router = router
        self.postsListingViewModel = postsListingViewModel
    }
    
    func post(mediaType: MediaType, mediaURL: URL?) {
        Task {
            await MainActor.run { isLoading = true }
            do {
                let postEntity = try await sendMediaUseCase.sendMedia(mediaType: mediaType, mediaURL: mediaURL)
                await postsListingViewModel.addNewPost(post: postEntity)
                await self.router.dismissSheet()
            } catch {
                await MainActor.run { self.errorMessage = error.localizedDescription }
            }
            await MainActor.run { isLoading = false }
        }
    }
}
