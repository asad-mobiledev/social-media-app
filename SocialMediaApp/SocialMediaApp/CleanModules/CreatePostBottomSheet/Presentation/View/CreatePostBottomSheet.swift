//
//  UploadMediaBottomSheet.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI
import UniformTypeIdentifiers

struct CreatePostBottomSheet: View {
    @Environment(\.appDIContainer) private var appDIContainer
    @ObservedObject var createPostBottomSheetViewModel: CreatePostBottomSheetViewModel
    
    var body: some View {
        ZStack {
            if !createPostBottomSheetViewModel.loadState.isURLLoaded {
                ZStack {
                    VStack(spacing: 10) {
                        
                        GalleryPickerView(viewModel: createPostBottomSheetViewModel, loadState: $createPostBottomSheetViewModel.loadState, showErrorAlert: $createPostBottomSheetViewModel.showErrorAlert, errorMessage: $createPostBottomSheetViewModel.errorMessage)
                        
                        CreatePostBottomSheetRow(row: ListRowModel(title: AppText.selectFromFiles, imageName: Images.file, action: {
                            createPostBottomSheetViewModel.isImporting = true
                        }))
                        .fileImporter(
                            isPresented: $createPostBottomSheetViewModel.isImporting,
                            allowedContentTypes: [
                                .image,
                                .movie,
                                .audio
                            ],
                            allowsMultipleSelection: false
                        ) { result in
                            createPostBottomSheetViewModel.updateData(result)
                        }
                    }
                    if createPostBottomSheetViewModel.isLoading {
                        Color.black.opacity(0.4)
                            .ignoresSafeArea()
                            .transition(.opacity)
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                            .transition(.scale)
                    }
                }
            } else {
                if let attachment = createPostBottomSheetViewModel.mediaAttachment {
                    appDIContainer.createSendMediaView(attachement: attachment, loadState: $createPostBottomSheetViewModel.loadState)
                } else {
                    EmptyView().onAppear {
                        createPostBottomSheetViewModel.loadState = .failed
                    }
                }
            }
        }
        .alert(AppText.error, isPresented: $createPostBottomSheetViewModel.showErrorAlert) {
            Button(AppText.OK) {
                createPostBottomSheetViewModel.loadState = .unknown
            }
        } message: {
            Text(createPostBottomSheetViewModel.errorMessage)
        }
        .animation(.easeInOut, value: createPostBottomSheetViewModel.isLoading)
    }
}

#Preview {
//    CreatePostBottomSheet()
}
