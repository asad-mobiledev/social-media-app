//
//  UploadMediaBottomSheetModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

class CreatePostBottomSheetModule {
    private let apiDataTransferService: DataTransferService
    
    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
    
    func generateCreatePostBottomSheet() -> CreatePostBottomSheet {
        CreatePostBottomSheet(createPostBottomSheetViewModel: self.generateCreatePostsBottomSheetViewModel())
    }
    
    private func generateCreatePostsBottomSheetViewModel() -> CreatePostBottomSheetViewModel {
        CreatePostBottomSheetViewModel()
    }
    
    private func generateCreatePostBottomSheetUseCase() -> CreatePostBottomSheetUseCase {
        DefaultCreatePostBottomSheetUseCase(repository: generateCreatePostBottomSheetRepository())
    }
    
    private func generateCreatePostBottomSheetRepository() -> PostsListingRepository {
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
