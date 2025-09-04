//
//  UploadMediaBottomSheet.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI
import UniformTypeIdentifiers

struct UploadMediaBottomSheet: View {
    
    // For Document files items
    @State private var isImporting = false
    @State private var selectedFileURL: URL?
    
    // Error Alert
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 10) {
            GalleryPickerView()
            
            UploadMediaListRow(row: ListRowModel(title: AppText.selectFromFiles, imageName: Images.file, action: {
                isImporting = true
            }))
            .fileImporter(
                isPresented: $isImporting,
                allowedContentTypes: [
                    .image,
                    .movie,
                    .audio
                ],
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    if let firstURL = urls.first {
                        selectedFileURL = firstURL
                    }
                case .failure(let error):
                    errorMessage = "\(AppText.failPickingDocument) \(error.localizedDescription)"
                    showErrorAlert = true
                }
            }
        }
        .alert(AppText.error, isPresented: $showErrorAlert) {
            Button(AppText.OK) {
                showErrorAlert = false
            }
        } message: {
            Text(errorMessage)
        }

    }
}

#Preview {
    UploadMediaBottomSheet()
}
