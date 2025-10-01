//
//  UploadMediaBottomSheet.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI
import UniformTypeIdentifiers

struct ImportMediaBottomSheet: View {
    @Environment(\.appDIContainer) private var appDIContainer
    @ObservedObject var importMediaBottomSheetViewModel: ImportMediaBottomSheetViewModel
    
    var body: some View {
        ZStack {
            ZStack {
                VStack(spacing: 10) {
                    
                    GalleryPickerView(loadState: $importMediaBottomSheetViewModel.loadState, errorMessage: $importMediaBottomSheetViewModel.errorMessage)
                    
                    CreatePostBottomSheetRow(row: ListRowModel(title: AppText.selectFromFiles, imageName: Images.file, action: {
                        importMediaBottomSheetViewModel.isImporting = true
                    }))
                    .fileImporter(
                        isPresented: $importMediaBottomSheetViewModel.isImporting,
                        allowedContentTypes: [
                            .image,
                            .movie,
                            .audio
                        ],
                        allowsMultipleSelection: false
                    ) { result in
                        importMediaBottomSheetViewModel.updateData(result)
                    }
                }
                if importMediaBottomSheetViewModel.isLoading {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .transition(.opacity)
                    
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .transition(.scale)
                }
            }
        }
        .alert(AppText.error, isPresented: $importMediaBottomSheetViewModel.showErrorAlert) {
            Button(AppText.OK) {
                importMediaBottomSheetViewModel.loadState = .unknown
            }
        } message: {
            Text(importMediaBottomSheetViewModel.errorMessage)
        }
        .animation(.easeInOut, value: importMediaBottomSheetViewModel.isLoading)
    }
}

#Preview {
    //    CreatePostBottomSheet()
}
