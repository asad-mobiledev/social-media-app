//
//  SendMediaModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 16/09/2025.
//

import SwiftUI

class SendMediaModule {
    private let apiDataTransferService: DataTransferService
    
    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
    
    func generateSendMediaView(attachement: MediaAttachment, loadState: Binding<LoadState>) -> SendMediaView {
        return SendMediaView(sendMediaViewModel: generateSendMediaViewModel(), loadState: loadState, mediaAttachement: attachement)
    }
    
    private func generateSendMediaViewModel() -> SendMediaViewModel {
        SendMediaViewModel(sendMediaUseCase: generateSendMediaUseCase())
    }
    
    private func generateSendMediaUseCase() -> SendMediaUseCase {
        DefaultSendMediaUseCase(repository: generateSendMediaRepository())
    }
    
    private func generateSendMediaRepository() -> PostsListingRepository {
        DefaultPostsRepository(filesRepository: generateFilesRepository(), networkRepository: generateNetworkRepository())
    }
    
    // refactor it at end to use only one instance of FilesRepo
    private func generateFilesRepository() -> FileService {
        return DefaultFileService()
    }
    
    // refactor it at end to use only one instance of FilesRepo
    private func generateNetworkRepository() -> NetworkRepository {
        return DefaultNetworkRepository(apiDataTransferService: apiDataTransferService)
    }
}
