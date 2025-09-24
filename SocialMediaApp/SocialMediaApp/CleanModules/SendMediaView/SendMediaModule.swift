//
//  SendMediaModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 16/09/2025.
//

import SwiftUI

class SendMediaModule {
    private let apiDataTransferService: DataTransferService
    private let databaseService: DatabaseService
    private let fileService: FileService
    
    init(apiDataTransferService: DataTransferService, databaseService: DatabaseService, fileService: FileService) {
        self.apiDataTransferService = apiDataTransferService
        self.databaseService = databaseService
        self.fileService = fileService
    }
    
    func generateSendMediaView(attachement: MediaAttachment, loadState: Binding<LoadState>, router: Router) -> SendMediaView {
        return SendMediaView(sendMediaViewModel: generateSendMediaViewModel(router: router), loadState: loadState, mediaAttachement: attachement)
    }
    
    private func generateSendMediaViewModel(router: Router) -> SendMediaViewModel {
        SendMediaViewModel(sendMediaUseCase: generateSendMediaUseCase(), router: router)
    }
    
    private func generateSendMediaUseCase() -> SendMediaUseCase {
        DefaultSendMediaUseCase(repository: generateSendMediaRepository())
    }
    
    private func generateSendMediaRepository() -> PostsListingRepository {
        DefaultPostsRepository(filesRepository: fileService, networkRepository: generateNetworkRepository(), databaseService: databaseService)
    }
    
    private func generateNetworkRepository() -> NetworkRepository {
        return DefaultNetworkRepository(apiDataTransferService: apiDataTransferService)
    }
}
