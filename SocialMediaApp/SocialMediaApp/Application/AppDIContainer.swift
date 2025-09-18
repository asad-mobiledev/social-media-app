//
//  AppDIContainer.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

import SwiftUI

class AppDIContainer {
    
    lazy private var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: AppConfiguration.baseURL)
        let session = DefaultNetworkSessionManager(session: SharedURLSession.shared)
        let networkManager = DefaultNetworkManager(config: config, sessionManager: session)
        return DefaultDataTransferService(networkManager: networkManager)
    }()
    
    func createPostsListingScreen() -> some View {
        let postsListingModule = PostsListingModule(apiDataTransferService: apiDataTransferService)
        return postsListingModule.generatePostsListingScreen()
    }
    
    func createPostBottomSheet() -> some View {
        let createPostBottomSheetModule = CreatePostBottomSheetModule(apiDataTransferService: apiDataTransferService)
        return createPostBottomSheetModule.generateCreatePostBottomSheet()
    }
    
    func createSendMediaView(attachement: MediaAttachment, loadState: Binding<LoadState>) -> some View {
        let sendMediaModule = SendMediaModule(apiDataTransferService: apiDataTransferService)
        return sendMediaModule.generateSendMediaView(attachement: attachement, loadState: loadState)
    }
    
    func createSendAudioView(audioURL: URL) -> some View {
        let playableModule = PlayableModule()
        return playableModule.generateSendAudioView(audioURL: audioURL)
    }
    
    func createPostDetailScreen(type: MediaType) -> some View {
        let postDetailModule = PostDetailModule()
        return postDetailModule.generatePostDetailScreen(type: type)
    }
    
    func createSendImageView(imageURL: URL) -> some View {
        let sendImageViewModule = ImageViewModule()
        return sendImageViewModule.generateSendImageView(imageURL: imageURL)
    }
    
    func createNamedImageView(imageName: String) -> some View {
        let sendImageViewModule = ImageViewModule()
        return sendImageViewModule.generateNamedImageView(imageName: imageName)
    }
    
    func createAudioPlayerView(resourceName: String? = nil) -> some View {
        let playableModule = PlayableModule()
        return playableModule.generateAudioPlayerView(resourceName: resourceName)
    }
    func createAudioPlayerView(audioURL: URL) -> some View {
        let playableModule = PlayableModule()
        return playableModule.generateAudioPlayerView(audioURL: audioURL)
    }
}
