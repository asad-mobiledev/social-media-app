//
//  GalleryPickerView.swift
//  SocialMediaApp
//
//  Created by Asad Mehmood on 04/09/2025.
//

import SwiftUI
import PhotosUI

struct GalleryPickerView: View {
    @ObservedObject var viewModel: UploadMediaSheetViewModel
    @State private var selectedPickerItem: PhotosPickerItem? = nil
    
    @Binding var selectedImage: Image?
    @Binding var selectedVideoURL: URL?
    @Binding var loadState: LoadState
    @Binding var showErrorAlert: Bool
    @Binding var errorMessage: String
    
    var body: some View {
        VStack(spacing: 20) {
            PhotosPicker(selection: $selectedPickerItem,
                         matching: .any(of: [.images, .videos]),
                         photoLibrary: .shared()) {
                
                HStack(spacing: 12) {
                    Image(systemName: Images.gallery)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.primary)

                    Text(AppText.selectFromGallery)
                        .foregroundColor(.black)
                        .font(.title3)

                    Spacer()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal,10)
            }
        }
        .onChange(of: selectedPickerItem) { _, newItem in
            handlePickerChange(newItem)
        }
        .alert(AppText.error, isPresented: $showErrorAlert) {
            Button(AppText.OK) {
                showErrorAlert = false
            }
        } message: {
            Text(errorMessage)
        }
    }
    
    func handlePickerChange(_ item: PhotosPickerItem?) {
        guard let item = item else { return }
        
        Task {
            loadState = .loading
            await viewModel.loadMedia(from: item)
        }
    }
}

#Preview {
//    GalleryPickerView()
}
