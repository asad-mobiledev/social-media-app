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
        SendImageView(viewModel: self.generateImageViewModel(), imageURL: imageURL)
    }
    
    func generateNamedImageView(imageName: String) -> NamedImageView {
        NamedImageView(viewModel: self.generateImageViewModel(), imageName: imageName)
    }
    
    func generateImageCommentView(comment: CommentEntity, postCommentsViewModel: PostCommentsViewModel) -> ImageComment {
        ImageComment(viewModel: self.generateImageViewModel(), postCommentsViewModel: postCommentsViewModel, comment: comment)
    }
    
    private func generateImageViewModel() -> ImageViewModel {
        ImageViewModel(loadImageDataUseCase: generateImageUseCase())
    }
    
    private func generateImageUseCase() -> ImageUseCase {
        DefaultLoadImageDataUseCase(loadImageRepository: generateImageRepository())
    }
    private func generateImageRepository() -> ImageRepository {
        DefaultImageRepository(fileService: fileService)
    }
}
