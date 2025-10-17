//
//  Postsisting.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

class PostsListingModule {
    
    private let apiDataTransferService: DataTransferService
    private let databaseService: DatabaseService
    private let fileService: FileService
    
    init(apiDataTransferService: DataTransferService, databaseService: DatabaseService, fileService: FileService) {
        self.apiDataTransferService = apiDataTransferService
        self.databaseService = databaseService
        self.fileService = fileService
    }
    
    func generatePostsListingScreen() -> PostsListingScreen {
        PostsListingScreen(postsListingViewModel: self.generatePostsListingViewModel())
    }
    
    private func generatePostsListingViewModel() -> PostsListingViewModel {
        PostsListingViewModel(postsListingUseCase: generatePostsListingUseCase(), paginationPolicy: DefaultPaginationPolicy(itemsPerPage: 5))
    }
    
    private func generatePostsListingUseCase() -> PostsListingUseCase {
        DefaultPostsListingUseCase(repository: generatePostsListingRepository())
    }
    private func generatePostsListingRepository() -> PostsListingRepository {
        DefaultPostsRepository(filesRepository: fileService, networkRepository: generateNetworkRepository(), databaseService: databaseService)
    }
    
    private func generateNetworkRepository() -> NetworkRepository {
        return DefaultNetworkRepository(apiDataTransferService: apiDataTransferService)
    }
}
