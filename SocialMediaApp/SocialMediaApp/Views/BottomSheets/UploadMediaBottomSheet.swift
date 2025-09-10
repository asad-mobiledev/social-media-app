//
//  UploadMediaBottomSheet.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI
import UniformTypeIdentifiers

struct UploadMediaBottomSheet: View {
    @StateObject private var uploadMediaSheetViewModel = UploadMediaSheetViewModel()
    
    var body: some View {
        ZStack {
            if !uploadMediaSheetViewModel.loadState.isURLLoaded && !uploadMediaSheetViewModel.loadState.isImageLoaded {
                ZStack {
                    VStack(spacing: 10) {
                        
                        GalleryPickerView(viewModel: uploadMediaSheetViewModel, loadState: $uploadMediaSheetViewModel.loadState, showErrorAlert: $uploadMediaSheetViewModel.showErrorAlert, errorMessage: $uploadMediaSheetViewModel.errorMessage)
                        
                        UploadMediaListRow(row: ListRowModel(title: AppText.selectFromFiles, imageName: Images.file, action: {
                            uploadMediaSheetViewModel.isImporting = true
                        }))
                        .fileImporter(
                            isPresented: $uploadMediaSheetViewModel.isImporting,
                            allowedContentTypes: [
                                .image,
                                .movie,
                                .audio
                            ],
                            allowsMultipleSelection: false
                        ) { result in
                            uploadMediaSheetViewModel.updateData(result)
                        }
                    }
                    if uploadMediaSheetViewModel.isLoading {
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
                if let type = uploadMediaSheetViewModel.resolvedMediaType {
                    SendMediaView(loadState: $uploadMediaSheetViewModel.loadState, mediaType: type, image: uploadMediaSheetViewModel.resolvedUIImage, mediaURL: uploadMediaSheetViewModel.resolvedMediaURL)
                } else {
                    EmptyView().onAppear {
                        uploadMediaSheetViewModel.loadState = .failed
                    }
                }
            }
        }
        .alert(AppText.error, isPresented: $uploadMediaSheetViewModel.showErrorAlert) {
            Button(AppText.OK) {
                uploadMediaSheetViewModel.loadState = .unknown
            }
        } message: {
            Text(uploadMediaSheetViewModel.errorMessage)
        }
        .animation(.easeInOut, value: uploadMediaSheetViewModel.isLoading)
    }
}

#Preview {
    UploadMediaBottomSheet()
}
