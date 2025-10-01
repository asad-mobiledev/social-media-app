//
//  PostDetailModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 16/09/2025.
//

class PostCommentModule {
    
    private let apiDataTransferService: DataTransferService
    private let databaseService: DatabaseService
    private let fileService: FileService
    
    init(apiDataTransferService: DataTransferService, databaseService: DatabaseService, fileService: FileService) {
        self.apiDataTransferService = apiDataTransferService
        self.databaseService = databaseService
        self.fileService = fileService
    }
    
    func generatePostCommentScreen(post: PostEntity) -> PostCommentsScreen {
        PostCommentsScreen(postCommentsViewModel: self.generatePostCommentViewModel(post: post), commentMediaBottomSheetViewModel: generateImportMediaBottomSheetViewModel())
    }
    
    private func generateImportMediaBottomSheetViewModel() -> ImportMediaBottomSheetViewModel {
        ImportMediaBottomSheetViewModel()
    }
    
    private func generatePostCommentViewModel(post: PostEntity) -> PostCommentsViewModel {
        PostCommentsViewModel(post: post, postCommentUseCase: generatePostCommentUseCase(), paginationPolicy: generateFetchCommentsPaginationPolicy())
    }
    
    private func generateFetchCommentsPaginationPolicy() -> PaginationPolicy {
        DefaultPaginationPolicy(itemsPerPage: 5)
    }
    
    private func generatePostCommentUseCase() -> PostCommentUseCase {
        DefaultPostCommentUseCase(repository: generatePostCommentRepository())
    }
    
    private func generatePostCommentRepository() -> PostCommentRepository {
        DefaultPostCommentRepository(filesRepository: fileService, networkRepository: generateNetworkRepository(), databaseService: databaseService)
    }
    
    private func generateNetworkRepository() -> NetworkRepository {
        return DefaultNetworkRepository(apiDataTransferService: apiDataTransferService)
    }
}
