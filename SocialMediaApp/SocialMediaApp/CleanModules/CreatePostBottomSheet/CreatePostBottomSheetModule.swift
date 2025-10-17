//
//  UploadMediaBottomSheetModule.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 15/09/2025.
//

class CreatePostBottomSheetModule {
    
    func generateCreatePostBottomSheet() -> CreatePostBottomSheet {
        CreatePostBottomSheet(createPostBottomSheetViewModel: self.generateCreatePostsBottomSheetViewModel())
    }
    
    private func generateCreatePostsBottomSheetViewModel() -> ImportMediaBottomSheetViewModel {
        ImportMediaBottomSheetViewModel()
    }
}
