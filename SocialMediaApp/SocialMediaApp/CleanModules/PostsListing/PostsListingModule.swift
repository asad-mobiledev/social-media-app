//
//  Postsisting.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

class PostsListingModule {
    
    private let apiDataTransferService: DataTransferService
    
    init(apiDataTransferService: DataTransferService) {
        self.apiDataTransferService = apiDataTransferService
    }
    
    func generatePostsListingScreen() -> PostsListingScreen {
        PostsListingScreen(postsListingViewModel: generatePostsListingViewModel())
    }
    
    private func generatePostsListingViewModel() -> PostsListingViewModel {
        PostsListingViewModel(postsListingUseCase: generatePostsListingUseCase(), paginationPolicy: DefaultPostsPaginationPolicy(itemsPerPage: 5))
    }
    
    private func generatePostsListingUseCase() -> PostsListingUseCase {
        DefaultPostsListingUseCase(repository: generatePostsListingRepository())
    }
    private func generatePostsListingRepository() -> PostsListingRepository {
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
