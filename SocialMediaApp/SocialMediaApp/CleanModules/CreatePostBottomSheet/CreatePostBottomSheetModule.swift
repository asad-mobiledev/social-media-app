//
//  UploadMediaBottomSheetModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

class CreatePostBottomSheetModule {
    private let apiDataTransferService: DataTransferService
    private let databaseService: DatabaseService
    private let fileService: FileService
    
    init(apiDataTransferService: DataTransferService, databaseService: DatabaseService, fileService: FileService) {
        self.apiDataTransferService = apiDataTransferService
        self.databaseService = databaseService
        self.fileService = fileService
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
        DefaultPostsRepository(filesRepository: fileService, networkRepository: generateNetworkRepository(), databaseService: databaseService)
    }
    
    private func generateNetworkRepository() -> NetworkRepository {
        return DefaultNetworkRepository(apiDataTransferService: apiDataTransferService)
    }
}
