//
//  AppDIContainer.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

import SwiftUI

class AppDIContainer {
    
    private let router: Router?
    private let databaseService: DatabaseService?
    private let fileService: FileService?
    private let apiDataTransferService: DataTransferService
    
    init(router: Router?, databaseService: DatabaseService?, fileService: FileService?) {
        self.router = router
        self.apiDataTransferService = {
            let config = ApiDataNetworkConfig(baseURL: AppConfiguration.baseURL)
            let session = DefaultNetworkSessionManager(session: SharedURLSession.shared)
            let networkManager = DefaultNetworkManager(config: config, sessionManager: session)
            return DefaultDataTransferService(networkManager: networkManager)
        }()
        self.databaseService = databaseService
        self.fileService = fileService
    }
    
    func isFullyinitialized() -> Bool {
        if router != nil && databaseService != nil && fileService != nil{
            return true
        }
        return false
    }
    
    
    // The screens for which you want that their states must persist whil rerendering their views, For example on listing screen we are presenting a bottom sheet and when bottom sheet present it will recall the whole logic. So this lazy var will make sure to return already initialized instance. And similarly you can use function if you don't want to persist UI state and you must use function becuase it will optimize memory use.
    
    // But in some cases when a view renders multiple times and in each iteration we want it's model class should be own by it and don't change you can use @StateObject for it's ViewModel instaed of @ObservedObject
    
    // Also we can use lazy closure to pass parameters
    lazy var postsListingScreen: PostsListingScreen = {
        let postsListingModule = PostsListingModule(apiDataTransferService: apiDataTransferService, databaseService: databaseService!, fileService: fileService!)
        return postsListingModule.generatePostsListingScreen()
    }()
    
    func createPostBottomSheet() -> some View {
        let createPostBottomSheetModule = CreatePostBottomSheetModule(apiDataTransferService: apiDataTransferService, databaseService: databaseService!, fileService: fileService!)
        return createPostBottomSheetModule.generateCreatePostBottomSheet()
    }
    
    func createSendMediaView(attachement: MediaAttachment, loadState: Binding<LoadState>) -> some View {
        let sendMediaModule = SendMediaModule(apiDataTransferService: apiDataTransferService, databaseService: databaseService!, fileService: fileService!)
        return sendMediaModule.generateSendMediaView(attachement: attachement, loadState: loadState, router: router!)
    }
    
    func createSendAudioView(audioURL: URL) -> some View {
        let playableModule = PlayableModule(fileService: fileService!)
        return playableModule.generateSendAudioView(audioURL: audioURL)
    }
    
    func createSendVideoView(videoURL: URL) -> some View {
        SendVideoView(videoURL: videoURL)
    }
    func createPostDetailScreen(type: MediaType) -> some View {
        let postDetailModule = PostDetailModule()
        return postDetailModule.generatePostDetailScreen(type: type)
    }
    
    func createSendImageView(imageURL: URL) -> some View {
        let sendImageViewModule = ImageViewModule(fileService: fileService!)
        return sendImageViewModule.generateSendImageView(imageURL: imageURL)
    }
    
    func createNamedImageView(imageName: String) -> some View {
        let sendImageViewModule = ImageViewModule(fileService: fileService!)
        return sendImageViewModule.generateNamedImageView(imageName: imageName)
    }
    
    func createAudioPlayerView(resourceName: String) -> some View {
        let playableModule = PlayableModule(fileService: fileService!)
        return playableModule.generateAudioPlayerView(resourceName: resourceName)
    }
    func createAudioPlayerView(audioURL: URL) -> some View {
        let playableModule = PlayableModule(fileService: fileService!)
        return playableModule.generateAudioPlayerView(audioURL: audioURL)
    }
    
    func createVideoPlayerView(resourceName: String) -> some View {
        let playableModule = PlayableModule(fileService: fileService!)
        return playableModule.generateVideoPlayerView(resourceName: resourceName)
    }
    func createVideoPlayerView(videoURL: URL) -> some View {
        let playableModule = PlayableModule(fileService: fileService!)
        return playableModule.generateVideoPlayerView(videoURL: videoURL)
    }
}
