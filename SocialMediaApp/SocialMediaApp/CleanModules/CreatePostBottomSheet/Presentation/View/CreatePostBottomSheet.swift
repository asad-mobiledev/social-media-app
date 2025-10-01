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
    @ObservedObject var createPostBottomSheetViewModel: ImportMediaBottomSheetViewModel
    
    var body: some View {
        ZStack {
            if !createPostBottomSheetViewModel.loadState.isURLLoaded {
                appDIContainer.importMediaBottomSheet(importMediaBottomSheetViewModel: createPostBottomSheetViewModel)
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
