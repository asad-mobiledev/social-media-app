//
//  SendImageViewModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 18/09/2025.
//

import Foundation

class ImageViewModule {
    
    func generateSendImageView(imageURL: URL) -> SendImageView {
        SendImageView(viewModel: self.generateImageViewModel(), imageURL: imageURL)
    }
    
    func generateNamedImageView(imageName: String) -> NamedImageView {
        NamedImageView(viewModel: self.generateImageViewModel(), imageName: imageName)
    }
    
    private func generateImageViewModel() -> ImageViewModel {
        ImageViewModel(loadImageDataUseCase: generateImageUseCase())
    }
    
    private func generateImageUseCase() -> ImageUseCase {
        DefaultLoadImageDataUseCase(loadImageRepository: generateImageRepository())
    }
    private func generateImageRepository() -> ImageRepository {
        DefaultImageRepository(fileService: generateFilesRepository())
    }
    
    // refactor it at end to use only one instance of FilesRepo
    private func generateFilesRepository() -> FileService {
        return DefaultFileService()
    }
}
