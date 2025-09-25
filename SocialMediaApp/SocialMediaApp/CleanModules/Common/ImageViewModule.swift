//
//  SendImageViewModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 18/09/2025.
//

import Foundation

class ImageViewModule {
    private let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    func generateSendImageView(imageURL: URL) -> SendImageView {
        SendImageView(viewModel: self.generateImageViewModel(url: imageURL))
    }
    
    func generatePostImageView(url: URL) -> PostImageView {
        PostImageView(viewModel: self.generateImageViewModel(url: url))
    }
    
    private func generateImageViewModel(url: URL) -> ImageViewModel {
        ImageViewModel(loadImageDataUseCase: generateImageUseCase(), url: url)
    }
    
    private func generateImageUseCase() -> ImageUseCase {
        DefaultLoadImageDataUseCase(loadImageRepository: generateImageRepository())
    }
    private func generateImageRepository() -> ImageRepository {
        DefaultImageRepository(fileService: fileService)
    }
}
